# Module 6 Quiz — Dart Review (Part A Checkpoint)

A cumulative check over everything in Part A, right before the console capstone. **Pass mark: 70% (7 of 10).** If you miss several, revisit those lessons *before* the capstone — this is the gate.

## Questions

1. **(types)** Which type holds `19.99`, and which holds `true`?
2. **(math)** What is `17 % 5`, and what is `17 ~/ 5`?
3. **(strings)** Write a line that prints `Total: $42.50` given `final total = 42.5;` (2 decimals, literal dollar sign).
4. **(control flow)** `for` versus `while` — give a one-line rule for choosing between them.
5. **(functions)** What's the difference between a parameter and a return value?
6. **(collections)** When would you choose a `Map` over a `List`?
7. **(classes)** Why is a model class safer than a bunch of parallel lists?
8. **(null safety)** What does `int? highest(List<int> scores)` returning `null` let you express honestly?
9. **(reading errors)** You see `RangeError (index): Invalid value: ... 5`. In one sentence, what happened?
10. **(process)** Before writing a single line of the capstone, what should you do first — and why?

---

## Answers & explanations

1. `double` holds `19.99`; `bool` holds `true`. (M1)
2. `17 % 5` is **`2`** (remainder); `17 ~/ 5` is **`3`** (integer division). (M1)
3. `print('Total: \$${total.toStringAsFixed(2)}');` — `\$` prints a literal `$`, `${...}` formats the value. (M1)
4. Known number of repetitions → `for`; unknown, "keep going until…" → `while`. (M2)
5. A **parameter** is information going *into* a function; a **return value** is the answer coming *out*. (M3)
6. When you look things up **by key/name** rather than by position. (M4)
7. Each object keeps its own data together, so fields **can't desync** the way separate lists can. (M4–M5)
8. That "there may be no answer" (e.g. no highest score in an empty list) — a possibility every caller is then forced to handle. (M5)
9. You asked a list for an index it doesn't have (only 0–4 exist for a 5-item list). (M4)
10. **Plan on paper** — what things exist (classes) and what jobs (functions) — because typing before planning is how you get one 200-line `main`. (Lesson 6.1.)
