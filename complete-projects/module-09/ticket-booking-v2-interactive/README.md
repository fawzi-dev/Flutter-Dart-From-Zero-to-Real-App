# Ticket Booking v2 — the Module 9 lesson project

The Module 8 screen, **woken up** — the Module 8 code with the same names (`EvenDetails`, `DividerContainer`, `Tiers`, `StepButton`), so it matches the videos. It keeps the poster, palette, description,
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
| 9.5 P2 · One word, and it comes alive | `StatefulWidget` + `setState` make the quantity, the heart and the total work. |
| 9.5 P3 · Pick a tier | The chips become real choices: a `prices` list, `tierIndex` in State, `intl` for the commas, `void Function(int)`. |
| 9.5 P4 · Book works | Book becomes a real `ElevatedButton`, `sold` is State, and booking moves the bar, with a guard against overselling. Every control now works. |
| 9.6 P1 · TextField and controller | A decorated discount field reads its controller when Apply is tapped. The controller is disposed with the screen. |
| 9.6 P2 · The discount code | `applyCode`, two guards, `errorText`, the app theme and the discounted total. |
| 9.6 P3 · Dropdown | Delivery comes from three valid choices. |
| 9.6 P4 · Switch | The customer can turn the reminder on or off. |
| 9.6 P5 · Checkbox | Book stays grey until the policy is accepted. |
| 9.7 P1 · SnackBar | Book explains both refusals and offers UNDO. |
| 9.7 P2 · Dialog | Start over asks before clearing the ticket. |

The ticket card runs **in one go**, 9.5 to 9.7 — ten videos in the same
project. Every concept it needs is taught first on the state playground (9.1 to
9.3), and Dicee (9.4) comes just before it.

## Nothing here is faked

That is the point. Pick a tier, change the
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

Dicee (9.4) sits just before the ticket card on purpose. It is **your own
Module 8 challenge** brought to life — the emotional payoff of `setState`,
on your app — so it gets its own video and its own project
(`complete-projects/module-09/dicee-v2-interactive/`), and it is where
`VoidCallback` is first explained, on a tappable die.

The module challenge is the **BMI calculator**, a third shape again.

## The thing to notice

**The visual identity stays familiar.** The poster, description, palette and
ticket tiers remain. Module 9 changes the controls and adds booking inputs,
then gives the screen memory.

## Three details worth noticing

**`SoldBar` and `TierChip` are still Stateless** — they own nothing, they are
handed values and a callback. Only the widget that holds the truth gets
converted. Default to Stateless.

**The prices are one list, and the State keeps a number.** `tierIndex` is 0,
1 or 2, and every chip, the price and the total read it, so they can't
disagree.

**`money()` is one line**, `NumberFormat('#,###')` from the `intl` package.
The commas are not the lesson, so a package does them.

## Scope

No packages, no network, no storage. Close the app and it forgets everything —
that is Module 15's job.
