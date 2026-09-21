# Module 7 Quiz — Hello Flutter: Widgets

Eight questions. **Pass mark: 70% (6 of 8).**

## Questions

1. **(concept)** "Everything is a widget" is a slogan, not an explanation. In your own words, what does a widget actually *do*?
2. **(concept)** What is the job of `Scaffold`, and what is the job of `MaterialApp`?
3. **(code reading)** A `Container` shows a white box, not the red you wanted:
   ```dart
   Container(
     color: Colors.red,
     decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
   )
   ```
   Why does this throw, and what's the fix?
4. **(concept)** The rubric says your two info rows must come from *one* widget class used twice, not two copied blocks. Why does that matter beyond neatness?
5. **(concept)** What's the difference between a widget's `padding` and its `margin`?
6. **(process)** You add `assets/profile.png` and get "unable to load asset." Which file, and what's the usual culprit?
7. **(concept)** Every widget you wrote in this module was a `StatelessWidget`. What does that word actually promise, and what question tells you when you need a `StatefulWidget` instead?
8. **(code reading)** Your editor says **"Invalid constant value."** What did you do, and what is the fix?

---

## Answers & explanations

1. A widget **describes** a piece of UI; Flutter reads that description and paints it. Widgets are just constructor calls that nest — the widget tree. (Lesson 7.1.)
2. **`Scaffold`** gives one screen its structure (app bar, body, floating button). **`MaterialApp`** wraps the *whole* app (theme, navigation, the first screen). (Lessons 7.4-7.6 and 7.8.)
3. A `Container` **can't take both `color:` and `decoration:`** — put the colour *inside* the decoration: `BoxDecoration(color: Colors.red, borderRadius: ...)`. (Lesson 7.11 / the planned red screen in 7.18 Part 3.)
4. Because change happens in **one place**: edit the class once and every use updates. It's the same "one idea, one place" instinct as a function — and it's how real UIs stay maintainable. (Lessons 7.8 and 7.18 Part 4.)
5. **`padding`** is space *inside* the box (between its edge and its child); **`margin`** is space *outside* the box (between it and its neighbours). (Lesson 7.11.)
6. **`pubspec.yaml`** — the assets declaration, and the usual culprit is **indentation** (YAML is whitespace-sensitive) — or you only hot reloaded, and pubspec changes need a full stop-and-re-run. (Lesson 7.12.)
7. Stateless means **"I am drawn once, from the values I was given, and I never change my own mind."** The question is: *does anything on this screen change while the user is looking at it?* If yes — a counter, a toggle, a list that loads — you need Stateful, which is Module 9. (Lesson 7.7.)
8. You put `const` on something that isn't fully known in advance — usually a `Text` built from a variable or a constructor parameter. **Delete the `const`.** Rule of thumb: if the editor *suggests* const, add it; if it *complains*, remove it. (Lesson 7.10.)
