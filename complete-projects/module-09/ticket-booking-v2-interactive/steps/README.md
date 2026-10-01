# Steps — Module 9

Module 9 is not a screen *growing*, the way Modules 7 and 8 were. It is one
screen **gaining behaviour**. So the checkpoints here mark what the screen can
*do*, not what has been added to it.

| File | End of | What it is |
|---|---|---|
| `step_1_listening.dart` | **9.1 P3** | Real `IconButton`s on the heart and the steppers. `QuantityRow` takes two `VoidCallback`s. They print; nothing on screen changes. |
| `step_2_broken.dart` | **9.2** | **Deliberately broken.** `quantity` is a local inside `build`: the terminal counts, the screen stays at 2. |
| `step_3_alive.dart` | **9.3 P2** | `Tier`, `tiers` and `money()`, then `StatefulWidget` + `setState`. The quantity, the tier, the heart and the total all work. |
| `step_4a_discount.dart` | **9.5 P2** | The app theme, and a discount code that is checked and changes the total. |
| `step_4b_dropdown.dart` | **9.6 P1** | Delivery comes from a fixed list. |
| `step_4c_switch.dart` | **9.6 P2** | The reminder can be turned on or off. |
| `step_4d_checkbox.dart` | **9.6 P3** | Book becomes a real `ElevatedButton`, grey until the policy box is ticked. |
| `step_5_booked.dart` | **9.7 P1** | Book always answers. It says why it refused, and a booking moves the seats bar and can be undone. |
| `step_5b_dialog.dart` | **9.7 P2** | Finished, and identical to `lib/main.dart`. Start over asks first. |

9.1 P1, 9.1 P2, the counter in 9.2, 9.3 P1, 9.5 P1 and the "double my
number" half of 9.5 P2 are built in `../state-playground/`, and 9.4 is
Dicee, so they have no ticket checkpoint. 9.6 Parts 4 and 5 use small BMI input demos (in `bmi-calculator/steps/`). They do not change the ticket
screen, so there is no ticket checkpoint for those two lessons. The BMI
challenge then builds its own screen from the starter.

## Why step 2 matters more than the others

`step_2_broken.dart` is the most useful file in this folder. Lesson 9.2 ends
unresolved on purpose, and **running the broken version beats being told about
it.** Tap plus, watch the terminal count up while the screen sits at 2, and
write your own explanation of why before watching 9.3 P1.

Students who write that sentence first understand `setState` about twice as
fast, because they already have the question shaped in their head.

## The diffs worth doing

**`step_2_broken.dart` → `step_3_alive.dart`** is the diff of the module. The
tiers become real data, two classes instead of one, `quantity` moves out of
`build` into the State class, every change is
wrapped in `setState`, and the total becomes a **computed getter** so it can
never disagree with the quantity. Read the getter and then try to find the code
that updates the price. There isn't any. That's the point.

**`step_3_alive.dart` → `step_4a_discount.dart`** adds the discount-code
controller and validation. The next three checkpoints add one booking input
per lesson: dropdown, switch, then checkbox. The checkbox is the point where
Book becomes a real button, disabled until the person agrees.

**`step_4d_checkbox.dart` → `step_5_booked.dart`** is 9.7 P1: the button goes
back to always-enabled (and `VoidCallback?` loses its `?`), `sold` becomes
state, and `book()` learns to *say* why it refused, plus a SnackBar with
**UNDO** that puts the seats back.

**`step_5_booked.dart` → `step_5b_dialog.dart`** is 9.7 P2: a Start over button
and an `AlertDialog` that hands back a `bool`. Booking has UNDO, so it never
asks. Clearing every choice has no UNDO, so it asks first.

## One thing to read at the end

Read `lib/main.dart` top to bottom once when you finish. Every field in the
State class is something a human can change, and **everything else on the
screen is computed from those fields.** That is the whole module in one
sentence, and it is visible in the shape of the file.

## Dicee

Dicee's before and after are two separate projects, so they need no steps:

- **static:** `complete-projects/module-08/dicee-v1-static/`
- **rolling:** `complete-projects/module-09/dicee-v2-interactive/`

Diff those two and you have lesson 9.4 in about five lines.
