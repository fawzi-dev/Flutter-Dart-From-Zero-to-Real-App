# Challenge — About Me Card

Your first Flutter build from (nearly) nothing: a personal profile card, static, one screen.

**Starter:** `starter-projects/module-07/about-me-card/` — an empty Scaffold + your photo asset already wired in pubspec. Everything visible on screen, you type.

**Before you start:** run `git init` in the starter folder and make at least two honest commits while you build. Use the Module 7 Git routine: check `git diff`, commit when the app runs, restore only when you truly want to throw work away.

## The target
*(screenshot in the starter's README — match the structure, personalize the content)*
- A **gradient background** filling the screen (two shades of one colour, top to bottom)
- Centered column: a round profile photo sitting inside a **white ring** → your name (large, bold) → a **pill-shaped badge** reading something like `FLUTTER DEVELOPER IN TRAINING` (small, letter-spaced, on a translucent background) → **three info cards** (phone, email, link), each one an icon inside a **tinted circle** next to the text, on a white rounded card with a soft shadow

## Requirements
1. `CircleAvatar` for the photo (radius ~60), wrapped in a `Container` with a circular white `border` — a Container around a Container, which is lesson 7.11 with one new property. See the hints if you can't make a Container round.
2. Name and badge are `Text` with your own `TextStyle`s — no default styling.
3. Each info card is built ONCE as your own widget class (e.g. `InfoCard`) taking the icon and text as **constructor parameters** — then used **three times**. (This is the Quiz `Question` class wearing widget clothes — lesson 7.8.)
4. Use it with your real info… or fake info, it's going on GitHub.
5. Everything centered horizontally; sensible spacing (`SizedBox` between elements).
6. Wrap the screen in `SafeArea` and `SingleChildScrollView` (lesson 7.15) so it clears the notch and survives rotation.

## Rubric
- [ ] Zero copy-pasted widget blocks — the three info rows come from ONE class used three times
- [ ] `InfoCard` uses named parameters: `InfoCard(icon: Icons.phone_outlined, text: '+20 100 ...')`
- [ ] Runs with no yellow/black overflow stripes (rotate the device to check!)
- [ ] Content clears the notch — `SafeArea` is in there
- [ ] Git history shows at least two real checkpoints, not one final blob
- [ ] You can point at any line and say what it does

## Hints (gated)
- Order of work: get ALL content on screen ugly first (plain Texts in a Column), then style top-down. Beauty last — same as the tip calculator.
- The gradient is a `BoxDecoration` with `gradient: LinearGradient(begin:, end:, colors: [...])` instead of `color:`. Same widget as 7.11, one different property.
- The pill badge is just a `Container` with a `borderRadius` bigger than half its height, and a translucent fill via `Colors.white.withValues(alpha: 0.16)`.
- Icon + text side by side = a `Row` inside the card. `Row` is next module's topic officially, but you built one under the cook on the recipe card in 7.12 — using it early with a hint is allowed.
- Making a `Container` **round**: put `shape: BoxShape.circle` in its `BoxDecoration` — and note that a Container with a `shape` must not also have a `borderRadius`. If you'd rather not learn a new property, a `borderRadius` bigger than half the Container's width gives you the same circle. Either passes.
- The type of an icon is `IconData` — so `InfoCard`'s field is `final IconData icon;`, and `Icons.phone_outlined` is a value of that type. Same `final` field + `required` named parameter recipe as the Module 5 data classes.
- White rounded background: `Card` widget, or `Container` with `BoxDecoration(borderRadius: ...)`. Either passes.

## Bonus
Add a **fourth** `InfoCard` (location, or your favourite language). It should cost you exactly one line. If it costs more, requirement 3 wasn't really met — that one-line test is the whole reason the class exists.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 1 hour before the solution. Compare against `complete-projects/module-07/about-me-card/` when done.
