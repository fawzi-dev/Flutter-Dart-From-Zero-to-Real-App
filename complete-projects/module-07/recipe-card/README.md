# Recipe Card — the Module 7 lesson project

This is the app built in the videos, one piece per video, across
lessons **7.8 → 7.13**, with one last change in **7.15**. `lib/main.dart` is
the finished card.

Run it:

```
flutter pub get
flutter run
```

## What each video adds

| Step | Lesson | The card gains | Snapshot |
|------|--------|----------------|----------|
| 1 | 7.8 · Your own widget | Scaffold, AppBar "Kitchen", the dish name, and `IngredientLine(amount:, item:)` used three times | `steps/step_1_skeleton.dart` |
| 2 | 7.9 · Text & styling | 28pt bold title, `BREAKFAST · 20 MINUTES` letter-spaced, a description that ellipsises at two lines | `steps/step_2_words.dart` |
| 3 | 7.11 · Container | The white box: padding 20, corners 16, a soft shadow — and padding on each ingredient row | `steps/step_3_box.dart` |
| 4 | 7.12 · Images & pubspec | `assets/shakshuka.jpg` above the title, `assets/cook.jpg` in a `CircleAvatar`, side by side in a `Row` | `steps/step_4_photo.dart` |
| 5 | 7.13 P1 · pub.dev | `google_fonts` on the dish name — one command, one import, and the `const` that has to come off | `steps/step_5_font.dart` |
| 6 | 7.13 P1 · Finishing touches | Palette constants, tomato AppBar, the INGREDIENTS heading, two 1px rules. No new widgets — all 7.9 and 7.11 | `steps/step_6_polish.dart` |
| 7 | 7.15 P2 · Overflow | `SafeArea` + `SingleChildScrollView`. Identical to `lib/main.dart` | `steps/step_7_scroll.dart` |

Two lessons touch the card without changing its markup, so they have no
snapshot of their own: **7.10** (`const` and your editor) is about what the
editor is telling you, and **7.15 Part 1** breaks the finished card on purpose
and reads each error rather than adding anything.

The snapshots in `steps/` all compile and all have a `main()`, so any one of
them can be copied over `lib/main.dart` to jump straight to that point in the
build — useful if you want to pick up from the middle.

## Before you run it

`google_fonts` fetches the font on first launch, so your machine needs an
internet connection the first time the app runs.

## Why a recipe and not a profile

Module 7's challenge (7.17) is the **About Me Card** — a circular photo, a
name, a badge, and icon rows. This card is deliberately a different shape:
a hero photo, a stat line, a list of ingredient rows.

Same widgets, different screen. You cannot copy this file into the
challenge; you have to apply what you learned. That is the whole reason the
lesson project is a recipe.

## Scope

Everything here is Module 7 vocabulary: `Text` + `TextStyle`, `Container`
with padding / margin / decoration, `Image.asset`, `CircleAvatar`, one
package, and custom `StatelessWidget` classes.

**No state anywhere** — this screen never changes. That starts in Module 9.
