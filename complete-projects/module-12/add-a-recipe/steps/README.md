# Steps — Module 12, Add a Recipe

Module 12 is one screen gaining machinery, not a screen growing, so the useful
checkpoint is a single one — and it is the *bad* version.

| File | End of | What it is |
|---|---|---|
| `step_1_the_hard_way.dart` | **12.1** | **The Module 9 approach, at five fields.** It works. It does not scale. |
| `lib/` | **12.2 → 12.5** | The same form, rebuilt on `Form` + `validate()`. |

## Why the bad version is the file worth keeping

Lesson 12.1 exists to make one argument, and the argument only lands if you can
see both versions side by side. Open `step_1_the_hard_way.dart` and count:

- **five** `String?` error fields, all managed by hand
- **one** giant `setState` that re-checks every rule
- a return condition that `||`s every error together

Now ask the question the lesson asks: **what would it take to add a sixth
field?** You edit that method in three separate places, and if you forget one
of the `||`s the form submits with bad data and nobody finds out until a user
complains.

Then open `lib/screens/recipe_form_screen.dart` and count again. One `Form`,
one key, one `validate()`, and each rule living next to the field it belongs to.

## What the finished version adds, lesson by lesson

- **12.2** — `Form`, a `GlobalKey<FormState>`, and `TextFormField`. A validator
  returns `String?`, and **null means valid**.
- **12.3** — real rules, including the cross-field one: total time must be at
  least prep time, which works because a validator is ordinary Dart and can read
  another controller.
- **12.4** — `DropdownButtonFormField` validates with the form. A plain
  `Checkbox` does **not**, so you check it by hand.
- **12.5** — keyboard types, `FocusNode`s so "next" jumps, everything disposed,
  and a submit that stays silent until the first attempt.

## The trap, in one line

`_formKey.currentState!.validate()` returns **true** with the terms box
unticked. The `Form` cannot see a plain `Checkbox`. Walk into that once, on
purpose, before the challenge does it to you.
