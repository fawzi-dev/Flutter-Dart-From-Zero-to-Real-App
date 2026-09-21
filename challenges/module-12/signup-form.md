# Challenge — Sign Up

The form every app has. Six inputs, real validation, a keyboard that flows field to field, and a submit that either tells the user exactly what's wrong or takes them to a welcome screen. One `validate()` call checks the whole thing — the payoff of the entire module.

**Starter:** `starter-projects/module-12/signup-form/` — a fresh project with a themed `MaterialApp` already set up.

## The product
One screen, one `Form`, six inputs stacked in a scrollable list:
1. **Full name** — required
2. **Email** — required and shaped like an email
3. **Password** — at least 8 characters, obscured
4. **Confirm password** — must match the password
5. **Country** — a dropdown; one must be chosen
6. **Terms** — a checkbox that must be ticked

A **"Create account"** button validates everything at once. On success, navigate to a simple **welcome screen** that greets the user by the name they entered. On failure, every bad field shows its own message in place, and the form switches to validating live so errors clear as they're fixed.

## Requirements
1. A real `Form` with a `GlobalKey<FormState>`. Each text input is a `TextFormField` carrying its **own** `validator`. Submitting calls `_formKey.currentState!.validate()` **once** — no per-field error strings, no `||` chain.
2. **Cross-field validation:** the confirm-password field's validator compares against the **password** field's controller (not itself). The password field carries a `TextEditingController` for exactly this reason.
3. The **country** is a `DropdownButtonFormField` with a validator — it validates *with* the form. The **terms** checkbox is a plain `Checkbox`/`CheckboxListTile` — it is **not** a form field, so you check `_agreed` **by hand** in submit and show your own feedback (a `SnackBar`).
4. **Feel:** correct `keyboardType` per field, password `obscureText: true`, `FocusNode`s so the keyboard's "next" jumps field to field (last field = "done" → submit). **Dispose every controller and focus node.**
5. **Good submit:** start with `autovalidateMode: AutovalidateMode.disabled` (silent); on the first failed submit, switch to `AutovalidateMode.onUserInteraction` (live). No yelling at an empty form.
6. On success, `Navigator.push` to a welcome screen showing the entered name.

## Rubric
- [ ] **One `validate()` call** checks all five form fields — no hand-managed error strings
- [ ] Mismatched passwords → **only** the confirm field complains (a genuine cross-field validator)
- [ ] Submitting with the terms box **unticked** is refused — proving you know the checkbox isn't a form field
- [ ] The keyboard's "next" moves focus field to field; "done" on the last field submits
- [ ] Empty form starts silent, then validates live after the first Submit
- [ ] A valid form lands on the welcome screen with the correct name; every controller and focus node is disposed

## Hints (gated)
- **Skeleton first.** Get all six inputs on screen with **no validators** — just make it look right and scroll (`ListView`, not `Column`). Then add rules one at a time, testing each by submitting. Six validators written before the first run = one typo hides all your bugs.
- **The email check:** `RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)`. Copy it; you don't need to master regex today.
- **The match:** in the confirm field, `if (value != _passwordController.text) return 'Passwords don\'t match';`. It reads the *password's* controller — a validator is just Dart.
- **The checkbox trap:** `validate()` returns `true` even with the box unticked. In submit: `if (!_formKey.currentState!.validate() || !_agreed) { ... return; }`, with a `SnackBar` when `!_agreed`.

## Bonus
A **password-strength bar** under the password field: a thin colored bar that goes red → amber → green as the password lengthens. It reads the password controller in `build` and maps length to a color — the BMI-scale idea from Module 9, pointed at a password.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus is Level 3.

⏱️ Minimum 90 minutes. Reference: `complete-projects/module-12/signup-form/`.
