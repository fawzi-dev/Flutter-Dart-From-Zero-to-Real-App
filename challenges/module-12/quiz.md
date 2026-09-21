# Module 12 Quiz — Forms & Validation

Seven questions. **Pass mark: 70% (5 of 7).**

## Questions

1. **(concept)** A `TextFormField`'s `validator` returns a `String?`. What does returning a `String` mean, and what does returning `null` mean?
2. **(concept)** What does a single call to `_formKey.currentState!.validate()` actually do across a form with five fields?
3. **(code reading)** You have a "confirm password" field. Its validator is `if (value != _confirmController.text) return 'No match';`. It always says the passwords match even when they don't. Why?
4. **(concept)** You add a "must accept terms" `Checkbox`. `validate()` returns `true` and the form submits even when the box is unticked. Why — and how do you enforce it?
5. **(concept)** Why use a `ListView` instead of a `Column` for a six-field form?
6. **(debugging)** Your form shows every field's error message the instant the screen opens, before the user has typed anything. Which setting causes this, and what should you use instead?
7. **(concept)** You create three `FocusNode`s and four `TextEditingController`s in your form's State. What must you do with them, where, and why?

---

## Answers & explanations

1. Returning a **`String`** means the field is **invalid** — and that string is shown in red under the field automatically. Returning **`null`** means the field is **valid**. `null` means valid — it reads as "what's wrong here? nothing." (Lesson 12.2.)
2. It runs **every** field's `validator`, shows each failing field's message in place, and returns `true` **only if all of them returned `null`**. One call checks the whole form — no per-field bookkeeping. (Lessons 12.1–12.2.)
3. The validator compares `value` to `_confirmController.text` — but `value` **is** the confirm field's text, so it's comparing the field to itself, which always matches. It must compare to `_passwordController.text` — a **cross-field** check. (Lesson 12.3.)
4. A `Checkbox` is **not a `FormField`** — the `Form` doesn't know it exists, so `validate()` ignores it. Enforce it by checking the bool **yourself** in submit (`if (!validate() || !_agreed) return;`) and giving your own feedback, e.g. a `SnackBar`. (Lesson 12.4.)
5. A `Column` can't scroll and **overflows** once six fields plus a raised keyboard exceed the screen. A `ListView` scrolls, so all fields stay reachable and the keyboard doesn't cause an overflow. (Lesson 12.7.)
6. `AutovalidateMode.always` validates constantly, including on an empty untouched form. Use **`AutovalidateMode.disabled`** to start (silent), then switch to **`AutovalidateMode.onUserInteraction`** after the first failed submit — silent, then helpful. (Lesson 12.5.)
7. **Dispose** all of them in the widget's `dispose()` method, because you created long-lived objects and must release them (same rule as controllers in Module 9). Skipping it leaks resources. (Lessons 12.5, 12.7.)
