# Challenge — Quiz Engine v1 (parallel lists)

Build a true/false quiz that asks questions, checks answers, and reports a score.

**A design note, up front:** you'll store this quiz in TWO parallel lists — questions in one, answers in the other. This design has a hidden flaw. Build it anyway. Feeling the flaw yourself is the setup for Module 5, where we fix it properly.

## Requirements
1. A `List<String>` of at least 5 true/false questions, and a `List<bool>` of their correct answers (index 0 ↔ index 0, etc.).
2. Ask the user each question in turn and read their true/false answer from the keyboard (lesson 1.7's prompt-read-convert shape).
3. Loop through the quiz **once** with a single loop — adding question #6 must require ZERO changes to the loop.
4. For each question print: the question number (starting at 1, not 0!), the question, the given answer, and `CORRECT` / `WRONG`.
5. Track the score; end with `You scored 4/5 (80.0%)`.

## Expected output
```
Q1: The sky is blue. Your answer: true — CORRECT
Q2: Cats can fly. Your answer: true — WRONG
...
You scored 4/5 (80.0%)
```

## Hints
- One index, two lists: `questions[i]` and `correctAnswers[i]` — the user's answer arrives fresh from the keyboard each lap, so there's no third list to keep in step.
- Question number = `i + 1` — the zero-based ritual.
- Percentage: `score / questions.length * 100` — watch the int/double rules from Module 1.
- `RangeError`? One of your lists is shorter than the others. Interesting… keep that thought for Module 5.

## Bonus
After the loop, print a report of only the questions answered wrong — using `.where()` is tempting, but indexes make it awkward with parallel lists. If it feels clumsy, congratulations: you've found the flaw on your own.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 45 minutes.
