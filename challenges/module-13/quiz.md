# Module 13 Quiz — Responsive Layout & Dark Mode

Seven questions. **Pass mark: 70% (5 of 7).**

## Questions

1. **(concept)** `MediaQuery.sizeOf(context)` and `LayoutBuilder`'s `constraints` both tell you about size. What's the difference, and which do you use to reflow a specific widget?
2. **(concept)** What is a "breakpoint," and what's the common value that separates phones from tablet-ish layouts?
3. **(code reading)** Your wide layout uses `crossAxisCount: 2`. It looks fine on a tablet but has two enormous cards on a desktop window. What's the fix, in one line of reasoning?
4. **(concept)** What does `ColorScheme.fromSeed(seedColor: ...)` give you from a single color, and why does that matter for dark mode?
5. **(concept)** Why read `Theme.of(context).colorScheme.surface` instead of writing `Colors.white`? What does the color role `onSurface` guarantee?
6. **(concept)** Name the three `MaterialApp` properties that make dark mode work, and what `ThemeMode.system` does.
7. **(debugging)** You add an app-bar button to toggle dark mode, but tapping it does nothing. The `themeMode` never changes. Where must the `ThemeMode` state live, and why?

---

## Answers & explanations

1. `MediaQuery.sizeOf` is always the **whole screen**; `LayoutBuilder`'s `constraints.maxWidth` is the space **this particular widget** has to fill. To reflow a widget, use **`LayoutBuilder`** — a widget in a column or split view doesn't have the whole screen's width. (Lessons 13.2–13.3.)
2. A **breakpoint** is a width threshold where the layout switches. **600** logical pixels is the classic phone-vs-tablet line — below it phones, above it big landscape phones and tablets. (Lesson 13.3.)
3. **Derive** the column count from the width instead of fixing it: `(maxWidth / 260).floor().clamp(2, 4)` — aim for ~260px cards, floor to a whole number, clamp to a sane range. A value mapped from a value. (Lesson 13.3.)
4. It generates an **entire coordinated palette** — primary, surfaces, and the correct `on` colors — from one seed. That matters because you get a matching **dark** palette from the *same seed* just by adding `brightness: Brightness.dark`. (Lessons 13.4–13.5.)
5. Because a literal can't adapt to dark mode, but a **role** can — `surface` is near-white in light and near-dark in dark. `onSurface` guarantees a color with enough **contrast** to be readable *on* a surface, so text stays legible in both themes. (Lesson 13.4.)
6. **`theme`** (light), **`darkTheme`** (dark), and **`themeMode`** (which is active). `ThemeMode.system` **follows the phone's own light/dark setting** and updates automatically when the user changes it. (Lesson 13.5.)
7. In the widget that **builds `MaterialApp`** (a stateful root), because `themeMode` is a property of `MaterialApp` — the state must live where it's read. The screen gets a **callback** to change it, not the state itself. (Lesson 13.5.)
