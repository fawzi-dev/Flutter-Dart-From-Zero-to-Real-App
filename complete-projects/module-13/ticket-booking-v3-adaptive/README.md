# Ticket Booking v3 — the Module 13 lesson project

The ticket card's third and final upgrade. **Module 8 built it. Module 9 gave
it a memory. Module 13 makes it work on hardware you do not own, in a room
whose lights you cannot see.**

```
flutter pub get
flutter run -d chrome     # then drag the window edge across 600px
```

## What each video adds

| Lesson | The card gains |
|--------|----------------|
| 13.2 · MediaQuery | Nothing visible — reading the device, and writing down the two widths |
| 13.3 · LayoutBuilder | Stacked under 600, poster-beside-booking over it |
| 13.4 · Theming | Every hardcoded colour replaced with a **role** |
| 13.5 · Dark mode | A light palette, a dark palette, and a System/Light/Dark toggle |

## The moment worth pausing on

**Two layouts, zero duplicated widgets.**

```dart
if (constraints.maxWidth < 600) return _narrow();
return _wide();
```

Both branches use the same `EventPoster`, `EventHeading`, `SoldBar`, `TierRow`,
`QuantityRow` and `TotalRow` — because those were extracted into separate
widgets back in Module 8.

**That is the payoff.** If everything had
stayed in one 200-line build method, this lesson would mean copy-pasting the
whole screen and maintaining two of them forever. The extraction habit from 7.4
is what makes responsive layout cheap five modules later.

## The colour rule

No widget in this project contains a hex code or a `Colors.something`.
Everything asks: `scheme.surface`, `scheme.onSurface`,
`scheme.onSurfaceVariant`, `scheme.primary`, `scheme.onPrimary`,
`scheme.outlineVariant`.

`onPrimary` is the one to notice — *"whatever reads on top of primary"*. The
theme works that out in both palettes, so the `FEW LEFT` badge text is never
invisible and you never think about it again.

**The test in `test/` proves it:** it grabs the title's colour in light mode
and in dark mode and asserts they differ. If anyone hardcodes a literal back
in, that test fails.

## Why the poster grows on wide screens

`EventPoster` takes a `height` parameter — 210 on a phone, 420 on a tablet. A
hero image that stays phone-sized on a 1200px screen looks like a mistake. One
parameter, passed differently by each branch.

## Scope

Still no storage — the theme choice resets when the app closes. Persisting it
is a two-line exercise once Module 15 lands.
