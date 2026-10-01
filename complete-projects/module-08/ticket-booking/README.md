# Ticket Booking — the Module 8 lesson project

The screen built in the videos, one piece per video, across all of
Module 8. `lib/main.dart` is the finished screen.

```
flutter pub get
flutter run
```

## What each video adds

Every layout idea is met first in `layout-playground`. Here it goes onto a real
screen, top to bottom. Snapshots of each stage are in `steps/`.

| Step | The screen gains |
|------|------------------|
| 1 | The palette, the gap scale, and the Column skeleton — four placeholder Texts, ugly on purpose |
| 2 | The poster, with a `FEW LEFT` badge layered on it — `Stack` + `Positioned` |
| 3 | The event title + heart — overflow, patient one (`Expanded` + ellipsis); `static const` |
| 4 | The date and the description |
| 5 | The sold bar — `flex: sold` against `flex: remaining` |
| 6 | Three tier chips sharing the width |
| 7 | The quantity row: label at one end, stepper at the other — `spaceBetween` |
| 8 | The total row and the Book button |
| 9 | The polish — overflow, patient two (`SingleChildScrollView` for landscape) and the divider |

## Why a ticket card

Module 8's challenge (8.9) is the **Dicee UI** — two dice side by side, a
title, a button. This screen is a different shape: a tall Column with several
Rows, a Stack, and Expanded doing two different jobs.

And it is **honest**. Every number on it means something, and by Module 9 every
control genuinely changes one. Nothing on it is decoration pretending to be
data.

## The three polish habits (step 9)

None of them is a widget, and together they are most of the distance between
"a tutorial app" and "an app":

1. **A spacing scale.** `kGapS/M/L/XL` — 8, 12, 24, 32. Four numbers, reused.
   Change one to 19 and the screen feels wrong before anyone can say
   why.
2. **Derived, not stored.** The sold bar is `flex: sold` against
   `flex: remaining`. It cannot disagree with the numbers either side of it,
   because it is computed from them.
3. **Exactly one accent.** One tier is highlighted; the rest are outlines.
   Highlight a second and there is no accent at all.

## Two things worth pausing on

**Three equal options share the width.** The tier chips are `Expanded`, not
measured — hardcode their widths and the row overflows on a small phone. That
is 8.3's "three boxes that always split evenly" drill doing a real job, and
there is a test for it.

**The total row is fixed + Expanded.** A long price on a narrow phone is
exactly the overflow from 8.5. Letting the price take the remaining width and
align right means it can never happen.

## Scope

No state anywhere. Nothing on this screen is tappable, and that is deliberate:
Module 9 is the module that makes a screen move.
