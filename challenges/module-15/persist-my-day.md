# Challenge — Make My Day Remember (local storage)

Take My Day — which forgets everything when you close it — and make its tasks **survive a restart**, using `shared_preferences`.

**Start from:** your own Module 14 capstone, or `starter-projects/module-15/my-day-local/` (the complete My Day app).

## The one test that matters
Add three tasks, check one off, **fully close the app** (swipe it away), reopen it → all three are there, the checked one still checked. That's the whole goal.

## Requirements
1. A **`TaskStorage` service** in `lib/services/` with `save(List<Task>)` and `load()`. All `shared_preferences` and JSON code lives here — **no screen imports `shared_preferences`** (same boundary as the weather service).
2. **`Task.toJson()` and `Task.fromJson()`** on the model. Mind the two fields JSON can't take raw: the **priority enum** (store `priority.name`) and **`createdAt`** (store `toIso8601String()`, parse back with `DateTime.parse`).
3. The list is saved as **one JSON string** — `jsonEncode(tasks.map((t) => t.toJson()).toList())` — under a single key.
4. **Load once, in `initState`.** Save on **every** change (add / toggle / delete).
5. **Handle the first launch:** `getString` returns `null` when nothing's been saved yet → return an empty list, never crash.

## Rubric
- [ ] Add → close app → reopen → tasks (and their done-state) are still there
- [ ] Brand-new install (or clear the app's data) opens to a clean empty state, no crash
- [ ] `shared_preferences` is imported **only** inside `task_storage.dart`
- [ ] Saving happens on every mutation — ideally routed through one helper so you can't forget one
- [ ] `toJson`/`fromJson` round-trip is lossless: a saved task reloads with the same title, note, priority, done-state and date

## Hints (gated)
- **`toJson` is `fromJson` run backwards** — you wrote `fromJson` in the weather app. One builds a Map from fields; the other reads fields from a Map.
- **The enum:** `priority.name` gives `'high'`; to load, `Priority.values.firstWhere((p) => p.name == json['priority'], orElse: () => Priority.medium)`.
- **Don't save in `build`.** It runs constantly and you'll hammer the disk. Save where the data actually *changes* — a one-line `_change(update) { setState(update); TaskStorage.save(tasks); }` helper is the clean way.
- **The empty flash** on launch (list empty for a frame before the load finishes) is normal — a loading flag can hide it, but it's not required.

## Bonus
Add a **"Clear all" button** (AppBar action) that empties the list *and* the saved data. Notice it's just `_change(() => tasks.clear())` — because save is welded to change, clearing persists for free.

## Scope note
This saves to **this device only** — tasks won't appear on another device, and a reinstall wipes them. That's local storage's nature, and exactly the limit Module 16 (Firebase) lifts.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 90 minutes. Reference: `complete-projects/module-15/my-day-local/`.
