# FOUNDATION CAPSTONE — "My Day"

A personal task & journal app. **This is the course.** Everything before was training; this is the match. No build-along — a spec, a rubric, your plan, your code.

> ⚠️ Watch videos 14.1–14.3 (planning, debugging toolkit, polish), then build. **Do not open solution videos 14.4–14.7 until you've invested at least 6 hours.** The version of you on the other side of those hours is the one who's ready for intermediate Flutter.

**Starter:** `starter-projects/module-14/my-day/` — empty Scaffold + app-icon assets. That's all you get. That's the point.

## Before you code (required, not optional)
1. Sketch every screen on paper.
2. Write the `Task` model on paper: what fields? what types?
3. List your files: which screens, which widgets, which services?
4. `git init`, and commit after every working feature. Reuse the same Module 7 Git survival routine here: `status`, `diff`, honest checkpoints, clear commit messages. Your commit history is part of the rubric.

## The spec

### Home screen (a daily dashboard)
- A **"Today" header**: the word "Today", the date written out (e.g. `Wednesday, 23 July` — formatted yourself, no date package), and a **progress ring** on the right showing done-of-total (a `CircularProgressIndicator` with a `value`, with `2/5` centred inside it via a `Stack`)
- A **quote-of-the-day hero card** below the header: fetched from `https://dummyjson.com/quotes/random`, styled as a gradient card, with a loading spinner, an error state ("Couldn't load today's quote — tap to retry", tappable), and a data state (quote + author). It must never be blank and never crash the app, even offline
- Tasks in a `ListView.builder`, each a card with a **colored priority stripe** (low=green, medium=orange, high=red), a check control to complete (completed = struck-through, sorted to bottom)
- Swipe-to-delete with confirmation dialog
- Empty state: friendly message + icon when no tasks
- `FloatingActionButton.extended` → add screen

> Everything in that dashboard is a piece you already own: `Stack` (M8), `CircularProgressIndicator` and gradients (M11), a shared `app_colors.dart` (M10), and a date built from plain Dart lists + `DateTime` (Part A). No new concepts — new *assembly*.

### Add-task screen
- Title field (required — friendly inline error if empty), optional note field (multiline), priority selector (dropdown or three choice chips)
- Save returns the task via `Navigator.pop`; Cancel/back returns nothing (home must handle both)

### Detail screen
- Tap a task → detail screen receiving the **Task object via constructor**
- Shows title, note, priority, created date; buttons: complete/uncomplete, delete (with confirm, then back to home)

### Polish (this is a requirement, not a garnish)
- One consistent `ThemeData` — colors defined ONCE, no random hex values scattered in widgets
- App name is "My Day" on the launcher; custom app icon (flutter_launcher_icons + provided asset)
- No debug banner; runs on a real device
- Screens respect `SafeArea`, keep sensible edge padding, and survive rotate + keyboard-open checks

## The model (minimum)
`Task`: title, note, priority (enum `Priority { low, medium, high }`), `isDone`, `createdAt` (`DateTime.now()` at creation).

## Rubric — the skills checklist made concrete
**Structure**
- [ ] `models/ · screens/ · widgets/ · services/` — quote fetching in a service, no `http` import in screens
- [ ] All state lives in the home screen; other screens receive data via constructors and return via `pop`
- [ ] At least 3 extracted reusable widgets (task tile, quote card, dashboard header) + a shared `app_colors.dart`

**Behavior**
- [ ] Add → appears; complete → strikes + sinks; delete → confirm → gone; empty state returns
- [ ] Both add-screen exits handled (save AND back-without-saving)
- [ ] Quote card: all three async states reachable and correct (test with airplane mode)
- [ ] Zero crashes in a 5-minute "try to break it" session (empty inputs, spam taps, rotate, offline)
- [ ] Finish checklist passed: launcher name/icon correct, no debug banner, add screen survives keyboard-open, long content does not break the layout

**Process**
- [ ] Paper plan exists (photograph it)
- [ ] Git history shows feature-by-feature commits, not one "final" blob
- [ ] You fixed at least one real bug and can narrate HOW you found it (this is video 14.7's debrief exercise — intermediate readiness criterion #3)

## Scope protection (read twice)
No login. No cloud. No categories, tags, reminders, dark-mode toggle, or animations. Every one of those is a great idea — for later. **Cutting scope is a professional skill, and the capstone grades it.** Finish THIS spec, polished, instead of half of a bigger one. (Login and cloud sync ARE coming — that's the whole bonus module.)

## Extension menu (Level 3 — *only* after the spec is finished and polished)
Finished the whole spec and it feels solid? Pick **one** extension and add it cleanly — this is where you practise adding a feature to a working app without breaking it. Do **not** start these before the base app is done.
- **Favorites / pinning** — a star that floats a task to the top.
- **Sort options** — by priority, by created date, by done/not-done.
- **"Today" filter** — show only today's tasks vs everything.
- **A stats screen** — how many done this week, longest streak (all derived from the list).
- **Categories** — a second enum, shown as a coloured chip (mind the scope!).
- **Recently completed** — a collapsible "done" section instead of just sinking them.

Each should cost a *small*, contained change. If one balloons, that's the scope lesson again — shelve it for "version two."

## Gated hints
1. *Blank-file paralysis?* You built this app in pieces already: home list = **your shopping list** (Module 10), quote card = **the Quote of the Day screen from 11.5** — same API, same three states — hardened by whatever you learned building Weather Now. Open your own Module 10–11 code. Reusing your past work is not cheating — it's the entire point of having done it.
2. *Priority enum?* `enum Priority { low, medium, high }` — a field like any other; map it to a color with one function.
3. *Sorting completed to bottom?* Same comparator trick as the shopping-list bonus.


**Difficulty:** Level 3 — Extension. You design the solution from a spec — no steps, minimal hints. This is the real test.

⏱️ Expect 8–15 hours across several days. Commit as you go. See you at the demo — record a 60-second screen capture of your app for the community when you're done. Optional appendix: if you want a local Android release build after the capstone, see lesson 14.8. Reference: `complete-projects/module-14/my-day/`.
