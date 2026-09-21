# Module 8 Quiz — Layouts

Six questions. **Pass mark: 70% (5 of 6).**

## Questions

1. **(concept)** For a `Row`, which direction is the **main axis** and which is the **cross axis**?
2. **(concept)** Complete the layout mantra: "Constraints go ____, sizes go ____, the parent sets ____."
3. **(code reading)** Two boxes in a `Row`, each `width: 180`. On a narrow phone you get yellow-and-black stripes. What are the *three* ways to fix it, and which is usually right?
4. **(debugging)** You put an `Expanded` inside a `Container` and get "Incorrect use of ParentDataWidget." Why, in terms of the mantra?
5. **(concept)** What does `Expanded(flex: 2)` next to `Expanded(flex: 1)` produce?
6. **(concept)** Which tool tells you the exact constraint a widget was given versus the size it chose?

---

## Answers & explanations

1. **Main axis = horizontal** (the direction a Row lays children out); **cross axis = vertical**. For a Column it's the opposite. (Lesson 8.1.)
2. "Constraints go **down**, sizes go **up**, the parent sets **position**." (Lesson 8.3.)
3. **Expanded** (share the space), **smaller** fixed sizes, or **scroll** it. `Expanded` is usually right — describe *intent* ("share"), not pixels. (Lesson 8.4.)
4. `Expanded` is an instruction written in **Row/Column language** about how to divide a parent's space; a `Container` doesn't speak it. Its direct parent must be a Row/Column/Flex. (Lessons 8.3–8.4.)
5. The first takes **two-thirds**, the second **one-third** — flex numbers are shares of a pie, not pixels. (Lesson 8.3.)
6. The **DevTools Layout Explorer** — it draws the constraint-versus-chosen-size relationship. (Lesson 8.6.)
