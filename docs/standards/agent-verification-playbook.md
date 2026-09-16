# Agent Verification & CI Playbook: Normative Standard

This document establishes the definitive, machine-actionable verification and testing playbook for **KosCharkh**. It serves as the operational standard for both human contributors and AI coding agents operating within this repository.

Every AI coding agent **MUST** execute and satisfy this automated audit suite prior to submitting pull requests, pushing commits, or concluding tasks. It synthesizes and enforces the architectural invariants and governance directives established across:
- [ADR 0001: Design System and UI Tokens Governance](../adr/0001-design-system-and-ui-tokens.md)
- [ADR 0002: State Management BLoC vs Cubit Boundaries and State Mutation Invariants](../adr/0002-state-management-bloc-vs-cubit-boundaries.md)
- [ADR 0003: Coordinate Isolation and Mapbox Contracts](../adr/0003-coordinate-isolation-and-mapbox-contracts.md)
- [ADR 0004: Isar Persistence and Cascade Rules](../adr/0004-isar-persistence-and-cascade-rules.md)
- [Navigation Math & Sensor Policies: Normative Standard](navigation-math-and-sensor-policies.md)

---

## 1. Verification Philosophy & Agent Execution Contract

### 1.1 The Operational Guarantee
Autonomous and semi-autonomous coding agents execute refactors, implement features, and produce documentation across KosCharkh. To guarantee architectural cohesion and prevent subtle regressions (such as design system drift, coordinate ordering inversions, domain coupling, or database desynchronization), agents operate under a strict execution contract:

1. **Mandatory Execution**: Prior to submitting changes, opening a pull request, or declaring task completion, the agent **MUST** run every stage of the verification pipeline in order.
2. **Zero-Tolerance Policy**: Any static analysis error, compiler warning, failing unit test, code generation drift, or architectural ripgrep audit violation constitutes an immediate task failure.
3. **No Unjustified Suppressions**: Adding `// ignore:` or `// ignore_for_file:` comments is strictly prohibited unless accompanied by an explicit issue tracker reference and architectural justification.
4. **Clean Code Generation**: Any change to persisted database models (`lib/src/core/storage/entities.dart`) must include the regenerated Isar schema code (`lib/src/core/storage/entities.g.dart`) in the exact same commit.

---

## 2. Step-by-Step Verification Pipeline

The verification pipeline consists of five deterministic stages:

```
┌──────────────────────────────┐
│  Stage 1: Static Analysis    │  flutter analyze
└──────────────┬───────────────┘
               │
┌──────────────▼───────────────┐
│  Stage 2: Codegen Drift Check│  dart run build_runner build + git diff
└──────────────┬───────────────┘
               │
┌──────────────▼───────────────┐
│  Stage 3: Automated Tests    │  flutter test
└──────────────┬───────────────┘
               │
┌──────────────▼───────────────┐
│  Stage 4: Ripgrep Audits     │  Composite ADR compliance scans (1-5)
└──────────────┬───────────────┘
               │
┌──────────────▼───────────────┐
│  Stage 5: Master CI Suite    │  One-shot composite audit verification
└──────────────────────────────┘
```

---

### Stage 1: Static Code Analysis

Analyzes Dart source files according to project lint rules defined in [`analysis_options.yaml`](../../analysis_options.yaml).

```bash
flutter analyze
```

- **Execution Shell**: PowerShell, Bash, or CI runner.
- **Acceptance Criteria**: Exit code `0` with the verbatim output:
  ```
  Analyzing koscharkh...
  No issues found!
  ```
- **Governing Standard**: Code exclusions are restricted exclusively to generated schema files (`**/*.g.dart`). Agents must resolve type mismatches, missing imports, unawaited futures, and dead code rather than suppressing them.

---

### Stage 2: Database Code Generation Drift Check

Ensures the Isar database entity definitions in [`lib/src/core/storage/entities.dart`](../../lib/src/core/storage/entities.dart) match the generated schema in [`lib/src/core/storage/entities.g.dart`](../../lib/src/core/storage/entities.g.dart).

```bash
dart run build_runner build --delete-conflicting-outputs
git diff --exit-code lib/src/core/storage/entities.g.dart
```

- **Execution Shell**: PowerShell, Bash, or CI runner.
- **Acceptance Criteria**: 
  - `dart run build_runner` completes with `[INFO] Succeeded`.
  - `git diff --exit-code` exits with code `0` (empty diff).
- **Governing Standard**: [ADR 0004 (Directives 6.1 & 6.2)](../adr/0004-isar-persistence-and-cascade-rules.md). If `git diff` produces output, schema modifications were made without running code generation, or generated changes were omitted from staging.

---

### Stage 3: Automated Unit & Math Policy Test Suite

Runs the full automated test suite located in [`test/`](../../test/) to verify business logic, mathematical formulas, and sensor fusion policies.

```bash
flutter test
```

- **Execution Shell**: PowerShell, Bash, or CI runner.
- **Acceptance Criteria**: Exit code `0` with zero failures across all test cases.
- **Formulas & Policies Verified**:
  - **Clock Formatting**: Verifies `formatClock` renders `mm:ss` representation, clamping negative durations to `0:00` and formatting multi-minute times (e.g., `1812s` $\to$ `30:12`).
  - **Fallback Route Generation**: Confirms `buildFallbackRoute` allocates route durations proportionally across walking legs according to distance, enforcing the minimum 60-second clamp.
  - **Mapbox Direction Parsing**: Confirms parsed GeoJSON routes preserve segment points, distance, duration, and step geometries.
  - **Cartesian Route Leg Projection**: Validates `projectLocationOntoLeg` computes the correct progress ratio $t \in [0.0, 1.0]$, cross-track displacement (`distanceFromRouteMeters`), and along-track remaining distance.
  - **Arrival Radius Policy**: Validates `WalkingRouteProgressPolicy.arrivalRadius(accuracy)` clamps dynamically between `minimumArrivalRadiusMeters` ($12.0\,\text{m}$) and `maximumArrivalRadiusMeters` ($18.0\,\text{m}$).
  - **Sensor & Location Reliability**: Confirms `WalkingRouteProgressPolicy.isReliable` rejects stale locations ($> 12\,\text{s}$ old) and inaccurate fixes ($> 25.0\,\text{m}$ horizontal accuracy).
  - **Theme Extension Integrity**: Confirms dark theme correctly exposes `KoscharkhColors`, `KoscharkhSpacing` (`xl: 24`), and `KoscharkhRadius` (`pill: 999`).

---

### Stage 4: Composite Architectural Ripgrep Audits

A suite of 5 targeted ripgrep (`rg`) audits that enforce repository ADR invariants. Each check must produce **zero matches** (exit code `1` in standard ripgrep).

#### Audit 1: UI Token & Design System Restrictions
- **Governing ADR**: [ADR 0001: Design System and UI Tokens Governance](../adr/0001-design-system-and-ui-tokens.md)
- **Purpose**: Catches direct Material palette references, hardcoded color hexes, unstyled Material buttons, raw text inputs, Material AppBars, Material navigation bars, and unmediated SVG picture invocations within presentation code.
- **Command**:
  ```bash
  rg --glob "lib/**/presentation/**.dart" \
    -e "Colors\." \
    -e "Color\(0x" \
    -e "\b(ElevatedButton|FilledButton|OutlinedButton|TextButton)\b" \
    -e "\b(TextField|TextFormField)\b" \
    -e "\b(AppBar|SliverAppBar)\b" \
    -e "\b(NavigationBar|BottomNavigationBar)\b" \
    -e "SvgPicture\.asset"
  ```
- **Acceptance Criteria**: Exit code `1` (0 matches).

#### Audit 2: Domain Layer Coordinate Decoupling
- **Governing ADR**: [ADR 0003: Coordinate Isolation and Mapbox Contracts](../adr/0003-coordinate-isolation-and-mapbox-contracts.md)
- **Purpose**: Prevents leaking third-party GIS packages (`package:latlong2`) or external coordinate structures (`LatLng`) into pure domain entities (`lib/**/domain/**.dart`).
- **Command**:
  ```bash
  rg --glob "lib/**/domain/**.dart" -e "package:latlong2" -e "\bLatLng\b"
  ```
- **Acceptance Criteria**: Exit code `1` (0 matches). Pure domain entities must exclusively use the domain `Coordinates` value object.

#### Audit 3: Mapbox REST URL Coordinate Inversion
- **Governing ADR**: [ADR 0003: Coordinate Isolation and Mapbox Contracts](../adr/0003-coordinate-isolation-and-mapbox-contracts.md)
- **Purpose**: Catches coordinate string interpolations in data network services that place Latitude before Longitude (`${latitude},${longitude}`), which triggers HTTP 422 errors and corrupted route calculations against Mapbox REST endpoints.
- **Command**:
  ```bash
  rg --glob "lib/**/data/**.dart" -e "\$\{.*latitude\},.*\$\{.*longitude\}"
  ```
- **Acceptance Criteria**: Exit code `1` (0 matches). All Mapbox REST URLs must adhere to Cartesian Longitude, Latitude order (`${longitude},${latitude}`).

#### Audit 4: Hardcoded Secret Detection
- **Governing ADR**: [ADR 0003: Coordinate Isolation and Mapbox Contracts](../adr/0003-coordinate-isolation-and-mapbox-contracts.md)
- **Purpose**: Prevents hardcoded Mapbox public tokens (`pk.eyJ...`) or secret tokens (`sk.eyJ...`) from leaking into the codebase.
- **Command**:
  ```bash
  rg -e "pk\.eyJ[a-zA-Z0-9_-]{20,}" -e "sk\.eyJ[a-zA-Z0-9_-]{20,}"
  ```
- **Acceptance Criteria**: Exit code `1` (0 matches). Tokens must be provided via `--dart-define` environment configuration and read through `AppConfig`.

#### Audit 5: Isar Singleton Identity Violation
- **Governing ADR**: [ADR 0004: Isar Persistence and Cascade Rules](../adr/0004-isar-persistence-and-cascade-rules.md)
- **Purpose**: Ensures that singleton collections (`ProfileRecord` and `ActiveRouteRecord`) never use `Isar.autoIncrement`, strictly maintaining fixed identity `Id id = 1;`.
- **Command**:
  ```bash
  rg --glob "lib/src/core/storage/entities.dart" -A 3 "class (ProfileRecord|ActiveRouteRecord)" | rg "autoIncrement"
  ```
- **Acceptance Criteria**: Exit code `1` (0 matches).

---

### Stage 5: Master Single-Line CI Audit Command

The following composite runner combines all architectural ripgrep audits into a unified execution block suitable for CI pipelines, Git pre-push hooks, or agent pre-flight checks:

```bash
# Composite Bash / Git-Bash Runner
rg --glob "lib/**/presentation/**.dart" -e "Colors\." -e "Color\(0x" -e "\b(ElevatedButton|FilledButton|OutlinedButton|TextButton)\b" -e "\b(TextField|TextFormField)\b" -e "\b(AppBar|SliverAppBar)\b" -e "\b(NavigationBar|BottomNavigationBar)\b" -e "SvgPicture\.asset" && echo "FAIL: UI Violations"
rg --glob "lib/**/domain/**.dart" -e "package:latlong2" -e "\bLatLng\b" && echo "FAIL: Domain LatLng Leak"
rg --glob "lib/**/data/**.dart" -e "\$\{.*latitude\},.*\$\{.*longitude\}" && echo "FAIL: Inverted Coordinates"
rg -e "pk\.eyJ[a-zA-Z0-9_-]{20,}" -e "sk\.eyJ[a-zA-Z0-9_-]{20,}" && echo "FAIL: Hardcoded Secret"
```

#### Git-Grep Alternative (Environments without `rg`)
For Windows PowerShell or constrained environments without `rg`:

```bash
git grep -E "Colors\.|Color\(0x|\b(ElevatedButton|FilledButton|OutlinedButton|TextButton)\b|\b(TextField|TextFormField)\b|\b(AppBar|SliverAppBar)\b|\b(NavigationBar|BottomNavigationBar)\b|SvgPicture\.asset" -- "lib/**/presentation/**.dart"
git grep -E "package:latlong2|\bLatLng\b" -- "lib/**/domain/**.dart"
git grep -E "\$\{.*latitude\},.*\$\{.*longitude\}" -- "lib/**/data/**.dart"
git grep -E "pk\.eyJ[a-zA-Z0-9_-]{20,}|sk\.eyJ[a-zA-Z0-9_-]{20,}"
```

---

## 3. Failure Remediation Matrix

When a verification check fails, agents must consult the following matrix to identify the root cause and execute the required corrective action:

| Failure Signature | Probable Cause | Corrective Action | Reference Authority |
|---|---|---|---|
| `Colors.*` or `Color(0x...)` found | Using raw Flutter palette or inline color literals in screen | Replace with semantic tokens from `context.colors.<token>` (e.g. `context.colors.primary`, `surfaceMuted`) | [ADR 0001](../adr/0001-design-system-and-ui-tokens.md) |
| `ElevatedButton` / `TextField` found | Using standard Material controls instead of design system widgets | Replace with `KosButton` (or `IconSquareButton`) and `KosTextInput` with `FieldLabel` | [ADR 0001](../adr/0001-design-system-and-ui-tokens.md) |
| `entities.g.dart` diff in git | Isar entity schema altered without running code generator | Execute `dart run build_runner build --delete-conflicting-outputs` and stage `entities.g.dart` | [ADR 0004](../adr/0004-isar-persistence-and-cascade-rules.md) |
| `package:latlong2` in domain | Third-party `LatLng` used instead of domain `Coordinates` | Use pure domain `Coordinates` in domain entities; convert via `.toLatLng()` only at map or parser boundaries | [ADR 0003](../adr/0003-coordinate-isolation-and-mapbox-contracts.md) |
| `${latitude},${longitude}` in URL | Coordinate ordering inverted for Mapbox REST API call | Reformat interpolation to Cartesian Longitude, Latitude: `${item.longitude},${item.latitude}` | [ADR 0003](../adr/0003-coordinate-isolation-and-mapbox-contracts.md) |
| `autoIncrement` on Singleton | Incorrect ID generator assigned to `ProfileRecord` or `ActiveRouteRecord` | Replace `Id id = Isar.autoIncrement;` with explicit fixed singleton key `Id id = 1;` | [ADR 0004](../adr/0004-isar-persistence-and-cascade-rules.md) |
| Route progress test failure | Aligned segment calculation, arrival radius, or freshness constant altered | Cross-check implementation constants against the parameter registry table | [Navigation Math & Sensor Policies](navigation-math-and-sensor-policies.md) |

---

## 4. Agent Pre-Completion Checklist

Before reporting task completion, pushing commits, or requesting pull request reviews, every agent **MUST** independently check off each item in this verification list:

- [ ] **Static Analysis Clean**: `flutter analyze` passes with zero errors, warnings, or lints (`No issues found!`).
- [ ] **Schema in Sync**: `dart run build_runner build --delete-conflicting-outputs` executed; `git diff --exit-code lib/src/core/storage/entities.g.dart` is clean.
- [ ] **Unit Tests Passing**: `flutter test` executes with zero failures.
- [ ] **UI Token Governance**: Audit 1 confirms zero raw Material colors, buttons, text fields, AppBars, or raw SVGs in presentation code.
- [ ] **Domain Decoupling**: Audit 2 confirms no `package:latlong2` or `LatLng` imports leak into pure domain models.
- [ ] **Mapbox REST Contract**: Audit 3 confirms no inverted `${latitude},${longitude}` coordinate pairs exist in data services.
- [ ] **Secret Hygiene**: Audit 4 confirms no hardcoded Mapbox tokens (`pk.eyJ...` or `sk.eyJ...`) exist in any file.
- [ ] **Isar Singleton Integrity**: Audit 5 confirms `ProfileRecord` and `ActiveRouteRecord` enforce `Id id = 1;`.
- [ ] **Markdown Integrity**: All documentation links point to valid repository-relative paths without machine-specific absolute file URIs.
