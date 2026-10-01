# Steps — Module 13, the adaptive ticket screen

Module 13 changes one screen four times, and each change is small and additive.
So this is a map rather than a folder of snapshots — the diffs are the lesson,
and they are all in `lib/main.dart`.

| Lesson | What changed |
|---|---|
| **13.2** | Nothing structural — you *read* the screen with `MediaQuery` and confirm `SafeArea` is doing its job. |
| **13.3** | The body is wrapped in a `LayoutBuilder` and branches at **600**. Narrow keeps the Column; wide puts the poster beside the controls. |
| **13.4** | Every hardcoded colour becomes a **role** from `Theme.of(context).colorScheme`. |
| **13.5** | `darkTheme` from the same seed, `themeMode` from state, and a toggle. |

## The order is the lesson

**Layout first. Dark mode last.** 13.5 is about fifteen lines *only* because
13.4 already moved every colour out of a literal and into a role. Do them the
other way round and you do the colour work twice.

If you want to feel that: comment out the theme roles in the card, set
`themeMode: ThemeMode.dark`, and look at what stays stubbornly white.

## Compare against Module 8 and 9

The honest way to see this module's diff is to open three files side by side:

- `complete-projects/module-08/ticket-booking/lib/main.dart` — the layout
- `complete-projects/module-09/ticket-booking-v2-interactive/lib/main.dart` — plus state
- `complete-projects/module-13/ticket-booking-v3-adaptive/lib/main.dart` — plus responsive and themed

**Module 8 built it. Module 9 gave it a memory. Module 13 made it work on
hardware you do not own, in a room whose lights you cannot see.**

## Two things that must be seen live, not in a still

- **The reflow.** `flutter run -d chrome`, then drag the window edge across 600.
- **System dark.** Flip the *phone's own* dark setting, not an in-app toggle,
  and watch the app follow with no code change at all.
