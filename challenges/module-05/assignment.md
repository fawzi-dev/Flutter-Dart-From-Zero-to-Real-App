# Module 5 Assignment — Contact Book Model

**Independent practice (Level 2).** Classes, enums and null safety, no widgets.

## Brief
Model a tiny contact book in the console: a `Contact` class and a `ContactBook` class that owns a list of them and answers questions about them.

## Requirements
1. A `Contact` class: `name` (required), `phone` (required), `email` (**nullable** — not everyone has one), and a `label` **enum** (`family`, `work`, `friend`).
2. A `ContactBook` class holding a `List<Contact>` with methods: `add`, `count` (a getter), and `describe()` that prints each contact — showing the email only when it exists (`?.`/`??`).
3. `main` builds a book, adds a few contacts (some without an email), and prints the summary. **No logic in `main`** beyond wiring.
4. Not a single `!` anywhere you can't justify out loud.

## Rubric
- [ ] `email` is nullable and handled without crashing when absent
- [ ] `label` is an enum, not a String
- [ ] Behaviour lives in the classes; `main` only wires
- [ ] `Contact(name: ..., phone: ...)` reads one rename away from a Flutter widget

## Difficulty
**Level 2 — Independent.**

⏱️ Minimum 45 minutes. This model is the direct ancestor of every Flutter model class you'll write from Module 10 on.
