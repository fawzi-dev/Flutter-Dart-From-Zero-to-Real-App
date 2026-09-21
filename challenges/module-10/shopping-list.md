# Challenge — Shopping List

The canonical real app: list → add → check off → delete. Half the apps on your phone are this skeleton with different paint. It's also your first **multi-file** app — the structure is part of the deliverable.

**Starter:** `starter-projects/module-10/shopping-list/` — empty Scaffold. You create the folders and files yourself; the organization is graded, not just the behavior.

## The product
- **List screen** (`My Groceries`): every item via `ListView.builder`, each one a **rounded card**; a **live progress header** — "3 of 7 bought" and a filling bar — that updates as you shop; tap to check off (bought items go struck-through and **sink to the bottom**); a quantity shown in a little pill (`×2`); swipe to delete **with a confirmation dialog**; a friendly empty state when the list is empty.
- **Add screen:** opened by a `FloatingActionButton.extended` ("Add item"); a name field (validated — no empty names) and a **quantity stepper**; Add returns the new item to the list screen.
- **A shared `app_colors.dart`** used by every screen and widget.

## Requirements
1. A `GroceryItem` model class (`name`, `quantity`, `bought`) in `lib/models/`.
2. File structure (lesson 10.7): `models/`, `screens/`, `widgets/`, with the tile as its own widget. **And a shared `lib/app_colors.dart`** imported across the app — this is the concrete cash-out of Module 9's promise: *a file earns its place the moment something is shared.* One color source, no literals scattered through the tree.
3. Add screen returns the item via `Navigator.pop(context, item)`; the list screen `await`s it and `setState`s. **Both exits handled** — save returns an item, back returns null. **All state lives in the list screen.** The add screen owns nothing.
4. Delete = `Dismissible` + `AlertDialog` confirm ("Remove Milk?" Cancel/Remove), keyed by the **item**, not the index.
5. A **live "bought" indicator derived from the list**, computed inside `build` so it can never go stale. The reference renders it as a progress bar + "X of Y" label; a plain count also passes — the graded part is *derived, not hand-maintained.*
6. Empty state: when `items.isEmpty`, show an icon + message instead of the list.

## Rubric
- [ ] `ListView.builder` — not a `Column` of children
- [ ] Add → progress updates → check off → strike-through + item sinks → swipe → dialog → delete → empty state appears when the last item goes
- [ ] The tile receives its item + callbacks via constructor — it does **not** own state
- [ ] Every color comes from `app_colors.dart`; there are no stray color literals in the widget tree
- [ ] No unbounded-height errors (if you hit one: lesson 8.4, then 10.1 — wrap the list in `Expanded`)
- [ ] Three folders, a shared colors file, clean imports

## Hints (gated)
- **Order:** model → list screen with 3 hardcoded items → tile widget → check-off toggle → FAB + add screen returning a value → delete → progress header + empty state. Run between EVERY step.
- Awaiting the add screen: `final newItem = await Navigator.push(...)` — then null-check (the user may have backed out — `if (newItem == null) return;`).
- **Progress bar:** `LinearProgressIndicator(value: done / total)` — `value` is a fraction from 0 to 1, computed in `build`. Guard `total == 0` so you never divide by zero on an empty list.
- **Custom checkbox (optional polish):** a `GestureDetector` around an `AnimatedContainer` whose color flips on `bought` — describe the two states, Flutter animates between them for free. A plain `Checkbox` also passes.
- **Sink bought items:** one `.sort()` with a comparator, run inside `build` so it's always fresh (think about *when* `build` happens).

## Bonus
When *every* item is bought, swap the progress header for a little "All done! 🎉" celebration. No new state — it's all derived: just check `done == total` in `build`.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 2 hours. Reference: `complete-projects/module-10/shopping-list/`.
