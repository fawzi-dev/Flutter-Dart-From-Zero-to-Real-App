# Shopping List — the Module 10 challenge reference

The app **you build yourself** in challenge 10.8, and the one walked
through in the solution videos 10.9 P1 → 10.10 P2. Open it *after* you have
tried the challenge, not before.

```
flutter pub get
flutter run
```

## The structure, which is half the challenge

```
lib/
├── main.dart                 app setup only, 29 lines
├── app_colors.dart           one file naming every colour
├── models/
│   └── grocery_item.dart     pure Dart, no Flutter import
├── screens/
│   ├── list_screen.dart      owns the list and every setState
│   └── add_item_screen.dart  builds one item, pops it back
└── widgets/
    ├── grocery_tile.dart     one row
    ├── circle_checkbox.dart  the animated tick
    └── progress_header.dart  "3 of 7 bought" and the bar
```

`app_colors.dart` sits beside `main.dart` rather than in a folder of its own,
because one shared file does not need one. That is the rule from 10.7 applied
honestly: **structure follows need.**

## Which video builds what

| Lesson | The app gains |
|--------|---------------|
| 10.9 P1 · structure | The folders, `app_colors.dart`, `GroceryItem`, and a list of three hardcoded items |
| 10.9 P2 · the tile | `GroceryTile` with callbacks, the animated `CircleCheckbox`, strike-through, the `×2` pill, swipe-to-delete with a confirm dialog |
| 10.10 P1 · add | `AddItemScreen`, the quantity stepper, `pop` with a value, and the null guard |
| 10.10 P2 · derived | `ProgressHeader`, bought items sinking to the bottom, the empty state |

## The four things worth pausing on

**Everything on screen is derived, nothing is maintained.** `boughtCount`, the
percentage, the sort order — all computed inside `build`, from `items`. There
is no `int done` field anywhere, because a stored count is a count that can go
stale. This is the line the rubric actually grades.

**`GroceryTile` owns nothing.** It takes an item and one `VoidCallback`. The
`bool bought` lives on the model, in the list screen's `State`, and the tile
never calls `setState`. Put the `bool` in the tile and the tick starts lying
the moment the list re-sorts.

**`ValueKey(item)`, never `ValueKey(index)`.** Rows move here twice over —
bought items sink on every toggle *and* items get dismissed. Index keys would
be wrong within one tap.

**The add screen scrolls.** `SingleChildScrollView` in `add_item_screen.dart`
is there because a field plus a stepper plus a button does not fit under an
open keyboard on a short phone. Test forms with the keyboard open; that is bug
five of the 10.11 clinic.

## Scope

No packages, no network, no storage. Close the app and the list is gone —
that is Module 15. Colours are set on widgets directly rather than through
`ThemeData`, which is Module 13's subject.
