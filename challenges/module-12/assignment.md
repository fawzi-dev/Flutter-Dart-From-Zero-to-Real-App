# Module 12 Assignment — Add-a-Contact Form

**Independent practice (Level 2).** The Form system on a small, fresh form — no sign-up boilerplate to hide behind.

## Brief
One screen: a form to add a contact, with a "Save" button. On save, navigate to a screen that displays the contact you just entered. Four inputs, real validation.

## The fields
1. **Name** — required
2. **Phone** — required, digits only (numeric keyboard)
3. **Email** — optional, but if filled it must be shaped like an email
4. **Favorite** — a `Switch` ("mark as favorite")

## Requirements
1. A real `Form` + `GlobalKey<FormState>`; each text field a `TextFormField` with its own `validator`; one `validate()` call on Save.
2. The **optional email** is the interesting rule: empty is *valid*, but a non-empty value must match the email pattern. (An early `if (text.isEmpty) return null;` before the pattern check.)
3. Correct `keyboardType` per field (`TextInputType.phone` for phone, `emailAddress` for email) and `FocusNode` flow between the text fields. Dispose everything.
4. On success, `Navigator.push` to a screen showing the name, phone, email (or "—" if blank), and whether it's a favorite.

## Rubric
- [ ] One `validate()` call checks the whole form
- [ ] Empty email passes; a malformed non-empty email fails (the optional-but-validated rule)
- [ ] Phone shows a numeric keyboard; focus flows field to field
- [ ] Every controller and focus node disposed
- [ ] Valid form navigates and displays the entered data

## Difficulty
**Level 2 — Independent.** Extension (**Level 3**): make it a list — keep the saved contacts in a `List` on a home screen (Module 10), and let this form *add* to it, returning the new contact via `Navigator.pop(context, contact)`.

⏱️ Minimum 75 minutes.
