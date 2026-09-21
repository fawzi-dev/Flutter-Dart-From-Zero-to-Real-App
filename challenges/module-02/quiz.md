# Module 2 Quiz — Making Decisions & Repeating Work

Six questions. **Pass mark: 70% (5 of 6).** Commit to an answer before scrolling.

## Questions

1. **(concept)** What *type* of value does a comparison like `score >= 90` produce?

2. **(code reading)** Trace this by hand. What prints?
   ```dart
   for (var i = 1; i <= 3; i++) {
     print(i * i);
   }
   ```

3. **(concept)** You need to repeat something but you *don't know how many times* in advance (e.g. keep asking until the user guesses right). Which loop fits — `for` or `while` — and why?

4. **(code reading)** `raining` is `true`, `haveUmbrella` is `false`. What does this print?
   ```dart
   if (raining && !haveUmbrella) {
     print('Get wet');
   } else {
     print('Fine');
   }
   ```

5. **(debugging)** This loop prints forever. What's missing, and what's the emergency stop in the terminal?
   ```dart
   var water = 100;
   while (water > 0) {
     print(water);
   }
   ```

6. **(concept)** In a guessing game, what's the difference between `break` and `continue` inside the loop?

---

## Answers & explanations

1. **A `bool`** (`true` or `false`). Comparisons always produce a boolean — which is why you can store one in a `bool` variable. (Lesson 2.1.)
2. **`1`, `4`, `9`.** `i` runs 1, 2, 3; each line prints `i * i`. Hand-tracing a loop *before* running it is the habit from lesson 2.4.
3. **`while`.** A `for` loop is for a known number of repetitions; when the count is unknown, `while` (with a `break`) is the right tool. (Lesson 2.5.)
4. **`Get wet`.** `raining` is true AND `!haveUmbrella` is true (because `haveUmbrella` is false, `!` flips it), so the whole condition is true. (Lesson 2.3.)
5. **Nothing changes `water` inside the loop**, so `water > 0` is true forever. Press **Ctrl-C** in the terminal to stop it. Add something like `water = water - 30;`. (Lesson 2.5.)
6. **`break`** leaves the loop entirely (used when the guess is correct). **`continue`** skips the rest of *this* pass and goes back to the top (used to reject a bad guess and ask again). (Lesson 2.5.)
