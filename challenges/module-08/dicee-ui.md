# Challenge — Dicee UI (static)

Build the dice screen — layout only. Next module, one function brings it to life (that's a promise, not a tease… okay, it's both).

**Starter:** `starter-projects/module-08/dicee/` — empty Scaffold + all 6 dice images in assets.

## The target
*(held up on camera in video 8.8 — the reference build is `complete-projects/module-08/dicee-v1-static/`)*
- A blue **gradient background** filling the screen (dark at the top, lighter at the bottom)
- A `DICEE` title at the top (big, bold, wide letter-spacing) with a small subtitle under it
- Two dice images **side by side**, equal size, each sitting on a soft translucent rounded pad, filling the width nicely
- A large styled `ROLL` button with an icon, centered below the dice — dimmed, because nothing can happen yet

## Requirements
1. **Sketch first.** On paper: which parts are a Row? a Column? Where does Expanded go? Photograph your sketch — you'll compare it to the solution's sketch.
2. The two dice share width equally on ANY screen size — `Expanded`, not pixel widths. Test by rotating the device.
3. Dice are tappable-looking but static — a plain `Image.asset` is fine this week.
4. The button is a styled `Container`, like the ticket card's Book button: rounded corners, generous padding, your own `TextStyle`. It only has to *look* like a button — real buttons are Module 9.

## Rubric
- [ ] Rotate the device: no overflow stripes, dice resize gracefully
- [ ] No hardcoded widths/heights on the dice
- [ ] Your paper sketch exists and roughly matches your widget tree
- [ ] Widget tree nests no deeper than it needs (a Column-in-a-Column with one child is a smell)

## Hints (gated)
- Skeleton: `Column` → [ title, `Spacer`, `Row` of dice, `Spacer`, button ]. The Row's children: two `Expanded`, each wrapping the die.
- Pull the die out into its own tiny widget class (e.g. `DieFace(value: 1)`) — the Row then reads as "two dice, side by side" instead of a wall of nesting. Same extraction habit as Module 7's `InfoCard`.
- The gradient: wrap the body in a `Container` with `decoration: BoxDecoration(gradient: LinearGradient(...))`. Same `BoxDecoration` you used for cards in lesson 7.11 — one new property.
- `Spacer()` pushes things apart by eating the leftover space — handy between the title, the dice and the button.
- The icon and the word sit side by side, so the button's child is a small `Row`. On its own a Row stretches to the full width — `mainAxisSize: MainAxisSize.min` makes it hug its children.
- Dice look squished? Check whether some parent forces a height. The inspector's layout explorer (video 8.6) shows you exactly who decided what size.

## Bonus
Add a third die. With correct `Expanded` usage this is one more child in the Row and everything still fits. (Delete it after — Dicee canon is two dice.)


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 45 minutes. Reference: `complete-projects/module-08/dicee-v1-static/`.
