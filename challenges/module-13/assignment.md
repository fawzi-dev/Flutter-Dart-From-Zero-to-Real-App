# Module 13 Assignment — Responsive Profile Card

**Independent practice (Level 2).** Responsiveness and theming on a single, small screen — no gallery to hide behind.

## Brief
One screen showing a person's profile: an avatar (an `Icon` or `CircleAvatar` is fine), a name, a bio line, and a row of three stat blocks (e.g. Posts / Followers / Following). Make it reflow *and* respect dark mode.

## Requirements
1. **Reflow with `LayoutBuilder`:** on a narrow screen the avatar sits **above** the name/bio (a `Column`); on a wide screen (`≥ 600`) the avatar sits **beside** them (a `Row`). One build, one branch.
2. **Themed colors only:** every color from `Theme.of(context).colorScheme` / `textTheme`. No `Colors.white`/`Colors.black`/background hex. The stat blocks use `primaryContainer` / `onPrimaryContainer`.
3. **Dark mode:** `theme` + `darkTheme` from one seed, `themeMode` starting at `ThemeMode.system`, and an app-bar toggle (light ⇄ dark is enough here).
4. **`SafeArea`** so nothing hides under a notch.

## Rubric
- [ ] Narrow = avatar above; wide = avatar beside — via a single `LayoutBuilder` branch
- [ ] Flipping the system dark setting recolors everything, no code change
- [ ] The toggle works and nothing stays stubbornly white
- [ ] No structural color literals anywhere in the file

## Difficulty
**Level 2 — Independent.** Extension (**Level 3**): add a "text size" respect — read `MediaQuery.textScalerOf(context)` and confirm your layout doesn't overflow when the user has large system font sizes on (fix any overflow with `Flexible`/`FittedText`).

⏱️ Minimum 60 minutes.
