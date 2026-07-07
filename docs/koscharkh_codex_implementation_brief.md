# KosCharkh - Codex Implementation Brief

Use this file as the implementation prompt/spec for GPT Codex. The design reference files are expected to live in the Flutter repository at the root-level `design_files/` folder. Codex must inspect and use `design_files/` as the source of truth for visual references before implementing UI.

## 1. Codex task

Implement the KosCharkh mobile app UI and core offline behavior from the design files located at `<repo-root>/design_files/` in Flutter.

This is a greenfield Flutter app. Flutter development has not started yet, so Codex must build the application from scratch. If the repository contains only docs/design references, create the Flutter project scaffold first, then implement the screens/components below.

Required stack decisions:

- **Framework:** Flutter.
- **Routing:** `go_router`.
- **Local storage:** `isar`.
- **Map:** `flutter_map` with Mapbox tiles. Use a dedicated map tile URL/config value for the Mapbox URL. Leave the actual URL/API key value configurable because it will be added manually later.
- **Routing/routes:** Use the **Mapbox Directions API** to calculate route geometry, distance, and ETA between selected destinations. Keep the Directions API key/base URL/config values configurable because they will be added manually later.
- **Theme:** Flutter `ThemeData` plus Flutter's own `ThemeExtension` for KosCharkh-specific semantic tokens. The default and current app theme is **Dark**. A Light theme may be added later, so keep the theme extension structure ready for both modes without implementing the light palette unless already requested.
- **State management:** Use the `flutter_bloc` package. Use `Cubit` for lightweight page/state flows and `Bloc` for heavier flows with multiple event types, asynchronous route calculation, timers, or complex CRUD interactions.

The implementation should be faithful to the designs: dark theme, JetBrains Mono typography, green primary actions, square dark surfaces, bottom navigation, map/route screens, and local CRUD for charkhs, destinations, and profile. When the Mapbox tile URL/API key or Directions API key has not yet been supplied, keep the map and route services configurable and allow the UI to render without crashing; route overlays and markers should still be visible using cached routes, seed/mock route geometry, or straight-line fallback geometry.


## 2. Asset inventory in `<repo-root>/design_files/`

All paths below are relative to the repository root. Codex should read the files directly from `design_files/` and should not look for `koscharkh.zip` during implementation.

### Pages

- `design_files/Pages/Splash Page.jpg` - splash screen with KosCharkh logo.
- `design_files/Pages/Home.jpg` - blank home tab with bottom navigation.
- `design_files/Pages/Charkhs.jpg` - charkh list with cards, add button, bottom navigation.
- `design_files/Pages/Account.jpg` - profile display with avatar/edit button, bottom navigation.
- `design_files/Pages/Edit Profile.jpg` - profile edit form.
- `design_files/Pages/Create Charkh.jpg` - create charkh form with route preview and destination list.
- `design_files/Pages/Edit Charkh.jpg` - edit charkh form with existing values.
- `design_files/Pages/Create Destination.jpg` - create destination form.
- `design_files/Pages/Edit Destination.jpg` - edit destination form.
- `design_files/Pages/Select Location.jpg` - full-screen location picker map.
- `design_files/Pages/Route Preview.jpg` - full-screen route preview map.
- `design_files/Pages/Map.jpg` - active route map with bottom status panel.

### Components

- `design_files/Components/Button.jpg` - primary, secondary, danger button examples.
- `design_files/Components/Text Field.jpg` - filled/placeholder text field examples.
- `design_files/Components/CharkhCard.jpg` - charkh list item card.
- `design_files/Components/DestinationCard.jpg` - destination list item card.
- `design_files/Components/Ellipse 1.jpg` - circular map marker variants.

### Theme

- `design_files/Theme/Colors.pdf` - base palette.
- `design_files/Theme/Dark Theme.pdf` - semantic dark theme colors.
- `design_files/Theme/Typography.pdf` - typography scale.
- `design_files/Theme/Radius.jpg` - radius scale.
- `design_files/Theme/Spacing.jpg` - spacing scale.

### Icons

Use the SVGs from `design_files/Icons/` rather than re-drawing icons:

- `Home.svg` - bottom nav home.
- `Explore.svg` - bottom nav/charkhs tab icon.
- `Account circle.svg` and `Account circle-1.svg` - account/profile avatar/nav icon variants.
- `Barefoot.svg` - app/logo mark.
- `add.svg` - add icon.
- `arrow_back.svg` - top back icon.
- `edit.svg` - edit action icon.
- `cancel.svg` - delete/remove destination icon.
- `electric_bolt.svg` - generate/estimate action beside time/description fields.
- `map.svg` - select location button icon.
- `location_on.svg` - selected map pin.
- `my_location.svg` - current location/recenter button.
- `emoji_people.svg` - walking/current-user map marker.
- `crop_free.svg` and `fullscreen_exit.svg` - route preview expand/collapse controls.

All SVGs are 24x24 with `#F2F4F8` fills. Use `flutter_svg` or the repository-standard SVG loader and allow color/tint overrides where the design uses disabled or on-primary colors.

## 3. Design system

The page screenshots are 804px wide and mostly 1748px high. Treat the design as 2x density: 804px maps to a 402dp logical mobile width. Use scalable dimensions and safe-area insets instead of hard-coded absolute positions.

### Color tokens

Implement these tokens exactly in a Flutter `ThemeExtension` such as `KoscharkhColors extends ThemeExtension<KoscharkhColors>`. Use the dark token set as the default/current app theme.

```dart
const koscharkhDarkColors = KoscharkhColors(
  primary: Color(0xFF34D399),
  onPrimary: Color(0xFF064E3B),
  surface: Color(0xFF15171C),
  surfaceMuted: Color(0xFF20232A),
  onSurface: Color(0xFFF2F4F8),
  onSurfaceMuted: Color(0xFFA8AFBC),
  border: Color(0xFF343943),
  error: Color(0xFFFF8D93),
  onError: Color(0xFF4A080D),
  success: Color(0xFF6EE7B7),
  warning: Color(0xFFFFBF66),
  disabled: Color(0xFF2C3038),
  onDisabled: Color(0xFF747B88),
  scrim: Color(0x99000000),

  // additional palette colors shown in Colors.pdf and components
  green300: Color(0xFF6EE7B7),
  green400: Color(0xFF34D399),
  green500: Color(0xFF10B981),
  green900: Color(0xFF064E3B),
  neutral100: Color(0xFFF2F4F8),
  neutral400: Color(0xFFA8AFBC),
  neutral700: Color(0xFF343943),
  neutral900: Color(0xFF20232A),
  blackSurface: Color(0xFF15171C),
  red300: Color(0xFFFF8D93),
  red500: Color(0xFFC62828),
  red950: Color(0xFF4A080D),
  amber300: Color(0xFFFFBF66),
);
```

Also expose spacing, radius, and typography through Flutter theme/extension objects rather than scattering raw constants across widgets.

Design usage:

- App background: `surface`.
- Cards, text fields, bottom nav background: `surfaceMuted`.
- Primary buttons: `primary` background and `onPrimary` text/icon.
- Secondary buttons: `onSurfaceMuted` background and `surface`/dark text.
- Danger buttons: `red500` background and `onError` text.
- Text: `onSurface` for primary, `onSurfaceMuted` for placeholders/disabled nav.
- Destination remove circular button: `error` circle and `onError` X.
- Map polylines/markers: primary/green tones with white marker outline.

### Typography

Use JetBrains Mono throughout. Load the actual font if available in the project; otherwise use the platform monospace fallback temporarily and leave a TODO. Do not substitute a proportional font.

Theme typography:

- Title: JetBrains Mono Medium, 20dp, line-height 130%.
- Body: JetBrains Mono Regular, 16dp, line-height 145%.
- Label: JetBrains Mono Medium, 15dp, line-height 120%.
- Caption: JetBrains Mono Regular, 12dp, line-height 135%.

The screenshots use large, legible monospace text. Button text and form body values can use Body size with medium weight where needed.

### Spacing

```dart
const koscharkhSpacing = KoscharkhSpacing(
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
);
```

Main layout conventions at 402dp width:

- Page horizontal padding: 24dp.
- Vertical gap between labeled form groups: 16dp to 24dp.
- Header top area: safe area plus about 36dp before title baseline.
- Text field/button height: about 51dp.
- Bottom nav height: about 72dp plus bottom safe area if present.
- Form submit full-width button: 51dp high.

### Radius

Available radius tokens from the design:

```dart
const koscharkhRadius = KoscharkhRadius(
  sm: 8,
  md: 12,
  lg: 16,
  pill: 999,
);
```

Most cards/buttons/inputs in the screenshots appear square-cornered or minimally rounded; use radius `0` or `sm` consistently based on the design tokens, but preserve circular/pill elements as true circles with `pill`.

## 4. Data model and state

No backend/auth design is provided. Implement offline-first local state using `isar`. Persist profile, charkhs, destinations, selected coordinates, and route/session state needed to restore the visible UI.

### Dart model shape

Use Isar collections/embedded objects as appropriate. This is the intended model shape:

```dart
class Profile {
  Id id = Isar.autoIncrement;
  String firstName;
  String lastName;
  String age;
}

class Coordinates {
  double latitude;
  double longitude;
}

class Destination {
  Id id = Isar.autoIncrement;
  String stableId;
  String name;
  String description;
  Coordinates? coordinates;
  String? address;
}

class Charkh {
  Id id = Isar.autoIncrement;
  String stableId;
  String name;
  int timeMinutes;
  String? description;
  List<Destination> destinations;
  DateTime createdAt;
  DateTime updatedAt;
}

class ActiveRouteState {
  Id id = Isar.autoIncrement;
  String charkhStableId;
  DateTime startedAt;
  int elapsedSeconds;
  int etaSeconds;
  int currentDestinationIndex;
}
```

### Seed data from the designs

Initialize the app with sample data only if storage is empty:

```dart
final seedProfile = Profile(
  firstName: 'realseyed',
  lastName: '',
  age: '',
);

const seedDescription =
    'hello this is a test description for this item and i want fill it with anything.';

final seedDestinations = [
  Destination(
    stableId: 'dest-1',
    name: 'First Destination',
    description: 'First Charkh',
    coordinates: Coordinates(latitude: 40.7247, longitude: -73.9970),
  ),
  Destination(
    stableId: 'dest-2',
    name: 'Second Destination',
    description: 'Second Charkh',
    coordinates: Coordinates(latitude: 40.7270, longitude: -73.9995),
  ),
  Destination(
    stableId: 'dest-3',
    name: 'Third Destination',
    description: 'Third Charkh',
    coordinates: Coordinates(latitude: 40.7304, longitude: -74.0022),
  ),
  Destination(
    stableId: 'dest-4',
    name: 'Fourth Destination',
    description: 'Fourth Charkh',
    coordinates: Coordinates(latitude: 40.7315, longitude: -73.9942),
  ),
];

final seedCharkhs = [
  Charkh(stableId: 'charkh-1', name: 'First Charkh', timeMinutes: 20, description: seedDescription, destinations: seedDestinations),
  Charkh(stableId: 'charkh-2', name: 'Second Charkh', timeMinutes: 20, description: seedDescription, destinations: seedDestinations),
  Charkh(stableId: 'charkh-3', name: 'Third Charkh', timeMinutes: 20, description: seedDescription, destinations: seedDestinations),
];
```

Note: the Charkh card design includes a description, but the Create/Edit Charkh form does not show a description field. Preserve the form as designed. Keep `description` optional and seed a sample card description.

### State management requirements

Use `flutter_bloc` consistently for page state and user flows. Choose the lighter option when possible:

- Use `Cubit` for simple local UI state, form fields, selected tab state, profile editing, basic charkh/destination CRUD state, and simple loading/error/success states.
- Use `Bloc` when the page needs explicit event handling, multiple asynchronous operations, timers, cancellation/retry, or route calculation side effects. The best candidates are active route/session tracking and Mapbox Directions API route calculation if those flows become multi-step.
- Do not use `setState` as the primary page state mechanism except for tiny ephemeral widget-only state that does not affect app behavior.
- Persist durable state through Isar repositories/services, then expose screen-ready state through Cubit/Bloc.
- Form screens should preserve draft input while navigating to Select Location or Route Preview.
- Route calculation state should model at least: initial, loading, loaded, empty/fallback, and error-with-fallback states.

## 5. Navigation map

Use `go_router` for all app routing. Route names/paths should be simple and app-specific; these destinations and flows are required:

- `Splash`
- Main tabs:
  - `HomeTab`
  - `CharkhsTab`
  - `AccountTab`
- Stack routes:
  - `CreateCharkh`
  - `EditCharkh`
  - `CreateDestination`
  - `EditDestination`
  - `SelectLocation`
  - `RoutePreview`
  - `ActiveMap`
  - `EditProfile`

Flow behavior:

- Splash automatically advances after a short delay to the main tabs. Default landing can be `HomeTab`; Charkhs tab is where the primary app actions live.
- Bottom nav is shown only on Home, Charkhs, and Account screens.
- Charkhs `Start` opens `ActiveMap` for that charkh.
- Charkhs `Edit` opens `EditCharkh`.
- Charkhs `Delete` asks for confirmation, then removes the item.
- `+ Add Charkh` opens `CreateCharkh`.
- Destination list edit opens `EditDestination` for that destination.
- Destination list remove asks for confirmation, then removes the destination.
- `+ Add Destination` opens `CreateDestination` within the current charkh editing context.
- `Select location on map` opens `SelectLocation`; selecting returns coordinates/address to the destination form.
- Tapping the route preview or its expand icon opens `RoutePreview`; the fullscreen-exit icon returns to the previous form.
- Account edit icon opens `EditProfile`.

## 6. Shared components to implement

### AppScreen

Base screen wrapper:

- Full-screen background `surface`.
- Safe-area aware.
- Accepts `withBottomNav` or uses tab navigator.
- Main content padding 24dp on non-map pages.

### HeaderWithBack

Used by Create/Edit screens:

- Left arrow icon 24dp.
- Title text using Title style.
- Row top margin roughly 36dp from top safe area.
- Gap 16dp between icon and title.
- Entire arrow area tappable, minimum 44x44dp.

Examples:

- `Create Charkh`
- `Edit Charkh`
- `Create Destination`
- `Edit Destination`
- `Edit Profile`

### BottomNav

Three items, no labels:

- Home icon.
- Explore icon for charkhs.
- Account circle icon.

Style:

- Height about 72dp plus bottom safe area.
- Background `surfaceMuted`.
- Icons 24dp visually, centered in thirds.
- Active icon color `onSurface`; inactive icon color `onSurfaceMuted`.

### Button

Variants:

- `primary`: background `primary`, text/icon `onPrimary`.
- `secondary`: background `onSurfaceMuted`, text `surface` or near black.
- `danger`: background `red500`, text `onError`.

Default sizes:

- Full-width form button: 51dp high.
- Card buttons: 77dp to 87dp wide depending text, 34dp high.
- Use Body or Label style, centered.
- No shadow.

### TextField

Style:

- Filled rectangle, background `surfaceMuted`.
- Height about 51dp.
- Horizontal padding 16dp.
- Value text `onSurface`.
- Placeholder text `onSurfaceMuted`.
- Border: none by default.
- Font: Body.

Support single-line fields for name/time/age and a visually single-line description field as designed. Validation errors can be caption text in `error` under the field if needed.

### IconSquareButton

Used for the bolt action and my-location action:

- Square 51dp x 51dp.
- Background `primary`.
- Icon centered.
- On-primary icon color `onPrimary` or `onSurface` depending screenshot; prefer `onSurface` for electric bolt because the design shows a white bolt.

### CharkhCard

Matches `design_files/Components/CharkhCard.jpg` and `design_files/Pages/Charkhs.jpg`.

Layout:

- Full width inside 24dp page margin.
- Background `surfaceMuted`.
- Padding 16dp.
- Vertical spacing 16dp between text blocks/buttons.
- Text:
  - `Name: {name}` as label/body.
  - `Time: {timeMinutes} minutes`.
  - `Description: {description}` with wrapping.
- Buttons row:
  - Start primary.
  - Edit secondary.
  - Delete danger.
  - Horizontal gap 8dp.
- Card heights in list should fit content; design cards are about 180dp high at 402dp width.

### DestinationCard

Matches `design_files/Components/DestinationCard.jpg`.

Layout:

- Full width row, about 56dp high.
- Background `surfaceMuted`.
- Left text: `{index}. {destination.name}`.
- Right actions: edit pencil icon and remove circle icon.
- Edit icon 24dp, white.
- Remove action appears as pink/error circle with dark X; use `cancel.svg` if it can be tinted or compose a circle + X.
- Horizontal padding 16dp.
- Gap 16dp between edit and remove.

### MapMarker

Variants from `design_files/Components/Ellipse 1.jpg`:

- Number marker: circular green fill, white outline, white text.
- Current user/walking marker: circular green fill, white outline, `emoji_people` icon in white.
- Selected pin: `location_on` shape in primary green with dark center dot.
- Current-location button: green square with `my_location` icon.

## 7. Screen-by-screen requirements

### 7.1 Splash screen

Source: `design_files/Pages/Splash Page.jpg`.

- Full-screen `surface` background.
- Center content around vertical center/lower-middle.
- Row: Barefoot logo icon on the left and `KosCharkh` wordmark on the right.
- Logo and wordmark in `onSurface`.
- Wordmark is bold/medium, larger than normal title; approximate 24dp to 28dp.
- After 1 to 1.5 seconds, navigate to main tabs.

### 7.2 Home screen

Source: `design_files/Pages/Home.jpg`.

- Full-screen `surface` background.
- Empty content area.
- Bottom nav visible with Home active.

### 7.3 Charkhs screen

Source: `design_files/Pages/Charkhs.jpg`.

- Background `surface`.
- Top title `Charkhs`, 24dp page padding, Title style.
- Vertical list of CharkhCards. Seed data shows three cards.
- Cards separated by about 10dp.
- Bottom-right `+ Add Charkh` primary button above bottom nav; width about 140dp, height about 56dp.
- Bottom nav visible with Explore active.
- Content must scroll if cards exceed available height.
- Actions:
  - Start -> `ActiveMap`.
  - Edit -> `EditCharkh`.
  - Delete -> confirm and delete.
  - Add -> `CreateCharkh`.

### 7.4 Create Charkh screen

Source: `design_files/Pages/Create Charkh.jpg`.

- No bottom nav.
- Header with back and title `Create Charkh`.
- Form layout inside 24dp horizontal padding.
- Fields:
  - Label `Name`; text field placeholder `eg. First Charkh`.
  - Label `Time`; row with time input placeholder `30 (min)` and bolt square button on the right.
- Route Preview section:
  - Label `Route Preview`.
  - Map thumbnail with dark map, route polyline, numbered markers, and expand/fullscreen icon at top-right.
  - Thumbnail height about 190dp.
  - Tapping the thumbnail or icon opens `RoutePreview`.
- Destinations section:
  - Label `Destinations`.
  - List of DestinationCards.
  - `+ Add Destination` full-width primary button.
- Submit full-width primary button near bottom.
- Validation:
  - Name required.
  - Time must be positive integer minutes.
  - At least one destination is recommended; if missing, allow save but show an unobtrusive validation message or disable Submit consistently across create/edit flows.

### 7.5 Edit Charkh screen

Source: `design_files/Pages/Edit Charkh.jpg`.

Same layout as Create Charkh, but:

- Title `Edit Charkh`.
- Fields prefilled with existing charkh values, e.g. `First Charkh`, `30`.
- Submit updates existing charkh and returns to previous screen.

### 7.6 Create Destination screen

Source: `design_files/Pages/Create Destination.jpg`.

- No bottom nav.
- Header with back and title `Create Destination`.
- Fields:
  - Label `Name`; text field placeholder `eg. First Destination Name`.
  - Label `Description`; row with text field placeholder `eg. First Destination Desc...` and bolt square button.
- Full-width primary button with map icon and text `Select location on map`.
- Full-width primary `Submit` button below.
- Actions:
  - Bolt button can initially show a toast/snackbar `Suggestion coming soon` if no generation backend exists.
  - Select location opens `SelectLocation` and stores chosen coordinates/address when user taps Select.
  - Submit validates name, then appends destination to current charkh draft/context.

### 7.7 Edit Destination screen

Source: `design_files/Pages/Edit Destination.jpg`.

Same as Create Destination, but:

- Title `Edit Destination`.
- Fields prefilled; design example uses `First Charkh` for both name/description.
- Submit updates destination.

### 7.8 Select Location screen

Source: `design_files/Pages/Select Location.jpg`.

- Full-screen map background, no standard app padding.
- Dark map style, centered around a selected pin.
- Show selected pin near center using `location_on` style.
- Show current user/walking circular marker lower on map.
- Show floating my-location square button on right above bottom panel.
- Bottom panel:
  - Background `surface`.
  - Top row text: `Singer Building, ............` as selected address placeholder/truncated address.
  - Second row: `Coordinates: 33.864783264236, 53.58459456` or real selected coordinates.
  - Full-width primary `Select` button.
- Behavior:
  - User can pan/tap/drag to change selected coordinates if using a real map SDK.
  - My-location button recenters if permission is available; otherwise it can use a mock location and/or ask permission.
  - Select returns the location to the Create/Edit Destination screen.

### 7.9 Route Preview screen

Source: `design_files/Pages/Route Preview.jpg`.

- Full-screen map background.
- Draw route polyline in green.
- Draw numbered destination markers 1..N.
- Top-right `fullscreen_exit` icon button returns to previous form.
- No bottom sheet and no bottom navigation.

### 7.10 Active Map screen

Source: `design_files/Pages/Map.jpg`.

- Full-screen map background.
- Draw route polyline in green.
- Draw numbered destination markers and current walking/person marker.
- Bottom status panel:
  - Background `surface`.
  - Small white drag handle centered at top.
  - Title: `First Charkh`.
  - Two-column text rows:
    - `Elapsed Time:` right value like `30:12`.
    - `ETA:` right value like `58:12`.
    - `Next:` right value like `Third Destination`.
- Start timer when opened from Charkh card. Use Mapbox Directions duration for ETA when available. Use deterministic mock ETA if the Directions API is unavailable or not configured: `etaSeconds = charkh.timeMinutes * 60 + elapsedSeconds` or similar. Keep UI format as `MM:SS`.

### 7.11 Account screen

Source: `design_files/Pages/Account.jpg`.

- Background `surface`.
- Profile/avatar icon near top center. Use `Account circle-1.svg` or a larger composed icon.
- Edit pencil icon button at top-right.
- Text rows:
  - `First Name: {firstName || 'empty'}`
  - `Last Name: {lastName || 'empty'}`
  - `Age: {age || 'empty'}`
- Bottom nav visible with Account active.
- Edit icon opens `EditProfile`.

### 7.12 Edit Profile screen

Source: `design_files/Pages/Edit Profile.jpg`.

- Header with back and title `Edit Profile`.
- Fields:
  - `Firstname`, prefilled from profile.
  - `Lastname`, placeholder `eg. First Destination Name` as shown, although product copy can later be corrected.
  - `Age`, placeholder `eg. First Destination Name` as shown, although product copy can later be corrected.
- Submit full-width primary button.
- Validate age as numeric only if non-empty.
- Persist and return to Account screen.

## 8. Map implementation guidance

Use `flutter_map` for all map screens and map thumbnails. Use Mapbox tiles through a dedicated configurable URL value. Use the Mapbox Directions API to calculate routes between destinations and feed the returned geometry into the map polyline. The actual Mapbox tile URL/API key and Directions API configuration will be added manually later, so do not hard-code a personal key or block implementation on missing values.

Implementation requirements:

- Use `FlutterMap` with a `TileLayer` whose URL template comes from a single configuration value such as `mapboxTileUrl`.
- Keep the app stable when `mapboxTileUrl` is empty or missing. In that case, show a dark placeholder map background while still drawing the route polyline, destination markers, selected pin, and current-location/walking marker.
- Add a Mapbox Directions service that accepts an ordered list of destination coordinates and requests a route from the Mapbox Directions API. Keep the base URL/access token/profile configurable.
- Decode Mapbox Directions geometry into `LatLng` points for `PolylineLayer`. Prefer GeoJSON/polyline decoding based on the configured response format; document the chosen format in code constants.
- Use the Directions API response for route distance and duration/ETA when available. If unavailable, fall back to deterministic mock ETA and straight-line route geometry so the UI still works.
- Cache/store the latest successful route geometry/duration for a charkh when useful so route previews can render offline or after app restart.
- Use `PolylineLayer` for route previews and active routes.
- Use `MarkerLayer` for numbered destinations, selected location, current user/walking marker, and current-location controls.
- Use `LatLng` coordinates compatible with `flutter_map`.
- Do not add a different map SDK unless the repository already depends on one and the owner explicitly chooses to change it.

Map visuals:

- Background should be dark, not default light map.
- Route line: thick green stroke, approximate 8dp to 12dp logical width.
- Destination markers: green circles, white border, white number text.
- Active/current marker: green circle with walking icon.
- Selected location pin: primary green pin with dark center dot.

## 9. Implementation plan for Codex

1. Treat this as a greenfield Flutter app: create the Flutter scaffold if it does not already exist, then inspect the design references and this brief before implementing.
2. Add required dependencies if missing: `go_router`, `isar`, `isar_flutter_libs`, `flutter_map`, `latlong2`, `flutter_bloc`, and SVG/font support used by the repository. Add an HTTP client dependency only if the repository does not already have a suitable one for Mapbox Directions requests.
3. Copy/import the `design_files/Icons` SVGs into the app asset system and configure SVG loading if needed.
4. Implement Flutter `ThemeData` with KosCharkh `ThemeExtension` tokens for colors, spacing, radius, and typography. Set the default/current theme to Dark.
5. Configure JetBrains Mono font loading.
6. Build shared UI components: AppScreen, HeaderWithBack, BottomNav, Button, TextField, IconSquareButton, CharkhCard, DestinationCard, MapMarker, and map/route widgets using `flutter_map`.
7. Build Isar collections/models for Profile, Charkh, Destination, ActiveRouteState, and route cache data if needed, with seed data when storage is empty.
8. Implement `go_router` routing and all screens.
9. Wire all actions and CRUD flows through `flutter_bloc` Cubits/Blocs, choosing Cubit for lightweight screens and Bloc for heavier asynchronous/timer/route flows.
10. Add basic validation and confirmation dialogs.
11. Implement Mapbox Directions route calculation with configurable credentials and robust fallback behavior when credentials/network are unavailable.
12. Run `flutter analyze`, tests if present, and a Flutter build/run verification appropriate for the repository. Fix all issues.
13. Compare final UI against the screenshots by opening the app at 402dp-wide mobile size. Ensure screens visually match dark theme, spacing, typography, and component hierarchy.

## 10. Acceptance criteria

The implementation is complete when:

- All 12 screens represented by `design_files/Pages/` exist and are reachable through the described flows.
- Bottom navigation is shown only on Home, Charkhs, and Account.
- Charkhs can be created, edited, deleted, and started locally.
- Destinations can be created, edited, deleted, and ordered/displayed inside a charkh.
- Profile can be edited and persists locally.
- Route preview and active map screens use `flutter_map` and render dark map UI, green route line, and markers even before the Mapbox tile URL/API key or Directions API key is manually added.
- Select Location returns coordinates/address to destination forms.
- Routes are calculated through the Mapbox Directions API when credentials/configuration are available; fallback route geometry and ETA keep the app usable when unavailable.
- Page state is managed with `flutter_bloc`, using Cubit for lightweight flows and Bloc for heavier asynchronous, timer, or route-calculation flows.
- The app uses Flutter `ThemeData` plus KosCharkh `ThemeExtension` tokens for the supplied dark theme colors, spacing, radius, and JetBrains Mono typography.
- The app handles small mobile screens with scrolling where necessary.
- Lint/analyze/build succeed with no blocking errors.
- There are no raw hard-coded absolute file paths to a local zip or machine-specific design location; design references should come from the root-level `design_files/` folder, and runtime assets must be referenced through Flutter's asset system.

## 11. Known design ambiguities to preserve or handle carefully

- The design spelling alternates between `Charkh`, `Kharkh` in a component sample, and app name `KosCharkh`. Use `Charkh` for screens and model names; keep sample card text if seed data requires it.
- Create/Edit Charkh screens do not include a description field, but CharkhCard displays a description. Keep description optional and seeded; do not add a visible description field unless the product owner asks.
- Edit Profile placeholders for Lastname and Age say `eg. First Destination Name`; keep exact placeholder if pixel fidelity matters, but implement constants so copy can be corrected later.
- The location picker screenshot displays coordinates that do not match the visible SoHo/NYC map labels. Treat them as placeholder copy; real map coordinates should come from the selected location.
- Radius tokens exist, but many components look square-cornered in screenshots. Prefer visual fidelity over applying rounded corners everywhere.

## 12. Final instruction to Codex

Implement the app now in Flutter. Keep changes focused and idiomatic for the detected repository. Use `go_router`, `isar`, `flutter_bloc`, Flutter `ThemeExtension`, and `flutter_map` with a configurable Mapbox tile URL. Use the Mapbox Directions API for route geometry/distance/ETA through configurable credentials. Match the provided screenshots closely, but keep the map and route UI functional even before the owner manually adds the Mapbox tile URL/API key and Directions API configuration. After coding, run the repository's normal Flutter verification commands and report what passed or failed.
