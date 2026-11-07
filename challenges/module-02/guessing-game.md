# Challenge — The Guessing Game (console)

The program picks a secret number, and **you** guess it. After every guess it tells you *too high* or *too low*, and counts how many tries you took. This is the real game — now that your programs can read input, they can play with you.

## The recipe you're given (paste as-is — explained properly later in the course)
```dart
import 'dart:math';
// inside main:
final secret = Random().nextInt(100) + 1;  // random number 1–100
```

## Requirements
1. Pick a random `secret` between 1 and 100.
2. Keep asking the user for a guess with a `while` loop, reading each one from the keyboard (`stdout.write` for the prompt, `stdin.readLineSync()` to read, `int.parse` to convert).
3. After each wrong guess, print `Too high!` or `Too low!`.
4. A guess outside 1–100 doesn't get a hint: print `That is outside 1-100. Try again.` and ask again.
5. Count the attempts. When the guess is right, print `Got it! The number was X. It took you Y guesses.` and stop.

## Expected output (yours will differ — it's random!)
```
--- Guess My Number ---
I am thinking of a number between 1 and 100.
Your guess: 50
Too low!
Your guess: 75
Too high!
Your guess: 62
Too low!
Your guess: 68
Got it! The number was 68. It took you 4 guesses.
```

## Hints (gated — 10 minutes before peeking)
- The loop condition is "while the guess is not the secret" — or use `while (true)` with a `break` when it's found.
- `continue` skips the rest of the loop body and goes straight back to asking. Handy for the out-of-range check.
- Testing is hard when you can't see the secret. Temporarily `print(secret)` at the top, play a round, then delete that line.
- It never says "too high", whatever you type? Check the comparison operators, one at a time.

## Bonus
Can you always win in 7 guesses or fewer? Try this strategy: always guess the middle of the range that's left (start at 50; too low → guess halfway between 51 and 100, and so on). Play a few rounds and count. Then think about *why* 7 is always enough for 1–100.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 45 minutes before the solution video.
