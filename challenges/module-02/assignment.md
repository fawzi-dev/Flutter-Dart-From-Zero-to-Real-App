# Module 2 Assignment — Times-Table Printer

**Independent practice (Level 2).** Loops and conditions, a fresh little program.

## Brief
Ask the user for a number and print its full times table from ×1 to ×12 — then add one twist that needs a condition.

## Requirements
1. Ask for a number (`stdin` + `int.parse`).
2. A `for` loop from 1 to 12 printing lines like `7 x 3 = 21` (use interpolation).
3. **The twist:** on the rows where the *result* is a multiple of 10, add a marker — e.g. `7 x 10 = 70  <- round!`. (Hint: `%` gives you the remainder; a remainder of 0 means "divides evenly.")
4. No hardcoded 12 buried anywhere it can't be changed in one place.

## Rubric
- [ ] Correct 12-row table for any input
- [ ] The loop drives it — you didn't write 12 `print`s
- [ ] The condition marks exactly the rows whose result ends in 0
- [ ] Reads cleanly; you can explain every line

## Difficulty
**Level 2 — Independent.**

⏱️ Minimum 30 minutes. Extension (**Level 3**): let the user pick the table's length too.
