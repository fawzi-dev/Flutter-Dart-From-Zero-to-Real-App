# Contacts — the Module 10 lesson project

The app built in the videos, one piece per video, across lessons
10.1 P1 → 10.7 — thirteen videos, seven topics. It is also the module's worked
example of file structure, so the folders are part of the deliverable.

```
flutter pub get
flutter run
```

## What each video adds

| Lesson | The app gains |
|--------|---------------|
| 10.1 · ListView.builder | A scrolling list of names, and the unbounded-height error met on purpose |
| 10.2 · ListTile & models | The `Contact` class, `ListTile` with initial / name / phone / star, tap to toggle |
| 10.3 · Adding items | text → object → list → setState, with `.trim()`, a guard clause, and an empty state |
| 10.4 · Removing & Dismissible | Swipe to delete, the `ValueKey(index)` bug, and undo (the confirm dialog is demoed, then left to the shopping list) |
| 10.5 · Navigator push/pop | Nothing — a three-screen drill stands on its own |
| 10.6 · Passing data | The detail screen (forward, via constructor) and the add screen (back, via `pop`) |
| 10.7 · Organizing files | This structure: `models/`, `screens/`, `widgets/`, and a 20-line `main.dart` |

`steps/` holds the app as one runnable file at four points along the way, and
`steps/README.md` says which video each one belongs to. `step_4_navigate.dart`
is the file 10.7 splits — start there if you want to do the split yourself.

## Why contacts and not a shopping list

Contacts exercises every mechanic the shopping-list challenge needs, and
leaves the challenge's real work for you: a quantity stepper, a **derived**
progress header, bought items that sink to the bottom, and a shared
`app_colors.dart`.

## The four things worth pausing on

**`ValueKey(contact)`, never `ValueKey(index)`.** Keys are how Flutter tells
widgets apart between rebuilds. Keyed by index, deleting row two makes Flutter
think row three *became* row two — and the wrong row vanishes. This is the
single most common `Dismissible` bug in existence.

**The guard clause after `push`.** `Navigator.push<Contact>` returns
`Contact?` — nullable, because the user may have pressed back instead of Save.
`if (newContact == null) return;` is the whole fix, and its absence is where
nearly every student add-screen crashes. There's a test for it in `test/`.

**`ContactTile` owns nothing.** It's handed a contact and three callbacks. It
never calls `setState`, and it doesn't know a contacts list exists. It
displays, and it reports.

**The title is computed in `build`.** `Text('Contacts (${contacts.length})')`
can't go stale, because it's derived rather than maintained. Same idea the
challenge grades as "derived, not hand-maintained".

## Two taps, two jobs

Tapping the **row** opens the detail screen. Tapping the **star** toggles the
favourite. The star is its own `IconButton` so the two never fight — worth
knowing, because if you put `onTap` on the whole tile and an `Icon` inside it,
you get one behaviour and expect two.

## Scope

No packages, no network, no storage. Close the app and the contacts you added
are gone — that's Module 15.
