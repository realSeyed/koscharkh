---
id: 0001-design-system-and-ui-tokens
title: Design System and UI Tokens Governance
status: accepted
applies_to: ["lib/features/**/presentation/**"]
supersedes: null
superseded_by: null
tags: [ui, design-system, tokens]
---

# ADR 0001: Design System and UI Tokens Governance

## Status
**Accepted** (2026-09-16)

## Context & Problem Statement

KosCharkh features a specialized, high-contrast industrial navigation interface. Its visual identity relies on sharp zero-radius geometry (`BorderRadius.zero`), dark background surfaces (`#15171C`), vibrant mint/emerald accents (`#34D399`), and monospace typography (**JetBrains Mono** across all text hierarchies).

Standard Flutter Material 3 widgets introduce rounded corners, elevation drop-shadows, default variable-width typefaces, and generic platform colors that directly violate KosCharkh's design identity. Furthermore, ad-hoc inline styling (e.g. hardcoding `Color(0xFF...)`, `Colors.white`, arbitrary paddings, or raw `TextField` instances) fragments the UI architecture and prevents global theme management.

This document establishes machine-actionable governance rules and normative RFC 2119 directives enforcing KosCharkh's proprietary design system across all feature presentation code (`lib/features/**/presentation/**` and `lib/src/features/**/presentation/**`).

---

## Normative Directives (RFC 2119)

### 1. Color Tokens & Surface Resolution
1.1. Presentation code **MUST** consume colors exclusively through the `context.colors` extension property (`KoscharkhThemeX`).  
1.2. Developers **MUST NOT** use raw Flutter Material palette literals (e.g., `Colors.green`, `Colors.white`, `Colors.black`, `Colors.grey`).  
1.3. Developers **MUST NOT** instantiate inline `Color(0x...)` literals in feature presentation files.  
1.4. Developers **MUST NOT** rely on raw `Theme.of(context).colorScheme.*` where a dedicated semantic token exists on `context.colors` (`primary`, `onPrimary`, `surface`, `surfaceMuted`, `onSurface`, `onSurfaceMuted`, `border`, `error`, `onError`, `success`, `warning`, `disabled`, `onDisabled`, `scrim`).

### 2. Geometry & Spacing
2.1. Interactive buttons and text inputs **MUST** maintain sharp, rectangular corners (`BorderRadius.zero`). Rounded corners (`RoundedRectangleBorder(borderRadius: BorderRadius.circular(...))`) **MUST NOT** be applied to buttons or form inputs.  
2.2. Screen horizontal margins **MUST** adhere to the standardized 24dp boundary (`context.spacing.xl` or `const EdgeInsets.symmetric(horizontal: 24)`).  
2.3. Margin and padding dimensions **MUST** map to the `context.spacing` scale:
   - `xs`: 4dp
   - `sm`: 8dp
   - `md`: 12dp
   - `lg`: 16dp
   - `xl`: 24dp
   - `xxl`: 32dp

### 3. Typography & Text Themes
3.1. Text styles **MUST** be resolved exclusively through `Theme.of(context).textTheme.<role>`:
   - Screen & section headers: `textTheme.titleLarge` (JetBrains Mono 20sp, w500)
   - Input text & primary body: `textTheme.bodyMedium` / `textTheme.bodyLarge` (JetBrains Mono 16sp, w400)
   - Button text & field labels: `textTheme.labelLarge` (JetBrains Mono 15sp, w500)
   - Metadata, cards, captions & errors: `textTheme.bodySmall` (JetBrains Mono 12sp, w400)  
3.2. Developers **MUST NOT** declare `TextStyle(fontFamily: ...)` or invoke raw `GoogleFonts.*` within feature screens. The font family is configured centrally at the theme root.

### 4. Component Wrappers vs. Raw Material Widgets
4.1. **Screen Shell**: Standard content screens **MUST** use `AppScreen`. Developers **MUST NOT** instantiate raw `Scaffold` with boilerplate `SafeArea` and padding on standard feature screens. (Raw `Scaffold` is permitted solely for full-bleed map stacks in `ActiveMapScreen`, `SelectLocationScreen`, and `RoutePreviewScreen`).  
4.2. **Screen Headers**: Top navigation chrome **MUST** use `HeaderWithBack`. Developers **MUST NOT** use raw `AppBar` or `SliverAppBar`.  
4.3. **Buttons**: Action buttons **MUST** use `KosButton` or `IconSquareButton`. Developers **MUST NOT** use `ElevatedButton`, `FilledButton`, `OutlinedButton`, or `TextButton` directly in presentation code.  
4.4. **Text Inputs**: Text inputs **MUST** use `KosTextInput`. Developers **MUST NOT** instantiate raw `TextField` or `TextFormField`.  
4.5. **Labels & Validation**: Form fields **MUST** use `FieldLabel` for field titles and `ErrorCaption` for validation errors.  
4.6. **Icons & Assets**: Vector iconography **MUST** use `KosSvgIcon` with typed asset constants from `KosAssets`. Developers **MUST NOT** use raw `SvgPicture.asset` or `Icon(Icons.*)` (except for internal map marker symbols).  
4.7. **Destructive Confirmations**: Destructive confirmations **MUST** invoke `confirmDestructiveAction(context, ...)`. Developers **MUST NOT** construct ad-hoc `AlertDialog` or `showDialog` trees.  
4.8. **Bottom Navigation**: Tab shell navigation **MUST** use `KosBottomNav`. Developers **MUST NOT** use Material `NavigationBar` or `BottomNavigationBar`.

---

## Side-by-Side Dart Code Examples

### 1. Color Token Consumption

```dart
// ❌ INCORRECT: Raw literals and Material colors
Container(
  color: Colors.black87,
  child: Text(
    'Active Route',
    style: TextStyle(color: Color(0xFF34D399)),
  ),
);

// ✅ CORRECT: Semantic tokens via KoscharkhThemeX
Container(
  color: context.colors.surfaceMuted,
  child: Text(
    'Active Route',
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: context.colors.primary,
    ),
  ),
);
```

### 2. Action Buttons

```dart
// ❌ INCORRECT: Raw Material buttons with rounded geometry
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.teal,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  onPressed: () => context.read<CharkhFormCubit>().save(),
  child: const Text('Submit'),
);

// ✅ CORRECT: Proprietary KosButton with zero radius and variant mapping
KosButton(
  text: 'Submit',
  variant: KosButtonVariant.primary,
  onPressed: () => context.read<CharkhFormCubit>().save(),
);

// ✅ CORRECT: Secondary action button
KosButton(
  text: 'Edit Charkh',
  variant: KosButtonVariant.secondary,
  onPressed: onEdit,
);

// ✅ CORRECT: Square 51x51 action button
IconSquareButton(
  asset: KosAssets.electricBolt,
  onPressed: () => showSuggestionComingSoon(context),
);
```

### 3. Text Inputs & Form Composition

```dart
// ❌ INCORRECT: Raw TextFormField with custom decoration
TextFormField(
  initialValue: state.name,
  decoration: const InputDecoration(
    labelText: 'Charkh Name',
    border: OutlineInputBorder(),
  ),
  onChanged: cubit.nameChanged,
);

// ✅ CORRECT: FieldLabel + KosTextInput + ErrorCaption pattern
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const FieldLabel('Name'),
    KosTextInput(
      value: state.name,
      placeholder: 'eg. First Charkh',
      onChanged: cubit.nameChanged,
    ),
    ErrorCaption(state.validationMessage),
  ],
);
```

### 4. Screen Scaffolding & Navigation Headers

```dart
// ❌ INCORRECT: Standard Material Scaffold and AppBar
class MyFeatureScreen extends StatelessWidget {
  const MyFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Destinations'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: DestinationContent(),
      ),
    );
  }
}

// ✅ CORRECT: AppScreen shell with HeaderWithBack
class MyFeatureScreen extends StatelessWidget {
  const MyFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          HeaderWithBack(title: 'Saved Destinations'),
          DestinationContent(),
        ],
      ),
    );
  }
}
```

### 5. Vector Iconography

```dart
// ❌ INCORRECT: Raw Material Icon or untyped SvgPicture
IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.white),
  onPressed: () => Navigator.pop(context),
);

// ❌ INCORRECT: Raw SvgPicture with string path
SvgPicture.asset(
  'assets/icons/arrow_back.svg',
  width: 24,
  height: 24,
);

// ✅ CORRECT: KosSvgIcon with KosAssets constant
KosSvgIcon(
  KosAssets.arrowBack,
  size: 24,
  color: context.colors.onSurface,
);
```

### 6. Destructive Action Confirmation

```dart
// ❌ INCORRECT: Custom ad-hoc AlertDialog
final confirmed = await showDialog<bool>(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Delete Destination'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
      TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
    ],
  ),
);

// ✅ CORRECT: Standardized confirmDestructiveAction helper
final confirmed = await confirmDestructiveAction(
  context,
  title: 'Delete Destination',
  message: 'Remove ${destination.name} from saved destinations?',
);
```

---

## Automated Verification & CI Rules

To ensure strict compliance, the following ripgrep (`rg`) rules must be executed in CI and local pre-commit checks. Any match in feature presentation files constitutes a failing build.

### 1. Detect Raw Material Colors
Flags violations of Rule 1.2:
```bash
rg --glob "lib/**/presentation/**.dart" "Colors\."
```

### 2. Detect Inline Color Literals
Flags violations of Rule 1.3:
```bash
rg --glob "lib/**/presentation/**.dart" "Color\(0x"
```

### 3. Detect Banned Raw Material Buttons
Flags violations of Rule 4.3 (`ElevatedButton`, `FilledButton`, `OutlinedButton`, `TextButton`):
```bash
rg --glob "lib/**/presentation/**.dart" "\b(ElevatedButton|FilledButton|OutlinedButton|TextButton)\b"
```

### 4. Detect Banned Raw Text Inputs
Flags violations of Rule 4.4 (`TextField`, `TextFormField`):
```bash
rg --glob "lib/**/presentation/**.dart" "\b(TextField|TextFormField)\b"
```

### 5. Detect Banned Material AppBars
Flags violations of Rule 4.2 (`AppBar`, `SliverAppBar`):
```bash
rg --glob "lib/**/presentation/**.dart" "\b(AppBar|SliverAppBar)\b"
```

### 6. Detect Banned Bottom Navigation Bars
Flags violations of Rule 4.8 (`NavigationBar`, `BottomNavigationBar`):
```bash
rg --glob "lib/**/presentation/**.dart" "\b(NavigationBar|BottomNavigationBar)\b"
```

### 7. Detect Raw SvgPicture Instantiation
Flags violations of Rule 4.6:
```bash
rg --glob "lib/**/presentation/**.dart" "SvgPicture\.asset"
```

---

### Composite CI Verification Command

The following single-line ripgrep command executes the full audit suite. If any matches are found, the command exits with code 0 (triggering a CI failure):

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

*Expected Result*: Exit code 1 with zero output lines.

#### Git Grep Equivalent (Windows / Environments without `rg`):
```bash
git grep -E "Colors\.|Color\(0x|\b(ElevatedButton|FilledButton|OutlinedButton|TextButton)\b|\b(TextField|TextFormField)\b|\b(AppBar|SliverAppBar)\b|\b(NavigationBar|BottomNavigationBar)\b|SvgPicture\.asset" -- "lib/**/presentation/**.dart"
```
