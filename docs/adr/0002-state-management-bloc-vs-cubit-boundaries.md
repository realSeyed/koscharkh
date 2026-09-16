---
id: 0002-state-management-bloc-vs-cubit-boundaries
title: State Management BLoC vs Cubit Boundaries and State Mutation Invariants
status: accepted
applies_to: ["lib/src/features/**/application/**", "lib/src/core/routing/**"]
supersedes: null
superseded_by: null
tags: [bloc, cubit, state-management, architecture, immutability]
---

# ADR 0002: State Management BLoC vs Cubit Boundaries and State Mutation Invariants

## Status
**Accepted** (2026-09-17)

## Context & Problem Statement

In Flutter applications employing `flutter_bloc`, architecture teams frequently struggle with two systemic issues that erode codebase stability over time:

1. **Architectural Drift & Boundary Confusion**:
   Developers often either:
   - **Overuse BLoCs** for trivial, synchronous, single-screen CRUD and form editing workflows. This introduces unnecessary ceremony (event definitions, handler dispatchers, boilerplate) for simple inputs like text edits or validation toggles.
   - **Misuse Cubits** for complex, asynchronous, multi-stream reactive domains. When handling real-time GPS locations, magnetometer headings, periodic countdown timers, and rate-limited persistence, Cubits degrade into brittle collections of ad-hoc async subscriptions and uncoordinated `emit()` invocations. This triggers race conditions, unhandled cancellations, missed transitions, and untraceable state mutations.

2. **The Nullable `copyWith` Defect (Field Clearing Invariant)**:
   In Dart, immutable state objects use `copyWith` to emit updated state copies. When a state property is nullable (e.g. `String? validationMessage`, `String? errorMessage`, `Coordinates? userLocation`, `RouteData? route`), writing a naive `copyWith` parameter signature creates a critical bug:
   ```dart
   // ❌ THE BUG: Cannot clear an existing error by passing null!
   MyState copyWith({String? errorMessage}) {
     return MyState(
       errorMessage: errorMessage ?? this.errorMessage, // Passing null retains the old error!
     );
   }
   ```
   If `errorMessage` already contains `"Network timeout"`, passing `null` to dismiss the error is ignored because `errorMessage ?? this.errorMessage` resolves back to the old string. Conversely, writing `errorMessage: errorMessage` unconditionally overwrites the field with `null` whenever `errorMessage` is omitted from the function call.

This Architecture Decision Record establishes clear RFC 2119 normative directives, enforceable boundary rules between BLoCs and Cubits, the mandatory private sentinel pattern for nullable state updates, side-by-side code examples, and automated ripgrep verification commands.

---

## Normative Directives (RFC 2119)

### 1. Cubit Operational Scope
1.1. Cubits **MUST** be used exclusively for:
- Single-screen CRUD operations (e.g. [`CharkhListCubit`](../../lib/src/features/charkhs/application/charkh_list_cubit.dart), [`DestinationLibraryCubit`](../../lib/src/features/destinations/application/destination_library_cubit.dart)).
- Ephemeral form editing and field validation (e.g. [`CharkhFormCubit`](../../lib/src/features/charkhs/application/charkh_form_cubit.dart), [`DestinationFormCubit`](../../lib/src/features/destinations/application/destination_form_cubit.dart), [`EditProfileCubit`](../../lib/src/features/profile/application/edit_profile_cubit.dart)).
- Local interactive UI controls where state changes are driven directly by user gesture function calls (e.g. `nameChanged(value)`, `save()`, `delete(id)`).
1.2. Cubits **MUST NOT** manage multiple concurrent asynchronous data streams (e.g., GPS + compass + network streams).  
1.3. Cubits **MUST NOT** own long-running periodic background timers, interval loops, or complex multi-step throttling pipelines.

### 2. BLoC Operational Scope
2.1. Blocs **MUST** be used whenever state management entails any of the following:
- **Multiple Asynchronous Streams**: Merging, listening to, or coordinating two or more asynchronous hardware or platform streams (e.g. [`ActiveMapBloc`](../../lib/src/features/routes/application/active_route_bloc.dart) orchestrating [`CurrentLocationService`](../../lib/src/features/locations/data/current_location_service.dart) position stream and [`CompassHeadingService`](../../lib/src/features/locations/data/compass_heading_service.dart) heading stream).
- **Periodic Timers & Ticking**: Driving recurring timer events (e.g., 1 Hz countdown timers, active elapsed route duration tracking via `ActiveMapTicked`).
- **Throttled & Debounced State Persistence**: Enforcing asynchronous write throttling (e.g., persisting active route records to Isar at bounded 5-second intervals).
- **Cooldown & State Machine Transitions**: Managing temporal cooldowns (e.g. 12-second off-route excursion reroute cooldowns).
2.2. All external stimulus into a BLoC **MUST** be modeled as discrete, strongly typed, immutable event classes extending a sealed event hierarchy.

### 3. The Nullable `copyWith` Sentinel Pattern
3.1. Any immutable state class containing one or more nullable properties **MUST** implement the private `_unchanged` sentinel pattern.  
3.2. State classes **MUST** declare a private sentinel object at file scope:
```dart
const Object _unchanged = Object();
```
3.3. In the `copyWith` method signature, every nullable parameter `T?` **MUST** be typed as `Object?` and defaulted to `_unchanged`:
```dart
MyState copyWith({
  Object? errorMessage = _unchanged,
  Object? userLocation = _unchanged,
}) {
  return MyState(
    errorMessage: errorMessage == _unchanged
        ? this.errorMessage
        : errorMessage as String?,
    userLocation: userLocation == _unchanged
        ? this.userLocation
        : userLocation as Coordinates?,
  );
}
```
3.4. Developers **MUST NOT** use naive `field ?? this.field` evaluation for nullable state properties.

### 4. Dependency Injection & Scoping Lifecycle
4.1. Cubits and Blocs **MUST** be instantiated inside [`lib/src/core/routing/app_router.dart`](../../lib/src/core/routing/app_router.dart) route builders and scoped to their respective screen subtrees using `BlocProvider`.  
4.2. Presentation widgets **MUST NOT** instantiate Blocs or Cubits directly inside their `build()` methods or presentation constructors.  
4.3. Presentation widgets **MUST** access Cubits or Blocs via `BlocProvider`, `BlocBuilder`, `BlocConsumer`, or `context.read<T>()`.

---

## Side-by-Side Dart Code Examples

### 1. Choosing Cubit vs. BLoC

```dart
// ❌ INCORRECT: Misusing Cubit for multi-stream sensor engine with periodic timer
class ActiveMapCubit extends Cubit<ActiveMapState> {
  ActiveMapCubit(this._locationService, this._compassService)
      : super(const ActiveMapState()) {
    // ANTI-PATTERN: Manually juggling multiple raw stream subscriptions in a Cubit
    _locationSub = _locationService.locationStream.listen((loc) {
      emit(state.copyWith(userLocation: loc.coordinates)); // Race conditions with timer!
    });
    _compassSub = _compassService.headingStream.listen((heading) {
      emit(state.copyWith(deviceHeadingDegrees: heading));
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      emit(state.copyWith(elapsedSeconds: state.elapsedSeconds + 1));
    });
  }

  StreamSubscription? _locationSub;
  StreamSubscription? _compassSub;
  Timer? _timer;
  // 15+ ad-hoc public methods mutating state directly without traceable events...
}

// ✅ CORRECT: Modeling multi-stream reactive engine as a structured BLoC
sealed class ActiveMapEvent extends Equatable {
  const ActiveMapEvent();
  @override
  List<Object?> get props => [];
}

class _ActiveMapUserLocationChanged extends ActiveMapEvent {
  const _ActiveMapUserLocationChanged(this.location);
  final LiveUserLocation location;
  @override
  List<Object?> get props => [location];
}

class _ActiveMapCompassHeadingChanged extends ActiveMapEvent {
  const _ActiveMapCompassHeadingChanged(this.headingDegrees);
  final double headingDegrees;
  @override
  List<Object?> get props => [headingDegrees];
}

class ActiveMapTicked extends ActiveMapEvent {
  const ActiveMapTicked();
}

class ActiveMapBloc extends Bloc<ActiveMapEvent, ActiveMapState> {
  ActiveMapBloc({
    required CurrentLocationService currentLocationService,
    required CompassHeadingService compassHeadingService,
  }) : super(const ActiveMapState()) {
    on<_ActiveMapUserLocationChanged>(_onUserLocationChanged);
    on<_ActiveMapCompassHeadingChanged>(_onCompassHeadingChanged);
    on<ActiveMapTicked>(_onTicked);

    // Discrete streams safely piped into typed BLoC events
    _locationSubscription = currentLocationService.locationStream.listen(
      (loc) => add(_ActiveMapUserLocationChanged(loc)),
    );
    _compassSubscription = compassHeadingService.headingStream.listen(
      (h) => add(_ActiveMapCompassHeadingChanged(h)),
    );
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => add(const ActiveMapTicked()));
  }
}
```

---

### 2. Nullable State Field Mutation (The Sentinel Pattern)

```dart
// ❌ INCORRECT: Naive copyWith prevents clearing validation messages or errors
class CharkhFormState extends Equatable {
  const CharkhFormState({this.name = '', this.validationMessage});
  final String name;
  final String? validationMessage;

  // BUG: Calling copyWith(validationMessage: null) does NOT clear validationMessage!
  CharkhFormState copyWith({
    String? name,
    String? validationMessage,
  }) {
    return CharkhFormState(
      name: name ?? this.name,
      validationMessage: validationMessage ?? this.validationMessage, // Fails to clear!
    );
  }

  @override
  List<Object?> get props => [name, validationMessage];
}

// ✅ CORRECT: Private sentinel pattern allows distinguishing null from unset
const Object _unchanged = Object();

class CharkhFormState extends Equatable {
  const CharkhFormState({this.name = '', this.validationMessage});
  final String name;
  final String? validationMessage;

  CharkhFormState copyWith({
    String? name,
    Object? validationMessage = _unchanged,
  }) {
    return CharkhFormState(
      name: name ?? this.name,
      validationMessage: validationMessage == _unchanged
          ? this.validationMessage
          : validationMessage as String?,
    );
  }

  @override
  List<Object?> get props => [name, validationMessage];
}

// Usage:
// Retains existing validationMessage:
final updated = state.copyWith(name: 'New Name'); 
// Successfully clears validationMessage to null:
final cleared = state.copyWith(validationMessage: null);
```

---

## Automated Verification & CI Rules

The following static verification checks must be executed in CI pipelines and pre-commit hooks to enforce state management boundaries and state immutability patterns.

### 1. Detect Illegal Cubit/BLoC Instantiations Inside Presentation Screens
Verifies that route-scoped Cubits/Blocs are not illegally created in presentation screen widgets (Rule 4.2):

```bash
rg --glob "lib/**/presentation/**.dart" "create:\s*\(.*?\)\s*=>\s*(RouteCalculationBloc|CharkhFormCubit|CharkhListCubit|ProfileCubit|DestinationFormCubit)"
```
*Expected Result*: Exit code 1 with zero matches.

### 2. Detect Missing Sentinel Pattern in Application States
Scans for state definitions containing nullable fields that fail to define `_unchanged`:

```bash
rg --glob "lib/src/features/**/application/*_cubit.dart" --glob "lib/src/features/**/application/*_bloc.dart" -e "const Object _unchanged = Object\(\);"
```
*Expected Result*: All files defining states with nullable properties must declare `_unchanged`.

---

### Git Grep Equivalents (Windows / Environments without `rg`):

```bash
git grep -E "create:\s*\(.*?\)\s*=>\s*(RouteCalculationBloc|CharkhFormCubit|CharkhListCubit|ProfileCubit|DestinationFormCubit)" -- "lib/**/presentation/**.dart"
git grep -E "const Object _unchanged = Object\(\);" -- "lib/src/features/**/application/*.dart"
```
