# Steps — Dicee, rolling

Lesson 9.4 in three videos. Each file is `lib/main.dart` as it stood at the
end of one video, and its header says what that video added. The first
one starts from the Module 8 Dicee (`../../module-08/dicee-v1-static/`).

| File | Video | What it adds |
|---|---|---|
| `step_1_rolls.dart` | **9.4, 1 of 3** | `StatefulWidget`, `leftDie` and `rightDie` in the State, `rollDice()` with `Random` inside `setState`, and ROLL as a real `ElevatedButton.icon`. |
| `step_2_tap_the_die.dart` | **9.4, 2 of 3** | `DieFace` takes a `VoidCallback onTap` and wraps itself in a `GestureDetector`. The page hands it `rollDice`. |
| `step_3_count_and_doubles.dart` | **9.4, 3 of 3** | `rollCount`, a subtitle that reads it with `? :`, and DOUBLES! with a collection `if`. Identical to `lib/main.dart` below the header. |

## The diffs worth doing

**Module 8 → `step_1_rolls.dart`** is the counter's fix, in a real app: the
dice move out of the typed `3` and `5` and into the State, and the layout does
not change at all.

**`step_1_rolls.dart` → `step_2_tap_the_die.dart`** is one parameter and one
wrapper: a field that holds a function instead of a value.

**`step_2_tap_the_die.dart` → `step_3_count_and_doubles.dart`** is one more
field and two places that read it.
