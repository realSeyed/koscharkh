---
id: 0003-coordinate-isolation-and-mapbox-contracts
title: Coordinate Isolation and Mapbox Contracts
status: accepted
applies_to: ["lib/src/features/**/domain/**", "lib/src/features/**/data/**", "lib/src/core/map/**"]
supersedes: null
superseded_by: null
tags: [gis, coordinates, mapbox, api, fallback]
---

# ADR 0003: Coordinate Isolation and Mapbox Contracts

## Status
**Accepted** (2026-09-17)

## Context & Problem Statement

KosCharkh provides map-driven waypoint navigation and route progress tracking across pedestrian journeys. Geographic coordinates flow throughout the system: from reverse geocoding and location picking, to persistent saved destinations, remote route computation via Mapbox APIs, and offline fallback route generation.

Geospatial mobile development routinely suffers from two insidious defect classes, alongside offline resilience challenges:

1. **Domain Coupling Problem**: Third-party GIS libraries (such as `latlong2` or `flutter_map`) frequently introduce breaking changes across major versions and couple data structures to Flutter-specific geometry or external abstractions. Core domain entities ([`Destination`](../../lib/src/features/destinations/domain/destination.dart), [`Coordinates`](../../lib/src/features/locations/domain/coordinates.dart), [`LocationSelection`](../../lib/src/features/locations/domain/location_selection.dart), and [`Charkh`](../../lib/src/features/charkhs/domain/charkh.dart)) must remain framework-agnostic, lightweight, and isolated from external package churn. Leaking `LatLng` into domain entities pollutes business logic, prevents headless unit testing without GIS dependencies, and violates Clean Architecture domain boundary isolation.
2. **Coordinate Order Inversion Bug ($Y, X$ vs. $X, Y$)**: In human conversation, classical geography, and mobile location services (e.g., GPS sensors, Google Maps), coordinates are denoted as Latitude, Longitude ($Y, X$ or $\phi, \lambda$). Conversely, Cartesian mathematical coordinates, GeoJSON ([RFC 7946](https://datatracker.ietf.org/doc/html/rfc7946#section-3.1.1)), and Mapbox REST APIs (Directions, Geocoding, Matrix) strictly mandate Longitude, Latitude ($X, Y$). Inverting coordinate order when assembling Mapbox REST request URLs triggers HTTP 422 `InvalidInput` errors, yields inverted geometry paths across the globe, or causes reverse-geocoding lookups to fall into open ocean bodies.
3. **Offline & Zero-Secret Resilience**: Developers, open-source contributors, CI test pipelines, and users in intermittent or disconnected connectivity environments must be able to run, build, and verify the application without requiring a valid or active Mapbox access token. The application must degrade gracefully rather than crashing or stalling when secrets are omitted or external services are unreachable.

This Architecture Decision Record establishes normative RFC 2119 directives, actionable side-by-side code examples, and automated ripgrep verification commands to govern coordinate boundaries, Mapbox REST contracts, and fallback degradation across KosCharkh.

---

## Normative Directives (RFC 2119)

### 1. Domain Layer Coordinate Independence
1.1. Domain entities, value objects, and domain repository contracts within `lib/src/features/**/domain/**` **MUST** represent geographic positions exclusively using the pure domain [`Coordinates`](../../lib/src/features/locations/domain/coordinates.dart) class (`latitude`, `longitude`).  
1.2. Domain entities (including [`Destination`](../../lib/src/features/destinations/domain/destination.dart), [`DestinationDraft`](../../lib/src/features/destinations/domain/destination.dart), and [`LocationSelection`](../../lib/src/features/locations/domain/location_selection.dart)) **MUST NOT** import `package:latlong2` or expose `LatLng` fields in their public domain interfaces.  
1.3. Conversion from domain `Coordinates` to third-party GIS types (`LatLng`) **MUST** occur solely via the explicit adapter method `coordinates.toLatLng()` at presentation map boundaries (such as [`KosMap`](../../lib/src/core/map/kos_map.dart)) or within dedicated data/routing parsers (such as [`DirectionsService`](../../lib/src/features/routes/data/directions_service.dart)).

### 2. Mapbox URL Coordinate Ordering (X, Y Invariant)
2.1. When constructing URI path segments or query parameters for Mapbox REST APIs (including Directions and Geocoding endpoints), developers **MUST** format coordinate pairs strictly in Cartesian Longitude, Latitude order: `${coordinates.longitude},${coordinates.latitude}` ($X, Y$).  
2.2. Developers **MUST NOT** format Mapbox request coordinate parameters in Latitude, Longitude order (`${coordinates.latitude},${coordinates.longitude}`).  
2.3. Multi-waypoint path sequences for the Mapbox Directions API **MUST** format each coordinate as `${item.longitude},${item.latitude}` joined by semicolons (`;`), conforming to `${AppConfig.mapboxDirectionsBaseUrl}/${AppConfig.mapboxDirectionsProfile}/$encodedCoordinates`.  
2.4. Reverse-geocoding endpoints **MUST** format the target coordinate query as `${coordinates.longitude},${coordinates.latitude}.json`.

### 3. Graceful Degradation & Zero-Token Guarantee
3.1. Network data services communicating with Mapbox APIs ([`DirectionsService`](../../lib/src/features/routes/data/directions_service.dart), [`ReverseGeocodingService`](../../lib/src/features/locations/data/reverse_geocoding_service.dart)) **MUST** inspect token availability via [`AppConfig.hasMapboxToken`](../../lib/src/core/config/app_config.dart) and [`AppConfig.hasDirectionsToken`](../../lib/src/core/config/app_config.dart) before dispatching HTTP network requests.  
3.2. If the required token is empty or absent, network services **MUST** raise typed, recoverable exceptions ([`DirectionsException`](../../lib/src/features/routes/data/directions_service.dart), [`ReverseGeocodingException`](../../lib/src/features/locations/data/reverse_geocoding_service.dart)) instead of transmitting failing requests.  
3.3. The application **MUST NOT** crash, freeze, or display unhandled exception screens when Mapbox access tokens are missing or network calls fail.  
3.4. When Mapbox directions are unavailable or request attempts fail, presentation layers, Cubits, and BLoCs **MUST** fall back to [`buildFallbackRoute`](../../lib/src/features/routes/data/directions_service.dart), creating deterministic straight-line route legs with proportional duration allocation based on walking distance.  
3.5. When raster tile templates are unconfigured (`AppConfig.effectiveTileUrl.isEmpty`), [`KosMap`](../../lib/src/core/map/kos_map.dart) **MUST** display [`DarkMapBackdropPainter`](../../lib/src/core/map/kos_map.dart) without throwing runtime layout or painting errors.

### 4. Secret Management & Configuration
4.1. Developers **MUST NOT** commit hardcoded Mapbox API tokens, public tokens (`pk.eyJ...`), or secret keys (`sk.eyJ...`) into the repository.  
4.2. All external API tokens and service endpoints **MUST** be supplied at compilation or runtime via `--dart-define` environment configuration, accessed exclusively through [`AppConfig`](../../lib/src/core/config/app_config.dart) (`MAPBOX_ACCESS_TOKEN`, `MAPBOX_TILE_URL_TEMPLATE`, `MAPBOX_DIRECTIONS_BASE_URL`, `MAPBOX_GEOCODING_BASE_URL`, `MAPBOX_DIRECTIONS_PROFILE`).

---

## Side-by-Side Dart Code Examples

### 1. Domain Model Coordinate Typing

```dart
// ❌ INCORRECT: Domain model directly couples to external GIS library (LatLng)
import 'package:latlong2/latlong.dart'; // VIOLATION: Leaking third-party GIS type into domain

class Destination {
  const Destination({
    required this.name,
    required this.location, // VIOLATION: LatLng couples domain to latlong2 package
  });

  final String name;
  final LatLng location;
}

// ✅ CORRECT: Domain model uses pure Coordinates value object
import '../../locations/domain/coordinates.dart';

class Destination {
  const Destination({
    required this.stableId,
    required this.charkhStableId,
    required this.position,
    required this.name,
    required this.description,
    this.coordinates, // CLEAN: Independent domain Coordinates value object
    this.address,
  });

  final String stableId;
  final String charkhStableId;
  final int position;
  final String name;
  final String description;
  final Coordinates? coordinates;
  final String? address;
}
```

### 2. Mapbox REST API URL Construction

```dart
// ❌ INCORRECT: Inverted coordinate ordering (lat, lng) breaks Mapbox REST API
final uri = Uri.parse(
  'https://api.mapbox.com/geocoding/v5/mapbox.places/'
  '${coordinates.latitude},${coordinates.longitude}.json', // VIOLATION: Inverted (Y, X) order!
);

final directionsUri = Uri.parse(
  'https://api.mapbox.com/directions/v5/mapbox/walking/'
  '${start.latitude},${start.longitude};${end.latitude},${end.longitude}', // VIOLATION: HTTP 422!
);

// ✅ CORRECT: Cartesian ordering (lng, lat) enforces GeoJSON / Mapbox contract
final geocodingUri = Uri.parse(
  '${AppConfig.mapboxGeocodingBaseUrl}/'
  '${coordinates.longitude},${coordinates.latitude}.json', // REQUIRED: (X, Y) order
).replace(
  queryParameters: {
    'access_token': AppConfig.mapboxAccessToken,
    'limit': '1',
  },
);

final encodedWaypoints = coordinates
    .map((item) => '${item.longitude},${item.latitude}') // REQUIRED: lng,lat
    .join(';');
final directionsUri = Uri.parse(
  '${AppConfig.mapboxDirectionsBaseUrl}/'
  '${AppConfig.mapboxDirectionsProfile}/$encodedWaypoints',
).replace(
  queryParameters: {
    'access_token': AppConfig.mapboxAccessToken,
    'geometries': 'geojson',
    'overview': 'full',
    'steps': 'true',
  },
);
```

### 3. Safe Route Calculation Fallback

```dart
// ❌ INCORRECT: Assumes remote API success and unhandled error crashes UI
Future<void> calculateRoute(List<Coordinates> waypoints) async {
  // VIOLATION: Throws unhandled DirectionsException when token is missing or network fails
  final route = await directionsService.calculate(waypoints);
  emit(RouteLoaded(route));
}

// ✅ CORRECT: Catches DirectionsException and gracefully yields deterministic fallback route
Future<void> calculateRoute({
  required List<Coordinates> waypoints,
  required int targetTimeMinutes,
}) async {
  try {
    if (!AppConfig.hasDirectionsToken) {
      throw DirectionsException('Mapbox token not configured; invoking offline fallback.');
    }
    final route = await directionsService.calculate(waypoints);
    emit(RouteLoaded(route));
  } on DirectionsException catch (e) {
    // Graceful offline fallback: geodesic straight lines with proportional leg durations
    final fallback = buildFallbackRoute(
      coordinates: waypoints,
      timeMinutes: targetTimeMinutes,
    );
    emit(RouteLoaded(fallback));
  } catch (e) {
    emit(RouteError('Unable to generate route preview.'));
  }
}
```

---

## Automated Verification & CI Rules

The following commands must be executed in CI pipelines and pre-commit checks. Any violation constitutes an immediate build failure.

### 1. Detect Banned `latlong2` in Pure Domain Layer
Flags violations of Rule 1.2 across all feature domain entities:
```bash
rg --glob "lib/**/domain/**.dart" "package:latlong2"
```

### 2. Detect Inverted Coordinate String Formats in Data Layer
Flags violations of Rule 2.1 and 2.2 where coordinate string interpolation places latitude before longitude:
```bash
rg --glob "lib/**/data/**.dart" -e "\$\{.*latitude\},.*\$\{.*longitude\}"
```
*Expected Result*: Exit code 1 with zero output lines.

### 3. Detect Hardcoded Mapbox Secret Patterns
Flags violations of Rule 4.1 by scanning for Mapbox public (`pk.eyJ...`) and secret (`sk.eyJ...`) access tokens:
```bash
rg -e "pk\.eyJ[a-zA-Z0-9_-]{20,}" -e "sk\.eyJ[a-zA-Z0-9_-]{20,}"
```
*Expected Result*: Exit code 1 with zero output lines.

---

### Composite CI Verification Command

The following composite command runs the security and API invariant audit suite across the repository:

```bash
rg --glob "lib/**/data/**.dart" -e "\$\{.*latitude\},.*\$\{.*longitude\}" && \
rg -e "pk\.eyJ[a-zA-Z0-9_-]{20,}" -e "sk\.eyJ[a-zA-Z0-9_-]{20,}"
```
*Expected Result*: Both commands exit with code 1 (no matches found).

#### Git Grep Equivalent (Windows / Environments without `rg`):

```bash
git grep -E "\$\{.*latitude\},.*\$\{.*longitude\}" -- "lib/**/data/**.dart"
git grep -E "pk\.eyJ[a-zA-Z0-9_-]{20,}|sk\.eyJ[a-zA-Z0-9_-]{20,}"
```
*Expected Result*: Exit code 1 with zero output lines for each command.
