# Ticket Booking v2 — the Module 9 lesson project

The Module 8 screen, **woken up** — the recorded Module 8 code, with the same names (`EvenDetails`, `DividerContainer`, `Tiers`, `StepButton`), so it matches the videos. It keeps the poster, palette, description,
tier cards and spacing while the existing controls gain behavior. New booking
inputs appear below the quantity row, one per lesson.

```
flutter pub get
flutter run
```

## What each video adds

| Lesson | The card gains |
|--------|----------------|
| 9.5 P1 · The ticket card listens | The heart and steppers become `IconButton`s; the screen hears taps. |
| 9.5 P2 · One word, and it comes alive | `StatefulWidget` + `setState` make tier, quantity, heart and total work. |
| 9.6 P1 · TextField and controller | A decorated discount field reads its controller when Apply is tapped. The controller is disposed with the screen. |
| 9.6 P2 · The discount code | `applyCode`, two guards, `errorText`, the app theme and the discounted total. |
| 9.6 P3 · Dropdown | Delivery comes from three valid choices. |
| 9.6 P4 · Switch | The customer can turn the reminder on or off. |
| 9.6 P5 · Checkbox | Book waits for policy agreement. |
| 9.7 P1 · SnackBar | Book explains refusals, books seats and offers UNDO. |
| 9.7 P2 · Dialog | Start over asks before clearing the ticket. |

The ticket card runs **in one go**, 9.5 to 9.7 — nine videos in the same
project. Every concept it needs is taught first on the state playground (9.1 to
9.3), and Dicee (9.4) comes just before it.

## Nothing here is faked

That is the point, and it is worth saying in the videos. Pick a tier, change the
quantity, enter the code — **the total is genuinely recomputed from those
three, every rebuild**:

```dart
int get total {
  final gross = tier.price * quantity;
  return gross - (gross * discountPercent ~/ 100);
}
```

VIP 60,000 × 2 = 120,000. Bump it to 3 → 180,000. Switch to Backstage → 190,000.
Apply `CITADEL20` → 96,000. Book → the sold bar actually moves. Every one of
those is a test in `test/`.

## "My tickets, your dice"

Dicee (9.4) sits just before the ticket card on purpose. It is **the student's
own Module 8 challenge** brought to life — the emotional payoff of `setState`,
on their app — so it gets its own video and its own project
(`complete-projects/module-09/dicee-v2-interactive/`), and it is where
`VoidCallback` is first explained, on a tappable die.

The module challenge is the **BMI calculator**, a third shape again.

## The thing to point at in the videos

**The visual identity stays familiar.** The poster, description, palette and
ticket tiers remain. Module 9 changes the controls and adds booking inputs,
then gives the screen memory.

## Three teaching details worth keeping

**`SoldBar` and `TierChip` are still Stateless** — they own nothing, they are
handed values and a callback. Only the widget that holds the truth gets
converted. Default to Stateless.

**`Tier` is a small data class.** It keeps each ticket name beside its price.
The dropdown lesson applies the fixed-choice idea to delivery methods: a
customer can select only an answer the app supports.

**`money()` is hand-written**, not a package. Module 2's loop and Module 1's
strings doing a small real job — and a reminder that not every problem needs a
dependency.

## Scope

No packages, no network, no storage. Close the app and it forgets everything —
that is Module 15's job.
