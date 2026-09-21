# Challenge — Quiz Engine v2 (classes)

Rebuild the quiz so the parallel-lists flaw is impossible. Same output as v1 — better bones.

## Requirements
1. A `Question` class: `final String text`, `final bool answer`, created with **named required parameters** — `Question(text: '...', answer: true)`.
2. A single `List<Question>` replaces the two parallel lists. A question and its answer now physically cannot desync.
3. A `Quiz` class that:
   - holds the `List<Question>` and a score
   - has a method `check(int index, bool userAnswer)` that prints the verdict line and updates the score
   - has a method `printResult()` for the final score line
4. `main()` only: builds the question list, creates the `Quiz`, asks the user each question, and reports the result. No scoring logic in `main` — the `Quiz` owns that.
5. Output identical to v1 — refactoring changes structure, never behavior.

## Rubric
- [ ] `Question` fields are `final` (a question never mutates after creation)
- [ ] Score lives INSIDE `Quiz` — nothing in `main` touches a score variable
- [ ] Adding question #6 = adding ONE `Question(...)` line, nothing else anywhere
- [ ] You can answer: "why is this impossible to desync when v1 wasn't?"

## Hints
- Start with just the `Question` class and ONE question printed. Run. Then the list. Run. Then `Quiz`. Small steps.
- Inside `Quiz`, a question's answer is `questions[index].answer` — the dot reaches into the object.
- `Quiz` needs a constructor that receives the question list.

## Bonus
Give `Question` a method `String reveal()` that returns e.g. `'The sky is blue. → true'`, and add a `Quiz.printAnswerKey()` that prints every question's reveal. Notice: the wrong-answers report that felt clumsy in v1's bonus is natural now. That's what a good design does — it makes the next feature easy.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 45 minutes.
