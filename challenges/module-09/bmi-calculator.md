# Challenge — BMI Calculator

Build a BMI calculator from an empty app. One screen, two views, and every
value on it comes from state.

**Starter:** `starter-projects/module-09/bmi-calculator/`, an empty
`MaterialApp` with an empty `Scaffold`.

## The app

**Input view**
- A gender toggle: a `SegmentedButton` with Male and Female.
- A **Height** card: the height, big, in cm, and a `Slider` from 120 to 220.
- A **Weight** card: the weight, big, in kg, with round **−** and **+** buttons.
- A big **Calculate BMI** button.

**Result view** (after Calculate)
- The BMI, huge, to one decimal place.
- The category in a coloured pill: Underweight, Normal, Overweight or Obese.
- A scale of four coloured bands. The band you are in is taller, and says "You".
- A one-line message about the result.
- A **Re-calculate** button that goes back to the input view.

## Requirements

1. **Your own small widgets, used more than once.** At least an `InputCard`
   (used for Height and for Weight), a `StepperButton` (used for − and +), and a
   `PrimaryButton` (used for Calculate and Re-calculate). Each takes what it
   shows and what it does as constructor parameters.
2. **One `AppColors` class** names every colour once. Nothing else uses a raw
   `Color(0x…)`.
3. **The state:** `gender`, `height` (a `double`) and `weight` (an `int`) are
   fields of the State. Every change goes through `setState`.
4. **The BMI is a getter**, worked out from height and weight. Never stored.
5. **Two views, one bool.** A `bool showResult` picks which view the body
   shows.
6. **The logic is plain functions:** `categoryFor`, `colorFor` and
   `interpretationFor` take the BMI and return a `String` or a `Color`.

## The categories

| BMI | Category | Message (your own words are fine) |
|---|---|---|
| below 18.5 | Underweight | A little under the healthy range. |
| 18.5 to below 25 | Normal | Right in the healthy range. |
| 25 to below 30 | Overweight | A little over the healthy range. |
| 30 and above | Obese | Above the healthy range. |

## Checks

- 175 cm and 65 kg shows **21.2**, Normal.
- Exactly 18.5 is Normal. Exactly 25 is Overweight.
- Weight never goes below 1.
- Re-calculate keeps the values you set.

## Two hints

- **The slider is in centimetres.** The formula needs metres. If you get
  0.0021, that is the bug.
- **Build the input view first**, with fixed numbers, before any state. Then
  make it move.

## Bonus

A Reset button under Calculate that puts everything back to Male, 175 cm and
65 kg. One method, one `setState`.
