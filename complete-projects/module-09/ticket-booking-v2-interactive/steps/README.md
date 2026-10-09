# Steps — Module 9, the ticket card

Module 9 is not a screen *growing*, the way Module 8 was. It is one screen
**gaining behaviour**. So the checkpoints mark what the screen can *do*.

Every file starts from the Module 8 screen exactly as it was built in the videos —
`EvenDetails`, `DividerContainer`, `Tiers`, `StepButton` — and adds only what
its lesson teaches. Each file is `lib/main.dart` as it stood at the **end** of
one video, and its header lists that video's beats in order.

| File | End of | What it is |
|---|---|---|
| `step_1_listening.dart` | **9.5 P1** | The screen hears taps; quantity still lives inside `build`. |
| `step_2_alive.dart` | **9.5 P2** | State, tier data and the computed total make the ticket come alive. |
| `step_3a_textfield.dart` | **9.6 P1** | Discount TextField, decoration, controller and `dispose`; Apply prints the text. |
| `step_3b_discount.dart` | **9.6 P2** | Theme, `applyCode`, two guards, `errorText` and the discounted total. |
| `step_3c_dropdown.dart` | **9.6 P3** | Delivery from a fixed list. |
| `step_3d_switch.dart` | **9.6 P4** | Reminder on or off. |
| `step_3e_checkbox.dart` | **9.6 P5** | Policy agreement enables Book. |
| `step_4_booked.dart` | **9.7 P1** | SnackBars explain refusals and offer UNDO. |
| `step_4b_dialog.dart` | **9.7 P2** | Start over asks first; final code matches `lib/main.dart`. |

The ticket card runs in one go, 9.5 to 9.7. The concept lessons before it —
9.1 to 9.3, and 9.8's slider and segmented button after it — are built in
`../state-playground/`. 9.4 is Dicee. None of them change the ticket screen.

## Why step 1 ends broken

9.5 P1 makes the screen listen, then hands `quantity` to plus and minus the
way the counter did in 9.2: as a local inside `build`. You will recognise the
bug in seconds, because they have already met it — and 9.5 P2 fixes it with the
word they learned on the counter. **Run the broken version** before 9.5 P2.

## The diffs worth doing

**`step_1_listening.dart` → `step_2_alive.dart`** is the diff of the module.
Two classes instead of one, `quantity` out of `build` and into the State class,
every change wrapped in `setState`, and the total becomes a **computed getter**
so it can never disagree with the quantity. Read the getter, then try to find
the code that updates the price. There isn't any.

**`step_2_alive.dart` → `step_3a_textfield.dart`** adds the decorated discount field, controller and matching `dispose`. **`step_3a_textfield.dart` → `step_3b_discount.dart`** adds validation, the theme and the new total. The next three checkpoints add one booking input
per lesson: dropdown, switch, then checkbox — where Book becomes a real button,
disabled until the person agrees.

**`step_3e_checkbox.dart` → `step_4_booked.dart`**: the button goes back to
always-enabled (and `VoidCallback?` loses its `?`), `sold` becomes state, and
`book()` learns to *say* why it refused, plus a SnackBar with **UNDO**.

**`step_4_booked.dart` → `step_4b_dialog.dart`**: a Start over button and an
`AlertDialog` that hands back a `bool`. Booking has UNDO, so it never asks.
Clearing every choice has no UNDO, so it asks first.

## Dicee

Dicee's before and after are two separate projects, so they need no steps:

- **static:** `complete-projects/module-08/dicee-v1-static/`
- **rolling:** `complete-projects/module-09/dicee-v2-interactive/`
