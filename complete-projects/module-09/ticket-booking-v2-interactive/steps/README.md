# Steps — Module 9, the ticket card

Module 9 is not a screen *growing*, the way Module 8 was. It is one screen
**gaining behaviour**. So the checkpoints mark what the screen can *do*.

Every file starts from the Module 8 screen exactly as it was built in the videos —
`EvenDetails`, `DividerContainer`, `Tiers`, `StepButton` — and adds only what
its lesson teaches. Each file is `lib/main.dart` as it stood at the **end** of
one lesson, and its header says what that lesson added.

| File | End of | What it is |
|---|---|---|
| `step_1_listening.dart` | **9.5 P1** | The screen hears taps; quantity still lives inside `build`. |
| `step_2_alive.dart` | **9.5 P2** | State only: `quantity` and the heart in the State, the guard, and the total as a getter (VIP, no commas yet). |
| `step_2b_tiers.dart` | **9.5 P3** | The tier chips become real choices: `prices`, `tierIndex`, `intl`'s `NumberFormat`, `InkWell` + `Ink`, `void Function(int)`. |
| `step_2c_book.dart` | **9.5 P4** | Book is a real `ElevatedButton`, `sold` is State, booking moves the bar, and a guard stops overselling. Every control works; nothing new was taught. |
| `step_3a_field.dart` | **9.6 P1** | A discount `TextField` with label, hint and border, in `Expanded` beside Apply. Apply does nothing yet. |
| `step_3b_controller.dart` | **9.6 P2** | A `TextEditingController` in the State, connected; Apply prints the code; `dispose`. |
| `step_3c_discount.dart` | **9.6 P3** | Theme, `applyCode`, two guards, `errorText` and the discounted total. |
| `step_3d_dropdown.dart` | **9.6 P4** | Delivery from a fixed list. |
| `step_3e_switch.dart` | **9.6 P5** | Reminder on or off. |
| `step_3f_checkbox.dart` | **9.6 P6** | Book stays grey until the policy is accepted (`VoidCallback?`). |
| `step_4_booked.dart` | **9.7 P1** | SnackBars explain both refusals and offer UNDO. |
| `step_4b_dialog.dart` | **9.7 P2** | Start over asks first; final code matches `lib/main.dart`. |

The ticket card runs in one go, 9.5 to 9.7. The concept lessons before it —
9.1 to 9.3, and 9.8's slider and segmented button after it — are built in
`../state-playground/`. 9.4 is Dicee. None of them change the ticket screen.

## Why step 1 ends broken

9.5 P1 makes the screen listen, then hands `quantity` to plus and minus the
way the counter did in 9.2: as a local inside `build`. You will recognise the
bug in seconds, because you have already met it — and 9.5 P2 fixes it with the
word you learned on the counter. **Run the broken version** before 9.5 P2.

## The diffs worth doing

**`step_1_listening.dart` → `step_2_alive.dart`** is the diff of the module.
Two classes instead of one, `quantity` out of `build` and into the State class,
every change wrapped in `setState`, and the total becomes a **computed getter**
so it can never disagree with the quantity. Read the getter, then try to find
the code that updates the price. There isn't any.

**`step_2_alive.dart` → `step_2b_tiers.dart`**: the chip prices become a
list, the State remembers which chip is picked, and `intl` puts the commas in.

**`step_2b_tiers.dart` → `step_2c_book.dart`** finishes the card: the last
picture of a button becomes a button, and the seats bar reads State.

**`step_2c_book.dart` → `step_3a_field.dart`** adds a decorated discount field
beside Apply. **`step_3a_field.dart` → `step_3b_controller.dart`** adds the
controller and its `dispose`, and Apply reads it. **`step_3b_controller.dart` →
`step_3c_discount.dart`** adds validation, the theme and the new total. The next
three checkpoints add one booking input per lesson: dropdown, switch, then
checkbox — where Book is switched off until the person agrees.

**`step_3f_checkbox.dart` → `step_4_booked.dart`**: the button goes back to
always-enabled (and `VoidCallback?` loses its `?`), and `book()` learns to
*say* why it refused, for the policy and for the seats, plus a SnackBar with
**UNDO**. `hideCurrentSnackBar()` keeps it to one answer at a time.

**`step_4_booked.dart` → `step_4b_dialog.dart`**: a Start over button and an
`AlertDialog` that hands back a `bool`. Booking has UNDO, so it never asks.
Clearing every choice has no UNDO, so it asks first.

## Dicee

Dicee's before and after are two separate projects, so they need no steps:

- **static:** `complete-projects/module-08/dicee-v1-static/`
- **rolling:** `complete-projects/module-09/dicee-v2-interactive/`
