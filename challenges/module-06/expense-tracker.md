# CAPSTONE — Console Expense Tracker

**This is the gate before Flutter.** No tutorial, no build-along — a spec, a rubric, and you. Everything required uses Modules 1–5 only. Plan on paper first (video 6.1 shows how), then build.

> ⚠️ Minimum **3 honest hours** before opening the solution videos. This project is the single best predictor of how Flutter will go for you. Do not steal this from yourself.

## The product
A program that records expenses and reports on them, driven by a **menu loop**: show the options, read a choice, do the thing, repeat until the user quits. The *logic* is the product.

## Spec
1. A `Category` **enum** with five values: `food`, `transport`, `bills`, `fun`, `other`. A category is a fixed menu, not free text — `'Food'` and `'fodo'` must be impossible.
2. An `Expense` class: `final` description (String), amount (double), and category (**`Category`**, not String). Named required parameters.
3. A `Tracker` class holding a `List<Expense>` with:
   - `add(Expense e)`
   - `printAll()` — numbered lines, amounts to 2 decimals, category shown as a word
   - `total` — a **getter** (lesson 5.7), because a stored total goes stale
   - `printByCategory()` — one running total per category
   - `printLargest()` — the biggest expense, description and amount
4. An `askCategory()` that **prints the five categories and reads a number**. The user picks; the user never types a category name.
5. `main()`: a **menu loop** — show the options, read a choice, do the thing, repeat until they quit.
6. Zero logic in `main` — it only wires things together and routes choices.

## Expected output (shape, not exact numbers)
```
1) Add expense   2) List   3) By category   4) Largest   5) Quit
Choose: 1
Description: Groceries
Amount: 54.30
Category:
  1) food
  2) transport
  3) bills
  4) fun
  5) other
Choose 1-5: 1
Added.

--- Expenses ---
1. Groceries  $54.30  (food)
2. Metro card $15.00  (transport)
Total: $69.30

--- By category ---
food: $54.30
transport: $15.00

Largest: Groceries ($54.30)
```

## Rubric — check every box before the solution
- [ ] `Category` is an enum — a category name cannot be typed or misspelled anywhere
- [ ] `Expense` is immutable (all fields `final`)
- [ ] Every method that "answers a question" **returns**; printing happens in `printAll` and `main`'s summary only
- [ ] Adding a sixth value to the enum costs ONE word — the picker and the report follow by themselves
- [ ] `total` is a getter, not a stored field
- [ ] Adding a 7th expense = one line in `main`
- [ ] You planned on paper first and can show the plan

## Gated hints — each costs you; take them in order, 20 min apart
1. *Stuck at the blank file?* Write the `Category` enum and the `Expense` class, create ONE, print its description. Run. You've started.
2. *`total`?* `double get total` — a `var sum = 0.0`, a for-in, add each amount, return sum.
3. *The category picker?* Every enum has `Category.values` — a list of all its values. Loop it to print the menu, and index it with `choice - 1` to turn the number back into a `Category`.
4. *`printByCategory`?* A `Map<Category, double>`, and `totals[e.category] = (totals[e.category] ?? 0) + e.amount;` — the vote-counting Map from lesson 4.4.

## Bonus (only after the rubric passes)
- `int get count` and a `double get average` built from `total` and `count` instead of a third loop (reuse!)
- A sixth category (`health`) added to the enum — confirm the picker and the report both follow with no other edit
- Sort the listing by amount, biggest first, before printing

**Difficulty:** Level 3 — Extension. You design the solution from a spec — no steps, minimal hints. This is the real test.
