# Steps — BMI calculator

The solution, in five snapshots. Each file is `lib/main.dart` at the end of
one stretch of a solution video, and its header lists that stretch's beats in
order. Every step starts from the starter
(`starter-projects/module-09/bmi-calculator/`), where all the UI is already
built and nothing is wired.

| File | Video | Tasks | What it adds |
|---|---|---|---|
| `step_1_state.dart` | **9.10 P1** | 1, 2 | `BmiScreen` is Stateful; `gender`, `height`, `weight` are fields; the segmented button and the slider are wired. |
| `step_2_steppers.dart` | **9.10 P1** | 3 | `addWeight` and `removeWeight`, one `if` each. Weight never goes below 1. |
| `step_3_bmi.dart` | **9.10 P1** end | 4 | The `bmi` getter, in metres. Calculate prints it: 21.2. |
| `step_4_result.dart` | **9.10 P2** | 5 | `showResult` swaps the input view and `ResultView`. |
| `step_5_categories.dart` | **9.10 P2** end | 6 | The real `categoryFor`, `colorFor` and `interpretationFor`. Same as `lib/main.dart`. |

Run any one from this folder:

```
flutter run -t steps/step_3_bmi.dart
```

## The mistakes made on purpose

| Step | The mistake | What you see |
|---|---|---|
| 3 | `weight / (height * height)`, in centimetres | Calculate prints `0.0021`. It runs, nothing crashes, and it is wrong. |
| 2 | `removeWeight` without its `if` | Minus goes to 0, then negative. |

## Nothing new

Every widget and every piece of Dart here was taught before the exercise. The
pre-built UI only uses Modules 7–9; the six tasks only use Module 9's state.
`flutter test` checks the boundaries, the stepper floor, 21.2, and the
segmented button.
