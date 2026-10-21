# The playground, stage by stage

Each file is `lib/main.dart` exactly as it stood at the **end** of one video.
Drop one into `lib/` and run it to see where the lesson finished, or diff two
to see what the lesson actually changed. Every file is self-contained and
imports nothing but Material.

## How the file grows

Each video adds **one screen** below the last one and points `home:` at it.
The older screens stay in the file, untouched, so the file is always what you
would have if you typed along.

| Screen | Added in | What it is for |
|---|---|---|
| `ButtonScreen` | 9.1 P1 | One `ElevatedButton`. What it shows, what it does. |
| `CounterScreen` | 9.2 | A number and a button. Broken in 9.2, alive in 9.3 P1. |
| `DoubleScreen` | 9.8 P1 | "Double my number": input that cannot be trusted. |
| `HeightScreen` | 9.8 P2 | A height card with a `Slider`: a number with walls. Gets a `SegmentedButton` in 9.8 P3. |
| `ConstScreen` | 9.9 P1 | A counter and the same `LoudLabel` twice, one `const`: watch which one is built again. In 9.9 P2 its labels move into `Labels`, as `static const`. |

## The steps

| File | Lesson | The concept | What changes |
|---|---|---|---|
| `step_1_first_button.dart` | 9.1 P1 | `ElevatedButton`, `child:` and `onPressed:`, `() {}`, `debugPrint`, `onPressed: null` | The `SizedBox` in the starter becomes a button that prints when tapped |
| `step_2_named_function.dart` | 9.1 P2 | Passing a function vs calling it | The anonymous function becomes `handleTap`, passed with no parentheses |
| `step_3_broken_counter.dart` | 9.2 | Why the screen won't change | **Deliberately broken.** `CounterScreen` with `count` inside `build`: the terminal counts, the screen stays at 0 |
| `step_4_setstate_counter.dart` | 9.3 P1 | `StatefulWidget`, `State`, `setState` | `CounterScreen` converted, `count` moved into the State class, the change wrapped in `setState` |
| `step_5_parse.dart` | 9.8 P1 | `double.parse` vs `double.tryParse`, `errorText`, `keyboardType` | `DoubleScreen` recaps the controller from the ticket; bad input gets a red line, not an exception |
| `step_6_slider.dart` | 9.8 P2 | `Slider`: `min`, `max`, `divisions`, a `double` field, `round()` | `HeightScreen`: one card, the height, and a slider held to 120–220 cm |
| `step_7_segmented.dart` | 9.8 P3 | `SegmentedButton`, an `enum`, a `Set` | A Male / Female toggle above the height card |
| `step_8_const.dart` | 9.9 P1 | `const` widgets are not built again | `ConstScreen`: tap Add one; only the label without `const` prints `built:` again |
| `step_9_static.dart` | 9.9 P2 | `static`, and why `static const` | `Labels` holds both names as `static const`; every other way of writing them fails |

`lib/main.dart` is the same file as `step_9`, so the project always runs.

The ticket card runs from 9.5 P1 to 9.7. Dicee is 9.4. The BMI
challenge is 9.10 and its solution is 9.11.

## How each video runs

The beats for every video are in the header comment of its own step file,
numbered, in recording order. Open the file, read the header, record down the
list.

The shape is the same every time: **Explain the idea on slides → open this
project → add one screen or change one line → run it → say what changed.**

## The mistakes are the lessons

Several videos make a mistake on purpose. None of the broken versions
is saved as a file except step 3, because each one is one line away from the
step it belongs to:

| Video | The mistake, made on camera | What you see |
|---|---|---|
| 9.1 P1 | Leave out `onPressed` | `The named parameter 'onPressed' is required, but there's no corresponding argument.` |
| 9.1 P2 | `onPressed: handleTap()` | `This expression has a type of 'void' so its value can't be used.` and `Tapped!` printed with nobody tapping |
| 9.3 P1 | Take `setState` away again | 9.2's symptom, back on demand |
| 9.8 P1 | `double.parse` instead of `tryParse`, then type `abc` | Nothing changes on screen; the terminal says `EXCEPTION CAUGHT BY GESTURE` ... `Invalid double` |
| 9.8 P2 | Start the slider at `250` | `Value 250.0 is not between minimum 120.0 and maximum 220.0` |

## Why step 3 matters more than the others

`step_3_broken_counter.dart` is the most useful file in this folder. Lesson
9.2 ends unresolved on purpose, and **running the broken version beats being
told about it.** Tap Add one, watch the terminal count up while the screen
sits at 0, and write your own explanation of why before watching 9.3 P1.

The diff of the module is **`step_3` → `step_4`**: two classes instead of one,
`count` out of `build` and into the State class, and one word around the
change.
