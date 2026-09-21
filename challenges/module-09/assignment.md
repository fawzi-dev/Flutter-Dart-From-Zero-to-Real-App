# Module 9 Assignment — Tip Calculator (interactive app)

**Independent practice (Level 2).** You built a *console* tip calculator in Module 1 — now build the **app**.

## Brief
One screen: a bill `TextField`, a tip-percent control (slider or segmented buttons), a party-size stepper, and a live result area showing tip, total and per-person.

## Requirements
1. Controller for the bill field, **disposed** in `dispose()`.
2. `double.tryParse` for the bill — an empty or non-numeric entry shows a **friendly inline message**, never a red screen.
3. The result recomputes on every change, inside `setState`.
4. At least one reusable widget you made yourself (e.g. a `ResultRow`).

## Rubric
- [ ] Empty and `abc` inputs both produce friendly messages
- [ ] Controller disposed; no analyzer warning
- [ ] Result updates live as any input changes
- [ ] The BMI calculator's habits (constrained inputs, extracted widgets) show up here

## Difficulty
**Level 2 — Independent.** Extension (**Level 3**): add a kg/lbs-style unit toggle, or round-up-the-tip button.

⏱️ Minimum 60 minutes.
