# Challenge — Adaptive Gallery

One screen, two skills: a layout that reflows from a phone list to a tablet grid, and colors that follow the system's light/dark setting with an in-app override. The two most common "this looks amateur" tells, fixed.

**Starter:** `starter-projects/module-13/adaptive-gallery/` — a themed `MaterialApp` shell.

## The product
A gallery of cards (content list provided below — don't invent data):
- **Narrow (phone, `< 600`):** a single-column `ListView` of cards (icon beside text).
- **Wide (tablet / landscape / desktop, `≥ 600`):** a `GridView` whose **column count grows with the width** (icon-on-top tiles).
- **Theme:** follows the system light/dark setting by default, with an app-bar toggle that cycles **System → Light → Dark**.

## The content (copy this in)
```dart
class GalleryItem {
  const GalleryItem({required this.title, required this.subtitle, required this.icon});
  final String title;
  final String subtitle;
  final IconData icon;
}

const galleryItems = <GalleryItem>[
  GalleryItem(title: 'Sunrise Hike', subtitle: 'One very cold summit, worth every step.', icon: Icons.landscape),
  GalleryItem(title: 'City Lights', subtitle: 'The skyline from the rooftop after midnight.', icon: Icons.location_city),
  GalleryItem(title: 'Old Bookshop', subtitle: 'A first edition behind the cookbooks.', icon: Icons.menu_book),
  GalleryItem(title: 'Harbour Morning', subtitle: 'Boats, coffee, nowhere to be.', icon: Icons.sailing),
  GalleryItem(title: 'Desert Road', subtitle: 'Two hundred kilometres of sky.', icon: Icons.directions_car),
  GalleryItem(title: 'Night Market', subtitle: 'Every stall a different smell.', icon: Icons.storefront),
  GalleryItem(title: 'Studio Session', subtitle: 'Take forty-one. The one we kept.', icon: Icons.music_note),
  GalleryItem(title: 'First Snow', subtitle: 'The whole street went quiet at once.', icon: Icons.ac_unit),
];
```

## Requirements
1. **One screen, one `LayoutBuilder`.** The list/grid choice is a branch on `constraints.maxWidth` inside a single build — not two separate screen classes.
2. **Derived columns.** The grid's `crossAxisCount` is computed from the width, e.g. `(constraints.maxWidth / 260).floor().clamp(2, 4)` — never a hardcoded number.
3. **No hardcoded structural colors.** Every background and text color comes from `Theme.of(context).colorScheme` / `textTheme` (`surface`, `onSurface`, `primary`, `primaryContainer`/`onPrimaryContainer`, `onSurfaceVariant`). Zero `Colors.white` / `Colors.black` / stray hex on backgrounds.
4. **Real dark mode.** A `theme` and a `darkTheme` from the **same seed** (dark adds `brightness: Brightness.dark`); `themeMode` driven by state starting at `ThemeMode.system`; the state lives **above** `MaterialApp` (stateful root) and the app bar gets a callback.
5. **`SafeArea`** somewhere sensible so nothing hides under a notch.

## Rubric
- [ ] Dragging a Chrome window narrow→wide **reflows** list → grid, live
- [ ] Columns **grow** (2→3→4) as the window widens, and cap — no infinite slivers
- [ ] Flipping the **system** dark setting recolors the whole app with **no code change**
- [ ] The in-app toggle cycles System → Light → Dark and everything recolors (nothing stuck white)
- [ ] Grep your code: no structural `Colors.white`/`Colors.black`/background hex remains

## Hints (gated)
- **Order:** get the `ListView` working first (Module 10), *then* wrap it in `LayoutBuilder` and add the grid branch, *then* swap colors for theme roles, *then* add `darkTheme` + toggle. Dark mode is trivial once colors are roles and painful before.
- **Grid:** `GridView.builder` + `SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: columns, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.1)`.
- **Toggle state:** the root widget that builds `MaterialApp` must be a `StatefulWidget` holding a `ThemeMode`; pass a `VoidCallback` down to the app-bar `IconButton`, cycle with a `switch`.

## Bonus
On a very wide screen (a second breakpoint at ~900), go **master-detail**: the grid on the left, a details panel on the right (`Row(children: [Expanded(grid), Expanded(detail)])`), tapping a card fills the panel instead of pushing a new screen. The layout every tablet mail app uses.


**Difficulty:** Level 2 — Independent. The gated hints are the Level 1 (Guided) path; the master-detail bonus is Level 3.

⏱️ Minimum 75 minutes. Reference: `complete-projects/module-13/adaptive-gallery/`.
