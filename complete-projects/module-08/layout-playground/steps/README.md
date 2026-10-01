# The playground, stage by stage

Each file is `lib/main.dart` exactly as it stood **at the end** of one video.
Drop one into `lib/` and run it to see where a lesson finished, or diff two of
them to see what the lesson actually changed.

Every file is self-contained: the palette, the app, the screen, and the
`ColorCard` component, in that order. Nothing imports anything but Material.

## The one component

`ColorCard` is a coloured box with a word in the middle. It takes a `title`
and a `color`, and optionally a `width` and a `height`. It is written once in
lesson 8.1 and **never changes again** except in 8.5, where it gains
`maxLines` and `ellipsis`.

That is deliberate. For the whole module the app is three cards — only the
widget *holding* them changes. Nobody has to re-read the app to follow the
lesson, because there is nothing in the app to read.

## The steps

| File | Lesson | The concept | What changes |
|---|---|---|---|
| `step_1_row_and_column.dart` | 8.1 | Row, Column, `children`, main/cross axis, `mainAxisSize` | The whole app: three cards in a Column, then a Row |
| `step_2_alignment_and_spacing.dart` | 8.2 | `MainAxisAlignment`, `CrossAxisAlignment`, `SizedBox`, the gap scale | The cards get three different heights, so the cross axis becomes visible |
| `step_3_expanded_and_flex.dart` | 8.3 | `Expanded`, `flex`, `Flexible` | Three rows on one screen: without, with, and with flex numbers |
| `step_4_const_and_static.dart` | 8.4 | `const`, `static`, where a value lives | No layout change. The colours move onto an `AppColors` class |
| `step_5_overflow.dart` | 8.5 | The RenderFlex overflow, and three fixes | Fixed widths that do not fit, then `SingleChildScrollView` |
| `step_6_stack_and_positioned.dart` | 8.6 | `Stack`, `Positioned` | One big card with a FEW LEFT pill on its corner |

`lib/main.dart` is the same file as `step_6`, so the project always runs.

Lesson **8.7** (DevTools) changes no code — it opens step 6 and step 3 and
*looks* at them — so it has no snapshot. What to try is at the bottom of
this file.

Lessons **8.8, 8.9 and 8.10** do not use this project at all. That is the
ticket booking app, in `../ticket-booking/`.

## Why the cards are boring

The cards never change, so every single thing that moves on screen was caused
by the one property that lesson changed. That is the entire reason this
project exists, and it is why the cards are boring on purpose.

## 8.7 — DevTools, the lesson with no code

1. Open the Flutter Inspector. Select the `Stack` on the device.
2. Walk the widget tree in the panel and match it to the file.
3. Open the Layout Explorer on step 3's third row: the flex numbers are drawn
   for you.
4. Change a flex value **in the Explorer** and watch the device move.
5. Re-break step 5 — take the `SingleChildScrollView` off — and find the
   overflow highlighted in the tree, not just on the screen.
6. The habit: look before you guess.

## Two things worth keeping honest

- **Nothing here is tappable.** No `onPressed`, no state, no packages. This is
  a layout module and buttons arrive in Module 9.
- **Check every step twice:** rotate the device, then make the window narrow.
  Steps 1 to 4 survive both. Step 5 is *supposed* to fail until it is fixed,
  which is the only reason it is interesting.
