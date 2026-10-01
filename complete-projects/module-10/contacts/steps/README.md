# Steps — Module 10, the contacts app

Four single-file snapshots, then the folder split.

| File | End of | What it adds |
|---|---|---|
| `step_1_list.dart` | **10.2 P2** | `ListView.builder`, a `Contact` class, a `ListTile` per row |
| `step_2_add.dart` | **10.3 P2** | the four-step add pipeline, an empty state, a count |
| `step_3_delete.dart` | **10.4** | `Dismissible`, keyed by the contact, with undo |
| `step_4_navigate.dart` | **10.6 P2** | a second and third screen, data forward and back |
| `lib/` (the folders) | **10.7** | the same code, filed |

Every snapshot is one runnable file, because that is genuinely what the app
was until 10.7. Watch the line count: 92, 164, 209, 303. Nothing in step 4 is
wrong — it is just all in one place, which is the entire argument of 10.7.

## Why there is no step 5

`step_4_navigate.dart` is the app the morning of 10.7, and `lib/` is the app
that evening. A fifth snapshot would sit between them, and there is nothing
between them: **10.7 moves code, it does not change it.**

So do the split yourself, from step 4, and only then open `lib/` to compare.
A finished multi-file snapshot in this folder would just be the answer sheet.

- **10.5** — `Navigator.push` and a second screen. Screens can still share one
  file while you learn the mechanics.
- **10.6** — data forward through the constructor, and back through
  `Navigator.pop(context, newContact)`. Plus the null check for when somebody
  presses back instead of saving.
- **10.7** — `models/`, `screens/`, `widgets/`, and the tile extracted into a
  widget that takes callbacks instead of owning state.

## The two bugs worth reproducing

Both of these are shown in the lessons on purpose, and both are worth
breaking on purpose in your own copy:

1. **`ValueKey(index)`** in `step_3_delete.dart`. Change the key, delete the
   middle contact, and watch the wrong one disappear. Then change it back.
2. **The missing null check** in `step_4_navigate.dart`. Delete the
   `if (newContact == null) return;` line, open the add screen, and press the
   back arrow instead of saving. That is the bug most student projects ship
   with, and it is one line.

## What `main.dart` should look like at the end

Twenty-odd lines: app setup, and the first screen. Nothing else. When a
stranger opens your project, that file tells them where to start.
