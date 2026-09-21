# Module 3 Assignment — Refactor Your Unit Converter

**Independent practice (Level 2).** Take the Module 1 assignment (the km converter) and give it the Module 3 treatment.

## Brief
Rewrite your unit converter so `main` reads like a table of contents and every job lives in a named function.

## Requirements
1. A pure **answerer** for each conversion: `double kmToMiles(double km)`, `double kmToMetres(double km)` — they `return`, they don't print.
2. A **doer** that prints the report: `void printReport({required double km})` (named + required parameters).
3. An `askDouble(String prompt)` helper for input — written once, used instead of repeating the prompt/read/parse lines.
4. `main` has **no arithmetic and no prompts of its own** — it just wires the functions together.

## Rubric
- [ ] `main` is only function calls — a readable summary
- [ ] At least one clear answerer (returns) and one doer (void), and you can name which is which
- [ ] The repeated input code became one `askDouble` function
- [ ] Same output as the Module 1 version — behaviour unchanged, structure transformed

## Difficulty
**Level 2 — Independent.**

⏱️ Minimum 40 minutes.
