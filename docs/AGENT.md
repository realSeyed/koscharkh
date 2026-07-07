# Koscharkh Codex Instructions

Read `docs/koscharkh_codex_implementation_brief.md` before implementing anything.

Implement the app in Flutter.

Hard requirements:

- Use Flutter `ThemeData` with Flutter `ThemeExtension`.
- The current/default theme is Dark.
- Keep the theme ready for a future Light theme, but do not implement Light unless requested.
- Use `go_router` for routing.
- Use `flutter_bloc` for state management.
- Use Cubit for lightweight page state.
- Use Bloc for heavier async flows, route calculation, timers, or multi-step state.
- Use `isar` for local storage.
- Use `flutter_map` for map rendering.
- Use Mapbox tiles through a configurable map URL and API key placeholder.
- Use the Mapbox Directions API for route calculation.
- Do not hardcode real Mapbox secrets.
- Do not invent architecture or folder structure unless explicitly asked.
- Match the provided design files as closely as possible.

Before coding, inspect the design references and summarize the screens/components you will implement.
