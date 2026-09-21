# Module 7 Assignment — Recipe Card

**Independent practice (Level 2).** A second static screen from scratch, same skills as the About Me card.

## Brief
Build a single static screen showing one recipe: a photo, a title, a short description, and a list of "facts" (prep time, servings, difficulty) — each fact as an icon + text row.

## Requirements
1. A gradient or coloured background, a rounded image (`CircleAvatar` or a clipped `Container`), a bold title and a subtitle.
2. **One reusable `FactRow` widget** (icon + text via constructor parameters), used at least **three** times.
3. Your own `TextStyle`s — no defaults; sensible `SizedBox` spacing.
4. `SafeArea` + `SingleChildScrollView` (both lesson 7.15) so it survives small screens and rotation.

## Rubric
- [ ] Zero copy-pasted fact rows — one class, used 3×
- [ ] Adding a fourth fact costs exactly one line
- [ ] No overflow stripes when rotated
- [ ] You can point at any line and say what it does

## Difficulty
**Level 2 — Independent.** Extension (**Level 3**): make the card's accent colour a single top-level constant you can change in one place — the `const kAccent = Color(0xFF...)` habit from lesson 7.9.

⏱️ Minimum 45 minutes.
