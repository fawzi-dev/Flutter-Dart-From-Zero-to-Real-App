# Challenge — BMI Calculator

Your first screen built the way real screens are built: out of a handful of small, reusable widgets **you** make yourself. Same state loop as Dicee — change data, `setState`, screen matches — but now the UI is a *system* of named pieces, not a one-off layout.

**Starter:** `starter-projects/module-09/bmi-calculator/` — empty Scaffold only.

## The product
One screen with **two views**, swapped by a single `bool`:

**Input view**
- A gender toggle (`SegmentedButton`: Male / Female)
- A **height slider** (≈120–220 cm) with the current value shown large above it
- A **weight stepper**: a big number with round `−` and `+` buttons either side
- A big **Calculate BMI** button

**Result view** (shown after Calculate)
- The BMI, huge, to one decimal place
- A category pill — `Underweight` / `Normal` / `Overweight` / `Obese` (boundaries **18.5 / 25 / 30**) — tinted with that category's color
- The signature piece: a **health-scale bar** (a colored gradient) with a **marker showing where this BMI lands**
- A one-line, friendly interpretation
- A **Re-calculate** button that swaps back to the input view

## Requirements
1. **Build it from your own reusable widget classes.** At minimum: an `InputCard` (the white rounded card, used for both height and weight), a `StepperButton` (the round button, used for **both** `−` and `+`), and a `PrimaryButton` (used for **both** Calculate and Re-calculate). Each takes what it needs as constructor parameters — and a callback where it does something. This is Module 7's `InfoCard`, grown up.
2. **One color source of truth.** A single `AppColors` class names every color once; nothing in the widget tree uses a raw `Color(0x…)` or scattered `Colors.blue`. Change the accent in one place → the whole app re-tints.
3. **Logic lives in plain Dart functions** — `String categoryFor(double bmi)`, `Color colorFor(double bmi)` — no widgets, no `setState` inside them. Boundaries chosen deliberately (what does *exactly* 25.0 say?).
4. **Two views, one bool.** A `bool showResult` decides which view the body shows; Calculate sets it `true`, Re-calculate sets it `false` — all inside `setState`. No second file, no `Navigator` yet (that's Module 10 — this bool is a deliberate stand-in for it).
5. **The marker's position is computed from the BMI.** Map the number onto the bar (`Stack` + `Alignment`). This is the one bit of "turn a value into a position" the module teaches.

## Rubric
- [ ] The `−` and `+` buttons are the **same `StepperButton` class used twice** — zero copy-pasted widget blocks
- [ ] Every color comes from `AppColors`; there are no stray color literals in the tree
- [ ] `categoryFor` is a **pure function** — you could paste it into DartPad and test it with no Flutter at all
- [ ] The marker lands in the right place: a BMI of ~22 sits in the green band, ~32 sits in the red
- [ ] Calculate → result view, Re-calculate → back — driven by **one bool, inside `setState`**

## Hints (gated)
- **Build order:** get the input view working with plain widgets first (gender, slider, steppers all visibly changing state) → wire Calculate + the `showResult` swap → build the result view → *then* pull the repeated pieces out into widget classes → *then* style everything through `AppColors`. Run at every step.
- **It's all one pattern.** `SegmentedButton` has `onSelectionChanged`, `Slider` has `onChanged`, your stepper calls a callback you pass it — every one of them just `setState`s a field. Learn one, you know all (lesson 9.6).
- **Value → position:** the bar covers a BMI range (say 15–40). Turn the BMI into a fraction from 0 to 1 (and `.clamp` it), then into `Alignment`'s −1 (far left) to 1 (far right). Feed that to an `Align` around the marker.
- **No text fields here — on purpose.** You already hardened free-text input (`tryParse`, friendly errors, the hostile-user pass) in lesson 9.5's temperature converter. This challenge does the *opposite*: inputs so constrained the user simply can't be wrong. Making bad input **impossible** is itself a design skill — a slider can't return `"abc"`.

## Bonus
Swap the marker's `Align` for `AnimatedAlign` with a ~400 ms duration, so it *glides* to its spot on each Calculate. One-word change, and it's your first taste of implicit animation — the thing Module 10 leans into.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 90 minutes. Reference: `complete-projects/module-09/bmi-calculator/`.
