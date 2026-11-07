# Challenge — Refactor the Guessing Game

Same game, same output — **better code.** This challenge is graded on *structure*, not behavior. Start from YOUR Module 2 solution.

## Requirements
1. `main()` contains **no game logic** — only setup and function calls. Someone reading `main()` should understand the program like a table of contents.
2. At minimum, extract:
   - a function that asks for a number and **returns** it (e.g. `askInt('Your guess: ')`) — so the prompt-read-convert lines are written once, not every time you need a number
   - a function that answers a yes/no question about a guess and **returns** a `bool` (e.g. `isValid(guess)` for the 1–100 check)
   - a `void` function that prints the hint for one guess, taking what it needs as **parameters** (e.g. `reportGuess(guess, secret)`)
   - a function that plays one full round (e.g. `playRound(secret)`)
3. At least one function uses arrow syntax `=>`.
4. Every function name says what it does: `askInt`, not `doStuff`.

## The rubric (self-check before watching the solution)
- [ ] Zero `if`s about the game in `main()`
- [ ] The input lines (`stdout.write`, `stdin.readLineSync()`, `int.parse`) appear once, inside one function
- [ ] At least one function *returns* a value and at least one is `void` — and you can say which is which and why
- [ ] Reading `main()` aloud sounds like a plan in English

## Hints
- Refactoring order that works: pick ONE small piece → extract it → **run and confirm identical output** → repeat. Never extract everything at once.
- If a function needs a variable, pass it as a parameter — don't be tempted to make things global.

## Bonus
1. Make `playRound()` **return** the number of attempts. Then make `main()` play 3 rounds and print the average. Notice how cheap this feature was because the logic was already in functions — *that* is why functions exist.
2. Use **named parameters** once: a `printVictory(secret: 68, attempts: 4)` that prints the winning line.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 30 minutes. Behavior must stay identical — that's the discipline of refactoring.
