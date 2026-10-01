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
| `FormScreen` | 9.5 P1 | One `TextField`, its controller, and a greeting. |
| `DoubleScreen` | 9.5 P2 | "Double my number": input that cannot be trusted. |

## The steps

| File | Lesson | The concept | What changes |
|---|---|---|---|
| `step_1_first_button.dart` | 9.1 P1 | `ElevatedButton`, `child:` and `onPressed:`, `() {}`, `debugPrint`, `onPressed: null` | The `SizedBox` in the starter becomes a button that prints when tapped |
| `step_2_named_function.dart` | 9.1 P2 | Passing a function vs calling it | The anonymous function becomes `handleTap`, passed with no parentheses |
| `step_3_broken_counter.dart` | 9.2 | Why the screen won't change | **Deliberately broken.** `CounterScreen` with `count` inside `build`: the terminal counts, the screen stays at 0 |
| `step_4_setstate_counter.dart` | 9.3 P1 | `StatefulWidget`, `State`, `setState` | `CounterScreen` converted, `count` moved into the State class, the change wrapped in `setState` |
| `step_5_controller.dart` | 9.5 P1 | `TextField`, `InputDecoration`, `TextEditingController`, `dispose` | `FormScreen`: a decorated field, a controller as a field, Submit puts the text in a greeting |
| `step_6_parse.dart` | 9.5 P2, first half | `double.parse` vs `double.tryParse`, `errorText`, `keyboardType` | `DoubleScreen`, already polite: bad input gets a red line, not an exception |

`lib/main.dart` is the same file as `step_6`, so the project always runs.

The other Module 9 lessons do not use this project. 9.1 P3, 9.2's second half,
9.3 P2, 9.5 P2's second half, 9.6 Parts 1 to 3 and 9.7 are the ticket booking
app in `../ticket-booking-v2-interactive/`. 9.4 is Dicee. 9.6 Parts 4 and 5
are small demos in `../bmi-calculator/steps/`.

## The mistakes are the lessons

Five of the six lessons make a mistake on purpose. None of the broken
versions is saved as a file except step 3, because each one is one line away
from the step it belongs to. Make each one yourself:

| Lesson | The mistake, made on purpose | What you see |
|---|---|---|
| 9.1 P1 | Leave out `onPressed` | `The named parameter 'onPressed' is required, but there's no corresponding argument.` |
| 9.1 P2 | `onPressed: handleTap()` | `This expression has a type of 'void' so its value can't be used.` and `Tapped!` printed with nobody tapping |
| 9.3 P1 | Take `setState` away again | 9.2's symptom, back on demand |
| 9.5 P1 | Move the controller line into `build` | Submit shows the greeting, and the field comes back empty |
| 9.5 P2 | `double.parse` instead of `tryParse`, then type `abc` | Nothing changes on screen; the terminal says `EXCEPTION CAUGHT BY GESTURE` ... `Invalid double` |

## Why step 3 matters more than the others

`step_3_broken_counter.dart` is the most useful file in this folder. Lesson
9.2 ends unresolved on purpose, and **running the broken version beats being
told about it.** Tap Add one, watch the terminal count up while the screen
sits at 0, and write your own explanation of why before watching 9.3 P1.

The diff of the module is **`step_3` → `step_4`**: two classes instead of one,
`count` out of `build` and into the State class, and one word around the
change.
