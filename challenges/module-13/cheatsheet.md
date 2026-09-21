# Cheat Sheet — Responsive Layout & Dark Mode (Module 13)

## The one idea
**Stop hardcoding, ask.** Don't hardcode a width — ask how much space you have. Don't hardcode a color — ask the theme for the role.

## MediaQuery — ask the DEVICE
```dart
final size = MediaQuery.sizeOf(context);          // whole screen (use ...Of forms)
final orientation = MediaQuery.orientationOf(context);
SafeArea(child: body)                             // dodge notches / system bars
```
- `sizeOf` only rebuilds on size change (better than `MediaQuery.of(context).size`).
- It's the **whole screen** — usually NOT what a widget wants. For that, use ↓

## LayoutBuilder — ask THIS widget's box
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) return const NarrowLayout();   // 600 = phone/tablet line
    return const WideLayout();
  },
)
```

## Responsive grid — derive the columns
```dart
final columns = (constraints.maxWidth / 260).floor().clamp(2, 4);  // NOT a fixed number
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: columns, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.1),
  itemCount: items.length,
  itemBuilder: (context, i) => Card(child: ...),
)
```

## Theming — colors come from ROLES
```dart
final colors = Theme.of(context).colorScheme;
final text = Theme.of(context).textTheme;

colors.surface / colors.onSurface           // card bg / text on it (paired)
colors.primary / colors.onPrimary           // accent / content on it
colors.primaryContainer / colors.onPrimaryContainer
colors.onSurfaceVariant                     // muted secondary text
text.titleMedium / text.bodySmall           // sized+colored for the theme
```
- Every background/text color from here — **no `Colors.white`, `Colors.black`, or structural hex.**
- `Card`, `FilledButton`, etc. already theme themselves — don't set their colors.
- The `on` prefix = "content that sits on top of"; the pair is guaranteed readable.

## Dark mode — 3 properties + state above MaterialApp
```dart
// root widget is STATEFUL and holds:
ThemeMode _themeMode = ThemeMode.system;   // follow the phone by default

MaterialApp(
  theme:     ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: seed), useMaterial3: true),
  darkTheme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: seed,
                       brightness: Brightness.dark), useMaterial3: true),  // same seed!
  themeMode: _themeMode,
  home: Screen(onToggle: _cycle),          // pass a CALLBACK down to the screen
)

void _cycle() => setState(() {
  _themeMode = switch (_themeMode) {
    ThemeMode.system => ThemeMode.light,
    ThemeMode.light  => ThemeMode.dark,
    ThemeMode.dark   => ThemeMode.system,
  };
});
```
- `ThemeMode.system` = follow the OS setting, auto-updating. Default to it.
- State lives where it's read (in the `MaterialApp` builder), same as Module 9.
- Test BOTH ways: flip the phone's system setting, and use your in-app toggle.
