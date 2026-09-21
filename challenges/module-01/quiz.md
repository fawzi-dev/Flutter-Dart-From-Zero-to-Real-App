# Module 1 Quiz — Dart Basics

Six questions. **Pass mark: 70% (5 of 6).** Answer each before you scroll — the answer key and explanations are at the bottom.

## Questions

1. **(concept)** Why does Dart make you declare a type (or `var`/`final`) for every variable?
   - a) To make programs longer
   - b) So it can catch type mistakes *before* the program runs
   - c) Because the CPU needs it
   - d) It doesn't — types are optional decoration

2. **(code reading)** What does this print?
   ```dart
   print(5 / 2);
   print(5 ~/ 2);
   ```

3. **(concept)** You have a value that is set once and never changes. Should it be `var` or `final`, and why in one sentence?

4. **(code reading)** What ends up in `message`?
   ```dart
   final name = 'Sam';
   final age = 20;
   final message = '$name is ${age + 1} next year';
   ```

5. **(debugging)** A user runs your tip calculator and types `twelve` at the "Bill amount:" prompt. The program crashes with `FormatException`. Which line is responsible, and what tool (coming in Module 5) fixes it?
   ```dart
   final bill = double.parse(stdin.readLineSync() ?? '');
   ```

6. **(concept)** `bill * tipPercent ~/ 100` runs with no error but gives a slightly wrong tip on a round bill. Why? What should the operator be?

---

## Answers & explanations

1. **b.** Types are a safety net checked at compile time. `int x = 9.99` fails *before* you run it, so the mistake never reaches a user. (Lesson 1.2.)
2. **`2.5`** then **`2`.** `/` always gives a `double`; `~/` is integer division, which throws the decimal away. The `5 / 2 = 2.5` surprise from lesson 1.3.
3. **`final`** — because it's set once and never changes, and `final` makes that promise explicit (one less moving part to track). `var` would work but says "this might change," which would be misleading. (Lesson 1.5.)
4. **`Sam is 21 next year`.** `$name` inserts the value; `${age + 1}` evaluates the expression first. (Lesson 1.4.)
5. **The `double.parse` line.** `parse` has no plan for text that isn't a number, so it throws. `double.tryParse` (Module 5) returns `null` instead of crashing, so you can handle bad input. (Lesson 1.7.)
6. **`~/` throws away the decimals** — `~/` is integer division, and money needs the fractional part. Use `/`. A silent wrong-answer bug: always sanity-check output against a rough estimate. (Lesson 1.3.)
