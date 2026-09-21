# Challenge 1 — Tip Calculator (console)

Build a program that **asks** for the dinner details, then calculates the tip and splits the bill. **Blank file, `dart run` — no starter code. You've got this.**

## The scenario
You and two friends had dinner. The bill is **87.50**, you're tipping **15%**, splitting **3** ways.

## Requirements
1. Store the bill, tip percentage, and number of people in variables — use `final` wherever the value never changes.
2. **Calculate** the tip, the total, and the per-person share. Typing the answers in as numbers is cheating yourself.
3. Every money amount prints with **exactly 2 decimal places**.
4. Build each receipt line with **string interpolation** (`$` / `${...}`).

## Expected output
```
--- Dinner Receipt ---
Bill:      $87.50
Tip (15%): $13.13
Total:     $100.63
Per person (3 people): $33.54
```

## Hints (use only if stuck — try 10 minutes without them)
- Stuck at the blank file? Just create the three variables and print the bill. Run. Then add ONE calculation. Run. Tiny step → run → repeat.
- 15% of the bill = `bill * 15 / 100`
- Two decimals: `someNumber.toStringAsFixed(2)` — and it works inside `${...}`
- Want a literal `$` inside a string? Escape it: `\$`

## Bonus
Run it twice with different answers — 20% instead of 15%, 5 people instead of 3 — and check every line of the receipt updates correctly. If any number stays stubbornly the same, it was hardcoded somewhere: find it and compute it instead.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ **Minimum 30 focused minutes before watching the solution video.** The struggle is the workout.
