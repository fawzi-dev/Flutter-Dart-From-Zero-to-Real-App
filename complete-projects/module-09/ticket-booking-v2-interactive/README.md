# Ticket Booking v2 — the Module 9 lesson project

The Module 8 screen, **woken up**. It keeps the poster, palette, description,
tier cards and spacing while the existing controls gain behavior. New booking
inputs appear below the quantity row, one per lesson.

```
flutter pub get
flutter run
```

## What each video adds

| Lesson | The card gains |
|--------|----------------|
| 9.1 P3 · The button family | `IconButton` on the heart and the steppers, and `QuantityRow` takes callbacks. They print. Nothing moves — deliberately |
| 9.2 · The UI won't update | `quantity` as a local inside `build`: it changes in the terminal; the screen never updates |
| 9.3 P2 · StatefulWidget & setState | Real tier data (`Tier`, `tiers`, `money`), then one word, and the quantity, the tier and the total all work |
| 9.4 · Make the dice roll | Nothing — that video is about **your** Dicee app |
| 9.5 P2 · Bad input, and the discount code | The app theme, and the discount code: controller, validation, `errorText`, `dispose` |
| 9.6 P1 · Dropdown | Delivery comes from three valid choices |
| 9.6 P2 · Switch | The customer can turn the reminder on or off |
| 9.6 P3 · Checkbox | Book becomes a real button, and stays disabled until the policy is accepted |
| 9.6 P4–P5 · BMI input demos | Slider and segmented button prepare the challenge; the ticket card does not change |
| 9.7 P1 · SnackBar | Book always answers: it says why it refused, and booking moves the sold bar with a working UNDO |
| 9.7 P2 · Dialog | Start over asks first, and only a confirmed answer clears the ticket's choices |

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

Lesson 9.4 is the exception on purpose. Everything else happens on this
ticket card; 9.4 opens **your own Module 8 challenge**, Dicee, and brings that
to life instead. It is the payoff of the module — your app, moving — so it
gets its own video and its own project
(`complete-projects/module-09/dicee-v2-interactive/`).

The module challenge is the **BMI calculator**, a third shape again.

## The thing to notice

**The visual identity stays familiar.** The poster, description, palette and
ticket tiers remain. Module 9 changes the controls and adds booking inputs,
then gives the screen memory.

## Three details worth noticing

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
