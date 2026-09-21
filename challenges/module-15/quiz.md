# Module 15 Quiz — Local Storage

Six questions. **Pass mark: 70% (5 of 6).**

## Questions

1. **(concept)** Why does a task list held in a `List<Task>` disappear when the app closes?
2. **(concept)** `shared_preferences` only stores strings, numbers and bools. So how do you save a whole `List<Task>`?
3. **(code reading)** In `Task.toJson`, why can't `priority` (an enum) and `createdAt` (a DateTime) go in as-is, and what do you store instead?
4. **(concept)** When does the app *load* its saved tasks, and why there?
5. **(debugging)** On a brand-new install the app crashes on first launch while loading. What case did the code forget?
6. **(concept)** Why route every change through one `_change()` helper that saves, instead of calling save after each `setState`?

---

## Answers & explanations

1. Because a `List` lives in **memory** (RAM), which the OS reclaims when the app closes. Nothing was written to **disk**. (Lesson 15.1.)
2. Turn the whole list into **one JSON string** with `jsonEncode(tasks.map((t) => t.toJson()))`, save that string, and decode it back on load. (Lesson 15.3.)
3. JSON only understands strings/numbers/bools/lists/maps. Store `priority.name` (the string `'high'`) and `createdAt.toIso8601String()` (a date string); convert them back in `fromJson`. (Lesson 15.3.)
4. **Once, in `initState`** — the app reads its saved data when the screen is born, not on every build. (Lesson 15.4.)
5. The **first launch**: nothing is saved yet, so `getString` returns `null`. Handle it (return an empty list) or it crashes for every new user. (Lesson 15.4.)
6. So you **can't forget to save** after a change — the mutation and the save are welded into one method. (Lesson 15.6.)
