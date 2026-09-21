# Challenge — The Guessing Game (console)

The program picks a secret number, and **you** guess it. After every guess it tells you *too high* or *too low*, and counts how many tries you took. This is the real game — now that your programs can read input, they can play with you.

## The recipe you're given (paste as-is — explained properly in Module 4)
```dart
import 'dart:math';
// inside main:
final secret = Random().nextInt(100) + 1;  // random number 1–100
```

## Requirements
1. Pick a random `secret` between 1 and 100.
2. The program guesses numbers until it finds the secret, using a `while` loop.
3. After each wrong guess it prints the guess and `Too high!` or `Too low!`.
4. Count the attempts. When found, print `Got it! The number was X in Y guesses.`
5. **Simple strategy first:** keep two variables `low = 1` and `high = 100`. Always guess the middle: `(low + high) ~/ 2`. Too low? Then `low = guess + 1`. Too high? Then `high = guess - 1`.

## Expected output (yours will differ — it's random!)
```
I guess 50... Too low!
I guess 75... Too high!
I guess 62... Too low!
I guess 68... Got it! The number was 68 in 4 guesses.
```

## Hints (gated — 10 minutes before peeking)
- The loop condition is "while my guess is not the secret" — or use `while (true)` with a `break` when found.
- Trace it by hand FIRST with secret = 30: guesses go 50, 25, 37… write the trace on paper, THEN code it.
- Infinite loop? Check that `low` or `high` actually changes on every wrong guess.

## Bonus
Your strategy never needs more than 7 guesses for 1–100. Add a check: if attempts ever exceed 7, print `IMPOSSIBLE!` — if you ever see it, you have a bug (this is called an invariant, and real engineers ship checks exactly like it).


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 45 minutes before the solution video.
