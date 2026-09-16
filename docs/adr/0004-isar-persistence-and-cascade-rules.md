---
id: 0004-isar-persistence-and-cascade-rules
title: Isar Persistence and Cascade Rules
status: accepted
applies_to: ["lib/src/core/storage/**", "lib/src/features/**/data/**"]
supersedes: null
superseded_by: null
tags: [database, isar, persistence, cascade]
---

# ADR 0004: Isar Persistence and Cascade Rules

## Status
**Accepted** (2026-09-16)

## Context & Problem Statement

KosCharkh utilizes embedded Isar NoSQL for offline-first local data storage. Because Isar relation wrappers (`IsarLink` / `IsarLinks`) are intentionally banned to maintain pure, immutable domain entities ([`Charkh`](../../lib/src/features/charkhs/domain/charkh.dart), [`Destination`](../../lib/src/features/destinations/domain/destination.dart), [`Profile`](../../lib/src/features/profile/domain/profile.dart)), entity relationships rely on manual business foreign keys (`charkhStableId`).

Without strict structural invariants and transaction discipline, this architecture risks critical failure modes:
1. **Orphan Records & Ghost Data**: Deleting a `CharkhRecord` without purging associated `DestinationRecord` entries leaves dangling waypoints.
2. **Stale Cache Polylines**: Deleting or mutating a Charkh without clearing its `RouteCacheRecord` causes Mapbox/fallback polyline mismatches when a route is reused or re-indexed.
3. **Singleton Identity Corruption**: Using `Isar.autoIncrement` on `ProfileRecord` or `ActiveRouteRecord` allows multiple profile or active route records to accumulate, breaking the application's single-session state assumption.
4. **Waypoint Ordering Degradation**: Inserting waypoints without 0-indexed contiguous positions breaks leg projection and distance estimation in `WalkingRouteProgressPolicy`.
5. **Domain Architecture Contamination**: Leaking `package:isar/isar.dart` annotations or collections into the domain layer destroys immutability and testability.

This ADR defines normative RFC 2119 directives governing persistence schemas, transaction boundaries, cascade invariants, and singleton lifecycles.

---

## Normative Directives (RFC 2119)

### 1. Singleton Collection Identity
1.1. `ProfileRecord` and `ActiveRouteRecord` **MUST** explicitly assign primary key `id = 1`.  
1.2. Developers **MUST NOT** assign `Isar.autoIncrement` to `ProfileRecord` or `ActiveRouteRecord`.  
1.3. Repository operations upserting singletons **MUST** explicitly re-assign `record.id = 1` before invoking `put(record)`.  
1.4. Active route teardown (`clearActiveRoute()`) **MUST** delete record `id = 1` via `activeRouteRecords.delete(1)`.

### 2. Business Keying & Foreign Key References
2.1. Cross-collection relationships **MUST** reference the business key `stableId` (`String`), never the internal Isar integer `id`.  
2.2. All `stableId` properties **MUST** be annotated with `@Index(unique: true, replace: true)`.  
2.3. Child entities (`DestinationRecord`, `CharkhHistoryRecord`) **MUST** declare `@Index() late String charkhStableId`.  
2.4. Route caches (`RouteCacheRecord`) **MUST** enforce a strict 1:1 relationship with `@Index(unique: true, replace: true) late String charkhStableId`.

### 3. Mandatory Atomic Cascade Operations
3.1. Calling `deleteCharkh(stableId)` **MUST** atomically execute the deletion of:
  - The `CharkhRecord` matching `stableId`.
  - All `DestinationRecord` entries where `charkhStableId == stableId`.
  - The associated `RouteCacheRecord` where `charkhStableId == stableId`.  
3.2. Cascade deletions **MUST** execute within a single `isar.writeTxn(() async { ... })` block. Partial deletions outside a transaction are strictly prohibited.  
3.3. `CharkhHistoryRecord` entries **MUST NOT** be cascade-deleted when a Charkh is deleted; historical audit records must remain permanent.

### 4. Sequential Waypoint Re-indexing
4.1. When persisting a Charkh's destinations via `saveCharkh(Charkh)`, existing `DestinationRecord` entries matching `charkhStableId` **MUST** be purged first, followed by re-inserting destinations with strictly contiguous 0-based `position` integers ($0, 1, 2, \dots, N-1$).  
4.2. Developers **MUST NOT** append new destinations with arbitrary or non-sequential position values.

### 5. Domain Model Isolation
5.1. Domain entities (`lib/src/features/**/domain/**.dart`) **MUST NOT** import `package:isar/isar.dart`.  
5.2. Domain entities **MUST NOT** use Isar collection decorators or mutable state.

### 6. Build Runner & Code Generation
6.1. Any modification to [`lib/src/core/storage/entities.dart`](../../lib/src/core/storage/entities.dart) **MUST** be followed by running `dart run build_runner build --delete-conflicting-outputs`.  
6.2. The generated [`lib/src/core/storage/entities.g.dart`](../../lib/src/core/storage/entities.g.dart) **MUST** be committed to version control in the exact same commit as `entities.dart`.

---

## Side-by-Side Dart Code Examples

### 1. Singleton Upsert Pattern

```dart
// ❌ INCORRECT: Uses autoIncrement or omits fixed id=1
@collection
class ActiveRouteRecord {
  Id id = Isar.autoIncrement; // VIOLATION: Generates duplicate sessions
  late String charkhStableId;
}

// In Repository:
await isar.writeTxn(() async {
  await isar.activeRouteRecords.put(ActiveRouteRecord()..charkhStableId = id);
});

// ✅ CORRECT: Fixed id=1 explicitly enforced
@collection
class ActiveRouteRecord {
  Id id = 1; // REQUIRED: Fixed singleton key
  late String charkhStableId;
}

// In ActiveRouteRepository:
await isar.writeTxn(() async {
  final record = (await isar.activeRouteRecords.get(1)) ?? ActiveRouteRecord();
  record
    ..id = 1 // MANDATORY
    ..charkhStableId = charkhStableId
    ..startedAt = startedAt;
  await isar.activeRouteRecords.put(record);
});
```

### 2. Charkh Cascade Deletion

```dart
// ❌ INCORRECT: Deletes only the parent record, leaving orphan waypoints & caches
Future<void> deleteCharkh(String stableId) async {
  await isar.writeTxn(() async {
    await isar.charkhRecords.deleteByStableId(stableId); // VIOLATION: Orphans destinations & route cache
  });
}

// ✅ CORRECT: Atomically purges parent charkh, child destinations, and route cache
Future<void> deleteCharkh(String stableId) async {
  final destinationRecords = await _destinationRecordsFor(stableId);
  await isar.writeTxn(() async {
    await isar.charkhRecords.deleteByStableId(stableId);
    await isar.destinationRecords.deleteAll(
      destinationRecords.map((item) => item.id).toList(),
    );
    await isar.routeCacheRecords.deleteByCharkhStableId(stableId);
  });
}
```

### 3. Destination Re-indexing Pattern

```dart
// ❌ INCORRECT: Appends destinations with arbitrary indices, creating gaps
Future<void> saveCharkh(Charkh charkh) async {
  await isar.writeTxn(() async {
    for (final dest in charkh.destinations) {
      await isar.destinationRecords.put(dest.toRecord()); // VIOLATION: Gaps, duplicates, stale items
    }
  });
}

// ✅ CORRECT: Purges previous set and re-inserts with contiguous 0-based indexing
Future<void> saveCharkh(Charkh charkh) async {
  final existingDestinations = await _destinationRecordsFor(charkh.stableId);
  await isar.writeTxn(() async {
    // 1. Purge previous waypoints
    await isar.destinationRecords.deleteAll(
      existingDestinations.map((item) => item.id).toList(),
    );
    // 2. Insert fresh waypoints with strict 0-indexed positions
    for (var index = 0; index < charkh.destinations.length; index++) {
      final dest = charkh.destinations[index];
      await isar.destinationRecords.putByStableId(
        DestinationRecord()
          ..stableId = dest.stableId
          ..charkhStableId = charkh.stableId
          ..position = index // MANDATORY: Sequential 0-based integer
          ..name = dest.name
          ..latitude = dest.coordinates?.latitude
          ..longitude = dest.coordinates?.longitude;
      );
    }
  });
}
```

---

## Automated Verification & CI Rules

The following rules must be executed in CI and local pre-commit checks. Any violation constitutes a failing build.

### 1. Detect Illegal `autoIncrement` on Singletons
Flags violations of Rule 1.2:
```bash
rg --glob "lib/src/core/storage/entities.dart" -A 2 "class (ProfileRecord|ActiveRouteRecord)" | rg "autoIncrement"
```
*Expected Result*: Exit code 1 with zero output lines.

### 2. Detect Banned Isar Imports in Domain Layer
Flags violations of Rule 5.1:
```bash
rg --glob "lib/**/domain/**.dart" "package:isar"
```
*Expected Result*: Exit code 1 with zero output lines.

### 3. Verify Cascade Purge in `charkh_repository.dart`
Verifies compliance with Rule 3.1:
```bash
rg --glob "lib/src/features/charkhs/data/charkh_repository.dart" "destinationRecords\.deleteAll"
rg --glob "lib/src/features/charkhs/data/charkh_repository.dart" "routeCacheRecords\.deleteByCharkhStableId"
```
*Expected Result*: Both commands exit with code 0 (confirming purge calls exist).

---

### Composite CI Verification Command

```bash
rg --glob "lib/**/domain/**.dart" "package:isar"
```
*Expected Result*: Zero occurrences found.

#### Git Grep Equivalent (Windows / Environments without `rg`):
```bash
git grep -E "package:isar" -- "lib/**/domain/**.dart"
```
*Expected Result*: Exit code 1 with zero output lines.
