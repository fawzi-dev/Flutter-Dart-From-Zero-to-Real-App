# Snapshots of the ticket card, stage by stage

Each file is `lib/main.dart` exactly as it stood at the end of one video. Drop
one into `lib/` and run it if you want to see the screen at that point, or diff
two of them to see what a lesson actually changed.

| File | What it adds |
|------|--------------|
| `step_1_skeleton.dart` | The palette, the gap scale, Scaffold + SafeArea + Padding + Column, four Text placeholders |
| `step_2_poster.dart` | The poster — `Stack` + `ClipRRect` image + a `Positioned` FEW LEFT pill |
| `step_3_title.dart` | The event title + heart — overflow, patient one (`Expanded` + ellipsis); `static const _title` |
| `step_4_details.dart` | The date and the two-line description |
| `step_5_sold_bar.dart` | The tickets-sold bar — fixed, fixed, `Expanded`, fixed, fixed; `flex` from the numbers |
| `step_6_tiers.dart` | The three ticket tiers, one `Expanded` each |
| `step_7_quantity.dart` | The quantity row — `spaceBetween`, a Row inside a Row, `_StepButton` |
| `step_8_total_and_button.dart` | The total row and the Book button |
| `step_9_polish.dart` | Overflow, patient two (`SingleChildScrollView` for landscape) and the divider — same as `lib/main.dart` |

The screen is built top to bottom. Every idea on it was met first in
`layout-playground`; the two that were only touched lightly there get their
proper moment here — overflow in steps 3 and 9, `static const` in step 3.

## The polish (step 9)

Step 8 already has every piece on the screen. Step 9 adds two things:

1. **Overflow, patient two** — rotate to landscape and the Column is simply
   too tall. Not share, not shrink: scroll. `SingleChildScrollView` around the
   lot.
2. **The divider** — a one-pixel `Container` in `kLine` above the total.

And three habits, none of them a widget:
   - the spacing comes from `kGapS/M/L/XL` and nowhere else
   - exactly one accent — the selected tier, the badge and the Book button
   - the greys are one grey, `kMuted`, everywhere

> **Try it:** break each of those three and put it back. Change a gap to a
> raw `19`. Make a second tier red. Nudge one `kMuted` slightly. Nobody can
> name what changed; everybody can feel it.

And the checks, every time: **rotate**, then **make the window narrow.** Both
hold, because the seats bar shares instead of measuring, the tiers split the
width, and the long title ellipsises.

## A note on the test file

`test/widget_test.dart` is written against the finished screen, so it only
passes on `step_9_polish.dart` / `lib/main.dart`.
