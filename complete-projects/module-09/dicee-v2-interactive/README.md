# Dicee v2 (interactive) — Module 9

The Module 8 Dicee, brought to life in lesson 9.4: tap ROLL, or a die, and
the dice roll.

```
flutter pub get
flutter run
```

Lesson 9.4 is recorded in three videos, one snapshot each in `steps/`:

| Video | Snapshot | Adds |
|---|---|---|
| 1 of 3 | `steps/step_1_rolls.dart` | `StatefulWidget`, the dice in the State, `setState`, a real ROLL button |
| 2 of 3 | `steps/step_2_tap_the_die.dart` | `VoidCallback`: the die itself is tappable |
| 3 of 3 | `steps/step_3_count_and_doubles.dart` | the roll counter and DOUBLES! |

Diff `lib/main.dart` against `../../module-08/dicee-v1-static/`. The layout
is untouched; the diff is a `StatefulWidget`, three state fields, one
`setState` and the callbacks.
