# Bonus Challenge — Mad Libs Generator

A quick, silly workout for input and interpolation.

## Requirements
1. **Ask** the person at the keyboard for at least 4 words: a person's name, a place, an animal, and a number. Read each one with `stdin.readLineSync()`, and turn the number into an `int` with `int.parse`.
2. Print a short ridiculous story (2–3 sentences) using **all** of them via interpolation.
3. Use `${...}` at least once to do math *inside* a sentence (e.g. double the number).
4. Include at least one apostrophe in the story — handled correctly (escape it, or use double quotes).

## Example output
```
A name: Fawzi
A place: the Louvre
An animal: hamsters
A number: 7

One day, Fawzi walked into the Louvre carrying 7 hamsters.
"That's nothing," said the guard, "yesterday someone brought 14."
```

Run it with `dart run` in a terminal: DartPad can't read keyboard input.

No solution file for this one — if it runs and makes you laugh, it passes.

**Difficulty:** Level 1 — Guided. The steps are spelled out; follow along and fix/build as you go.
