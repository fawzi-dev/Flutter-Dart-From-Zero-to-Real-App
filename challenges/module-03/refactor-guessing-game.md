# Challenge — Refactor the Guessing Game

Same game, same output — **better code.** This challenge is graded on *structure*, not behavior. Start from YOUR Module 2 solution.

## Requirements
1. `main()` contains **no game logic** — only setup and function calls. Someone reading `main()` should understand the program like a table of contents.
2. At minimum, extract:
   - a function that produces the next guess from `low` and `high` (**returns** a value)
   - a function that prints one round's result (takes the guess and outcome as **parameters**)
   - a function that prints the victory message — using **named parameters**: `printVictory(secret: 68, attempts: 4)`
3. At least one function uses arrow syntax `=>`.
4. Every function name says what it does: `nextGuess`, not `doStuff`.

## The rubric (self-check before watching the solution)
- [ ] Zero `if`s about the game in `main()`
- [ ] At least one function *returns* a value and at least one is `void` — and you can say which is which and why
- [ ] Named parameters used at least once
- [ ] Reading `main()` aloud sounds like a plan in English

## Hints
- Refactoring order that works: pick ONE small piece → extract it → **run and confirm identical output** → repeat. Never extract everything at once.
- If a function needs a variable, pass it as a parameter — don't be tempted to make things global.

## Bonus
Add a `playGame()` function that runs one full game and **returns** the number of attempts. Then make `main()` play 3 games and print the average attempts. Notice how cheap this feature was because the logic was already in functions — *that* is why functions exist.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 30 minutes. Behavior must stay identical — that's the discipline of refactoring.
