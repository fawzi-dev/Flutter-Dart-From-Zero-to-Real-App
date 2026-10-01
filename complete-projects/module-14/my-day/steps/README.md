# Steps — Module 14, My Day

My Day is a four-folder project from **slice one**, so there is no honest
single-file snapshot of it. Four whole project trees, each 95% identical to
the next, would be noise rather than help.

So this folder has the one thing a snapshot cannot give you: **the bug, on
its own, runnable.**

| File | From | What it is |
|---|---|---|
| `step_bug_controllers_in_build.dart` | **14.5** | **Broken on purpose.** Type a title, tap a chip, watch it vanish. |

## Run it. Do not just read it.

Reading "build runs again and recreates the controller" is not the same as
typing a sentence and watching it disappear with no error, no crash, and
nothing to read. That silence is what makes this bug genuinely confusing the
first time, and it is why 14.5 stages it deliberately.

Debug it with the ladder from 14.2 before you look at the fix.

## The four slices, and what each one adds

The build order matters more than any individual file here. **Each slice runs
before the next one starts** — that way, if you run out of time or energy,
you have a working app with fewer features rather than a broken app with all
of them.

| Slice | Video | What exists at the end of it |
|---|---|---|
| 1 | **14.4** | `Task`, `Priority`, `colorForPriority`, `app_colors.dart`, a stateful home screen owning the list, `TaskTile`, the dashboard header with its progress ring. **One task visible.** |
| 2 | **14.5** | `AddTaskScreen`, the FAB, and both exits handled — save returns a `Task`, back returns `null`. |
| 3 | **14.6** | `TaskDetailScreen` (which pops back a *string*, and lets home decide), `Dismissible` with a confirmation, and `QuoteCard` — its own stateful widget, owning its own loading. |
| 4 | **14.7** | The theme seeded from `app_colors.dart`, the empty state, the app name and icon. |

## Two decisions worth reading the finished code for

**`TaskDetailScreen` does not delete anything.** It pops back `'toggle'` or
`'delete'`, and the home screen — which owns the data — decides what that
means. It looks fussy here. In Module 16, when the same app moves to the
cloud, it is the reason **only one place has to change.**

**`QuoteCard` owns its own `isLoading` and `error`,** rather than putting them
in the home screen's State. Turn on airplane mode and look: the quote fails,
and the task list keeps working perfectly. Each piece owns the state it needs
and nothing more.

## And the tests

`test/logic_test.dart` is lesson **14.9**, and it is five tests over two pure
functions. Run `flutter test`. Then break `colorForPriority` on purpose and
run it again — a test you have never seen fail is a test you do not trust.
