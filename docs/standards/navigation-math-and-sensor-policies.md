# Navigation Math & Sensor Policies: Normative Standard

This document establishes the authoritative, machine-readable normative standard for spatial mathematics, sensor fusion policies, filtering parameters, and state transition invariants governing navigation in **KosCharkh**.

The key words **MUST**, **MUST NOT**, **REQUIRED**, **SHALL**, **SHALL NOT**, **SHOULD**, **SHOULD NOT**, **RECOMMENDED**, **MAY**, and **OPTIONAL** in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

---

## 1. Parameter Registry Table

The following table registers all numerical constants, tolerances, durations, and scaling coefficients across the navigation and sensor subsystem. Any alteration to these values impacts field navigation stability and requires explicit test verification.

| Constant Name | Value | Unit | Type / Source File | Invariant / Policy Rule |
|---|---|---|---|---|
| `_minimumHeadingSpeedMetersPerSecond` | `0.7` | m/s | `double` / [`ActiveMapBloc`](file:///f:/dev/koscharkh/lib/src/features/routes/application/active_route_bloc.dart#L1137) | Discards GPS course below walking threshold ($\approx 2.52\,\text{km/h}$). Prevents course spinning while walking slowly or stationary. |
| `_minimumBearingDistanceMeters` | `3.0` | m | `double` / [`ActiveMapBloc`](file:///f:/dev/koscharkh/lib/src/features/routes/application/active_route_bloc.dart#L1138) | Minimum spatial displacement required to compute forward azimuth between consecutive GPS fixes. Prevents stationary GPS jitter from corrupting bearing. |
| `_headingSmoothingFactor` | `0.22` | scalar | `double` / [`ActiveMapBloc`](file:///f:/dev/koscharkh/lib/src/features/routes/application/active_route_bloc.dart#L1139) | Single-pole low-pass exponential filter weight for GPS course and dead-reckoned bearing. Suppresses pedestrian walking sway. |
| `_compassHeadingSmoothingFactor` | `0.42` | scalar | `double` / [`ActiveMapBloc`](file:///f:/dev/koscharkh/lib/src/features/routes/application/active_route_bloc.dart#L1140) | Exponential smoothing filter weight for device magnetometer. Balances jitter suppression with low-latency device rotation response. |
| `_minimumCompassHeadingDeltaDegrees` | `0.6` | deg | `double` / [`ActiveMapBloc`](file:///f:/dev/koscharkh/lib/src/features/routes/application/active_route_bloc.dart#L1141) | Deadband filter threshold. Angular changes $< 0.6^\circ$ are discarded to eliminate sensor noise flutter while holding the device. |
| `minimumArrivalRadiusMeters` | `12.0` | m | `double` / [`WalkingRouteProgressPolicy`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L35) | Absolute lower bound clamp for dynamic waypoint arrival radius. |
| `maximumArrivalRadiusMeters` | `18.0` | m | `double` / [`WalkingRouteProgressPolicy`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L36) | Absolute upper bound clamp for dynamic waypoint arrival radius. |
| `arrivalExitRadiusMeters` | `24.0` | m | `double` / [`WalkingRouteProgressPolicy`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L37) | Hard reset boundary. If direct distance to destination reaches $\ge 24.0\,\text{m}$, candidate arrival confirmation counter resets to 0. |
| `endpointPassRadiusMeters` | `22.0` | m | `double` / [`WalkingRouteProgressPolicy`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L38) | Maximum direct distance to target waypoint for near-endpoint candidate status when remaining leg distance $\le 5.0\,\text{m}$. |
| `endpointRemainingDistanceMeters` | `5.0` | m | `double` / [`WalkingRouteProgressPolicy`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L39) | Threshold of remaining distance along the projected leg to qualify as near-endpoint. |
| `maximumReliableAccuracyMeters` | `25.0` | m | `double` / [`WalkingRouteProgressPolicy`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L40) | Maximum tolerable horizontal GPS accuracy. Fixes reporting $> 25.0\,\text{m}$ are rejected from progress calculations. |
| `offRouteDistanceMeters` | `30.0` | m | `double` / [`WalkingRouteProgressPolicy`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L41) | Base perpendicular divergence threshold before GPS accuracy scaling. |
| `arrivalConfirmationSamples` | `2` | count | `int` / [`WalkingRouteProgressPolicy`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L42) | Number of consecutive valid location fixes required within arrival boundaries to confirm arrival and advance to the next destination. |
| `offRouteConfirmationSamples` | `3` | count | `int` / [`WalkingRouteProgressPolicy`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L43) | Number of consecutive valid location fixes exceeding off-route threshold to declare off-route and trigger rerouting. |
| `maximumLocationAge` | `12` | seconds | `Duration` / [`WalkingRouteProgressPolicy`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L44) | Temporal freshness boundary. Location fixes older than $12\,\text{s}$ are rejected as stale. |
| `rerouteCooldown` | `12` | seconds | `Duration` / [`WalkingRouteProgressPolicy`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L45) | Rate limit cooldown. Must elapse between successive reroute API calls to prevent network/battery thrashing. |
| `_activeRoutePersistenceIntervalSeconds` | `5` | seconds | `int` / [`ActiveMapBloc`](file:///f:/dev/koscharkh/lib/src/features/routes/application/active_route_bloc.dart#L1143) | Periodic cadence for persisting navigation state (`elapsedSeconds`, `etaSeconds`, `currentDestinationIndex`) to Isar. |
| `_finishCountdownSeconds` | `10` | seconds | `int` / [`ActiveMapBloc`](file:///f:/dev/koscharkh/lib/src/features/routes/application/active_route_bloc.dart#L1142) | Auto-finish countdown timer duration once the final destination is reached. |
| `earthRadiusMeters` | `6371000.0` | m | `double` / [`walking_route_progress.dart`](file:///f:/dev/koscharkh/lib/src/features/routes/domain/walking_route_progress.dart#L148) | Mean Earth radius used in all Haversine and local tangent plane projection calculations. |
| `distanceFilter` | `2` | m | `int` / [`CurrentLocationService`](file:///f:/dev/koscharkh/lib/src/features/locations/data/current_location_service.dart#L91) | Minimum physical displacement threshold in Geolocator stream before emitting a new position. |
| `timeLimit` | `12` | seconds | `Duration` / [`CurrentLocationService`](file:///f:/dev/koscharkh/lib/src/features/locations/data/current_location_service.dart#L35) | Acquisition timeout for single-shot location lookup during route start. |
| Minimum fallback duration | `60` | seconds | `int` / [`directions_service.dart`](file:///f:/dev/koscharkh/lib/src/features/routes/data/directions_service.dart#L126) | Lower bound clamp on fallback route duration: `max(60, timeMinutes * 60)`. |

---

## 2. Mathematical Invariants & Reference Formulations

### 2.1 Equirectangular Local Tangent Plane Projection

Spherical coordinates are projected into Cartesian tangent plane meters relative to origin $\mathbf{O} = (\phi_{\text{origin}}, \lambda_{\text{origin}})$:

$$x = (\lambda - \lambda_{\text{origin}}) \times \frac{\pi}{180} \times \cos\left(\phi_{\text{origin}} \times \frac{\pi}{180}\right) \times 6,371,000.0$$
$$y = (\phi - \phi_{\text{origin}}) \times \frac{\pi}{180} \times 6,371,000.0$$

Where $\phi$ is latitude and $\lambda$ is longitude.

### 2.2 Parametric Segment Vector Projection

For a segment from $\mathbf{s} = (x_1, y_1)$ to $\mathbf{e} = (x_2, y_2)$ with vector $\mathbf{v} = \mathbf{e} - \mathbf{s} = (\Delta x, \Delta y)$:

$$t = \begin{cases} 0.0, & \text{if } \Delta x^2 + \Delta y^2 = 0 \\ \text{clamp}\left(\frac{-x_1 \Delta x - y_1 \Delta y}{\Delta x^2 + \Delta y^2}, 0.0, 1.0\right), & \text{otherwise} \end{cases}$$

Closest projected point on segment:
$$\mathbf{p} = (x_1 + t \Delta x, y_1 + t \Delta y)$$
$$\text{distanceFromRouteMeters} = \|\mathbf{p}\| = \sqrt{p_x^2 + p_y^2}$$

### 2.3 Spherical Haversine Distance

The great-circle distance $d$ between two points $(\phi_1, \lambda_1)$ and $(\phi_2, \lambda_2)$ in radians:

$$h = \sin^2\left(\frac{\phi_2 - \phi_1}{2}\right) + \cos(\phi_1)\cos(\phi_2)\sin^2\left(\frac{\lambda_2 - \lambda_1}{2}\right)$$
$$d = 2 \times 6,371,000.0 \times \text{atan2}\left(\sqrt{h}, \sqrt{1 - h}\right)$$

### 2.4 Spherical Forward Azimuth

The initial bearing $\theta$ from coordinate 1 to coordinate 2:

$$\Delta \lambda = \lambda_2 - \lambda_1$$
$$y = \sin(\Delta \lambda) \cdot \cos(\phi_2)$$
$$x = \cos(\phi_1)\sin(\phi_2) - \sin(\phi_1)\cos(\phi_2)\cos(\Delta \lambda)$$
$$\theta_{\text{norm}} = \left(\left(\text{atan2}(y, x) \times \frac{180}{\pi}\right) \pmod{360} + 360\right) \pmod{360}$$

### 2.5 Modular Shortest-Angle Difference & Filter

Given source heading $from$ and target heading $to$ in degrees:

$$\Delta\theta = ((to - from + 540) \pmod{360}) - 180$$
$$\text{smoothed} = (from + \Delta\theta \times \alpha) \pmod{360}$$

Normalized to $[0, 360)^\circ$.

### 2.6 Dynamic Arrival Radius Clamping

Given horizontal GPS accuracy $a$ in meters:

$$r_{\text{arr}}(a) = \text{clamp}(a \times 1.2, 12.0, 18.0)$$

### 2.7 Dynamic Off-Route Threshold

Given horizontal GPS accuracy $a$ in meters:

$$d_{\text{off}}(a) = \max(30.0, a \times 1.5)$$

### 2.8 Fallback Route Proportional Duration Allocation

For $K$ legs with distances $d_0, d_1, \dots, d_{K-1}$ and total duration $T$:

$$\text{cumulativeDistance}_i = \sum_{j=0}^{i} d_j$$
$$\text{cumulativeDuration}_i = \begin{cases} T, & \text{if } i = K - 1 \\ \text{round}\left(T \times \frac{i+1}{K}\right), & \text{if } \text{totalMeters} \le 0 \\ \text{round}\left(T \times \frac{\text{cumulativeDistance}_i}{\text{totalMeters}}\right), & \text{otherwise} \end{cases}$$
$$\text{duration}_i = \max(0, \text{cumulativeDuration}_i - \text{allocatedDuration}_{i-1})$$

Invariant:
$$\sum_{i=0}^{K-1} \text{duration}_i \equiv T$$

---

## 3. Normative Directives (RFC 2119)

Future AI coding agents modifying or maintaining the navigation subsystem **MUST** comply with the following normative directives:

### 3.1 Sensor Fusion & Heading Policies

1. Agents **MUST NOT** alter `_headingSmoothingFactor` (`0.22`) or `_compassHeadingSmoothingFactor` (`0.42`) without updating and running sensor integration tests.
2. Agents **MUST NOT** evaluate GPS course heading when device speed is $< 0.7\,\text{m/s}$. When speed is $< 0.7\,\text{m/s}$, the system **MUST** fall back to dead-reckoned spatial bearing or retain existing camera heading.
3. Bearing calculation between consecutive GPS fixes **MUST NOT** be evaluated if spatial displacement is $< 3.0\,\text{m}$.
4. Magnetometer compass updates **MUST** be rejected if the shortest angular change $|\Delta\theta| < 0.6^\circ$.
5. Heading normalization **MUST** ensure all output angles lie strictly within the half-open interval $[0, 360)^\circ$.

### 3.2 Route Projection & Progress Policies

1. Cartesian projection **MUST** use the local tangent plane formulation anchored at the user's instantaneous location (`_toLocalMeters`). Global spherical iterations for parametric point-line projection are strictly prohibited.
2. Route projection **MUST** handle degenerate legs (0 points or 1 point) and degenerate segments (length = 0) without throwing exceptions or generating `NaN`/infinite coordinates.
3. Progress ratio along a route leg **MUST** be clamped to $[0.0, 1.0]$.
4. Remaining route distance **MUST NOT** be negative; it **MUST** be clamped to $\ge 0$.

### 3.3 Waypoint Arrival & Geofencing Policies

1. A location fix **MUST** be validated against `WalkingRouteProgressPolicy.isReliable` before being passed to arrival evaluation. Fixes with accuracy $> 25.0\,\text{m}$ or age $> 12\,\text{s}$ **MUST** be discarded.
2. Single-sample waypoint arrival transitions are **STRICTLY PROHIBITED**. The state machine **MUST** require at least $2$ consecutive confirmation samples (`arrivalConfirmationSamples = 2`) satisfying arrival criteria.
3. Candidate arrival counter **MUST NOT** be decremented gradually; if the user's distance increases to $\ge 24.0\,\text{m}$ (`arrivalExitRadiusMeters`), the candidate counter **MUST** be reset immediately to `0`.
4. Endpoint pass candidate detection **MUST** require both conditions simultaneously: $\text{remainingRouteDistanceMeters} \le 5.0\,\text{m}$ **AND** $\text{directDistance} \le 22.0\,\text{m}$.
5. Advancing to the next destination **MUST** trigger immediate persistence to `ActiveRouteRecord` (`id = 1`).

### 3.4 Off-Route Detection & Auto-Reroute Policies

1. Off-route detection **MUST** remain strictly disabled whenever `route.source != 'mapbox'`.
2. Single-sample off-route declarations are **STRICTLY PROHIBITED**. The state machine **MUST** require at least $3$ consecutive confirmation samples (`offRouteConfirmationSamples = 3`) exceeding `offRouteThreshold`.
3. Auto-reroute network requests **MUST** observe a cooldown duration of at least $12\,\text{s}$ (`rerouteCooldown`).
4. Auto-reroute execution **MUST** be guarded by a mutual exclusion flag (`_isRerouting`) to prevent concurrent network requests.
5. Upon successful reroute, `routeStartDestinationIndex` **MUST** be re-anchored to the active `destinationIndex`, and active leg indexing **MUST** use the mapped offset: $\text{legIndex} = \text{destIndex} - \text{routeStartDestinationIndex}$.
6. If the active destination index advances while a reroute request is in flight, the completed reroute response **MUST** be discarded as stale.

### 3.5 Fallback Routing Policies

1. Fallback routes **MUST** allocate leg durations using discrete integer cumulative distribution to prevent rounding drift.
2. Fallback routes **MUST** clamp total duration to a minimum of $60\,\text{s}$.
3. Fallback route source identifier **MUST** be set to `'fallback'`.

### 3.6 Lifecycle & Persistence Policies

1. Active navigation state **MUST** be persisted to Isar (`ActiveRouteRecord`, `id = 1`) every $5\,\text{s}$ during periodic tick.
2. When the final waypoint is reached, the state machine **MUST** enter `ActiveMapFinishStatus.prompting` with a $10\,\text{s}$ countdown timer.
3. Route completion recording to `CharkhHistoryRepository` **MUST** be followed immediately by clearing `ActiveRouteRecord` and cancelling sensor subscriptions and periodic tickers.

---

## 4. Unit Test Validation Matrix

All mathematical models, sensor policies, and state transitions are validated by automated unit tests in [`test/koscharkh_test.dart`](file:///f:/dev/koscharkh/test/koscharkh_test.dart). The following matrix defines test coverage against normative policies:

| Test Case Name | Source Line Range | Governing Subsystem | Invariant / Policy Verified |
|---|---|---|---|
| `fallback route uses supplied coordinates and requested ETA` | [`test/koscharkh_test.dart#L21-L36`](file:///f:/dev/koscharkh/test/koscharkh_test.dart#L21-L36) | Fallback Routing | Verifies that `buildFallbackRoute` preserves coordinate order, sets `source = 'fallback'`, calculates non-zero distance, and assigns the exact requested duration ($1200\,\text{s}$). |
| `fallback route allocates duration by walking leg distance` | [`test/koscharkh_test.dart#L38-L55`](file:///f:/dev/koscharkh/test/koscharkh_test.dart#L38-L55) | Duration Allocation | Verifies proportional duration allocation across multi-stop legs (1/3 vs. 2/3 distance yields $\approx 200\,\text{s}$ and $\approx 400\,\text{s}$) and confirms exact sum conservation ($\sum \text{duration} \equiv 600\,\text{s}$). |
| `Mapbox response keeps geometry and timing for each walking leg` | [`test/koscharkh_test.dart#L57-L115`](file:///f:/dev/koscharkh/test/koscharkh_test.dart#L57-L115) | Directions Service | Verifies parsing of Mapbox Directions JSON: extracts turn-by-turn geometry, individual leg distances, and step timings without data loss. |
| `fallback route stays empty without enough coordinates` | [`test/koscharkh_test.dart#L117-L131`](file:///f:/dev/koscharkh/test/koscharkh_test.dart#L117-L131) | Fallback Routing | Verifies edge case safety: passing 0 or 1 coordinate produces empty route points, 0 distance, and 0 duration. |
| `walking projection reports progress along a short route leg` | [`test/koscharkh_test.dart#L133-L148`](file:///f:/dev/koscharkh/test/koscharkh_test.dart#L133-L148) | Tangent Plane Projection | Verifies `projectLocationOntoLeg` accuracy: point at mid-segment lateral offset yields progress $\approx 0.50$, orthogonal distance $\approx 5.56\,\text{m}$, and remaining distance $\approx 55.6\,\text{m}$. |
| `walking arrival radius stays within pedestrian limits` | [`test/koscharkh_test.dart#L150-L154`](file:///f:/dev/koscharkh/test/koscharkh_test.dart#L150-L154) | Waypoint Geofencing | Verifies dynamic arrival radius formula: $3\,\text{m} \rightarrow 12.0\,\text{m}$ (lower clamp), $12\,\text{m} \rightarrow 14.4\,\text{m}$ (linear scale), $25\,\text{m} \rightarrow 18.0\,\text{m}$ (upper clamp). |
| `walking progress rejects stale and inaccurate locations` | [`test/koscharkh_test.dart#L156-L180`](file:///f:/dev/koscharkh/test/koscharkh_test.dart#L156-L180) | Sensor Reliability | Verifies `WalkingRouteProgressPolicy.isReliable`: accepts fresh accurate fix ($5\,\text{s}$ old, $8\,\text{m}$ acc), rejects stale fix ($20\,\text{s}$ old), rejects inaccurate fix ($35\,\text{m}$ acc). |

---

## 5. Agent Verification & Regression Checklist

Before committing any modifications to `lib/src/features/routes/` or `lib/src/features/locations/`, an AI agent **MUST** complete the following automated verification steps:

1. **Test Execution**:
   ```bash
   flutter test test/koscharkh_test.dart
   ```
   All test cases **MUST** exit with code `0`.

2. **Parameter Drift Check**:
   Confirm no magic constants were hardcoded into business logic. Validate with `git diff`:
   ```bash
   git diff lib/src/features/routes/ lib/src/features/locations/
   ```

3. **Symbol & Link Integrity**:
   Verify all file and line references in documentation link directly to existing repository declarations using standard `file:///` URLs.
