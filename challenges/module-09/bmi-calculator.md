# Exercise — BMI Calculator

Module 9 is about state, so this exercise is about state. **The whole UI is
already built for you**: the colours, the cards, the buttons, the scale and
both views. Every value on it is typed in, and nothing moves. Your job is to
give the screen a memory.

**Starter:** `starter-projects/module-09/bmi-calculator/`. Run it first: tap
Female, drag the slider, press Calculate. Nothing happens. By the end,
everything will.

## What's already there

| Piece | What it does | You give it |
|---|---|---|
| `AppColors` | every colour, named once | nothing |
| `enum Gender` | `male`, `female` | nothing |
| `InputCard` | the white rounded card with a label | a label and a child |
| `BigNumber` | a big number with its unit: 175 cm | the text to show |
| `StepperButton` | the round − / + button | an icon and an `onPressed` |
| `PrimaryButton` | the big full-width button | a label and an `onPressed` |
| `ResultView` | the whole result screen | the `bmi`, and an `onRecalculate` |
| `CategoryPill`, `BmiScale` | the coloured pill and the four-band scale | the category |

You do not need to change any of these. You only connect them to state.

## Your six tasks

Do them in order. Each one has a check, so you know when it's right.

| # | Task | You practise | Check |
|---|---|---|---|
| 1 | Make `BmiScreen` a `StatefulWidget`. Add `gender`, `height` (a `double`, 175) and `weight` (an `int`, 65) to the State. | state fields (9.3) | it still runs, and looks the same |
| 2 | Wire the segmented button and the slider: each stores its value with `setState`, and the big height number reads `height`. | segmented button and slider (9.8) | tap Female; drag the slider and the number follows |
| 3 | Make the weight steppers work, with two methods like `addTicket` and `removeTicket`. Weight never goes below 1. | `setState` and an `if` (9.5) | tap − down to 1; it stops |
| 4 | Add a `bmi` getter: weight ÷ (height in metres)². For now, make Calculate print it. | worked out, not stored (9.4, 9.5) | 175 cm and 65 kg prints **21.2** |
| 5 | Add a `showResult` bool. Calculate shows `ResultView`; Re-calculate comes back. | a bool in the State, and `? :` | Calculate shows 21.2; Re-calculate keeps your values |
| 6 | Give `categoryFor`, `colorFor` and `interpretationFor` their real `if`s. | plain `if`s | 18.5 is Normal; 25 is Overweight |

**The categories:**

| BMI | Category | Colour | Message (your own words are fine) |
|---|---|---|---|
| below 18.5 | Underweight | `AppColors.under` | A little under the healthy range. |
| 18.5 to below 25 | Normal | `AppColors.normal` | Right in the healthy range. |
| 25 to below 30 | Overweight | `AppColors.over` | A little over the healthy range. |
| 30 and above | Obese | `AppColors.high` | Above the healthy range. |

## Two hints

- **The slider is in centimetres.** The formula needs metres. If you get
  0.0021, that is the bug.
- **Know one right answer before you trust any:** 175 cm and 65 kg is 21.2.

## Bonus

Add a Reset button under Calculate that puts everything back to Male, 175 cm
and 65 kg, but **asks first**, with the dialog from 9.7 P2.

## When you're done

Every value on the screen should come from the State, and every control should
change it. Then watch the solution videos, 9.10 P1 and P2, and compare.
