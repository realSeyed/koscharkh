# KosCharkh

KosCharkh is a Flutter mobile app for creating walking/cycling style routes
called Charkhs, adding destinations, previewing routes, selecting map
locations, and following an active route on a dark full-screen map.

The app uses the checked-in `design_files/` references as the visual source of
truth and currently ships with the dark theme only.

## Features

- Dark Material app theme with custom `ThemeExtension` tokens.
- `go_router` navigation with main tabs and typed pushed flows.
- `flutter_bloc` state management using Cubits for lightweight form/page state
  and Blocs for bootstrap, route calculation, timers, and active map behavior.
- Local persistence with Isar, including seeded Charkhs, destinations, profile,
  route cache, and active route state.
- `flutter_map` rendering with Mapbox tile support.
- Mapbox Directions route calculation with cached routes and offline fallback
  route geometry.
- Mapbox reverse geocoding for the select-location map picker.
- Real current-location lookup through `geolocator`.
- Compass-driven active map camera rotation through `flutter_compass`.
- Full-screen immersive Android experience.

## Requirements

- Flutter SDK compatible with Dart `^3.12.0`.
- Android Studio or VS Code with Flutter tooling.
- Android SDK for Android builds.

## Setup

Install dependencies:

```bash
flutter pub get
```

Generate Isar adapters:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Run the app:

```bash
flutter run
```

## Mapbox Configuration

Secrets are not hardcoded. Pass Mapbox values with `--dart-define`.

Supported keys:

- `MAPBOX_TILE_URL_TEMPLATE`
- `MAPBOX_ACCESS_TOKEN`
- `MAPBOX_DIRECTIONS_BASE_URL`
- `MAPBOX_DIRECTIONS_PROFILE`

Example debug run:

```bash
flutter run ^
  --dart-define=MAPBOX_ACCESS_TOKEN=your_token ^
  --dart-define=MAPBOX_TILE_URL_TEMPLATE=https://api.mapbox.com/styles/v1/mapbox/dark-v11/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken} ^
  --dart-define=MAPBOX_DIRECTIONS_BASE_URL=https://api.mapbox.com/directions/v5/mapbox ^
  --dart-define=MAPBOX_DIRECTIONS_PROFILE=walking
```

Example release APK:

```bash
flutter build apk --release ^
  --dart-define=MAPBOX_ACCESS_TOKEN=your_token ^
  --dart-define=MAPBOX_TILE_URL_TEMPLATE=https://api.mapbox.com/styles/v1/mapbox/dark-v11/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken} ^
  --dart-define=MAPBOX_DIRECTIONS_BASE_URL=https://api.mapbox.com/directions/v5/mapbox ^
  --dart-define=MAPBOX_DIRECTIONS_PROFILE=walking
```

When Mapbox config is empty, the app still works with a dark placeholder map,
local markers, route previews, and fallback route geometry.

## Validation

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Build Android debug APK:

```bash
flutter build apk --debug
```

## Design References

The app UI should stay aligned with:

- `design_files/Pages/`
- `design_files/Components/`
- `design_files/Theme/`
- `design_files/Icons/`

Update these references intentionally if the product direction changes.
