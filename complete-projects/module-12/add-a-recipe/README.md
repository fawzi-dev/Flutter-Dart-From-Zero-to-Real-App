# Add a Recipe — the Module 12 lesson project

The form built in the videos across lessons 12.2 → 12.5. It's the form behind
the recipe card from Module 7, so it should look familiar.

```
flutter pub get
flutter run
```

## What each video adds

| Lesson | The form gains |
|--------|----------------|
| 12.1 · Why forms | Nothing — the fragile five-error-strings version, shown as the problem |
| 12.2 · Form & TextFormField | `Form`, `_formKey`, one field, one validator, one `validate()` |
| 12.3 · Validators | Prep and total time, servings — and total time depending on **prep** |
| 12.4 · The input family | The difficulty dropdown, and the checkbox that **isn't** a form field |
| 12.5 · Focus & submit | Keyboard types, focus traversal, `dispose`, silent-then-live submit |

## Why a recipe form and not a sign-up form

The recipe form exercises all six ideas the sign-up challenge needs, on
completely different fields, so the challenge is still a real build.

## The four things worth pausing on

**The cross-field validator.** `_totalTime` reads `_prepController.text`. A
validator is ordinary Dart, so a field's rule can depend on any other field.
Submit with prep 20 and total 10 and **only the total complains** — which is
correct: prep 20 is fine on its own; it's the total that's wrong about it.

That's the same trick as "the two passwords must match", which is what the
challenge needs. Same shape, different pair.

**The checkbox trap.** `validate()` returns `true` with the box unticked,
because a `CheckboxListTile` is not a form field. `_submit` has to check
`_hasCookedIt` by hand. This is the single most-missed rubric line in the
challenge, and there's a test for it here.

**Two guards on every number.** `int.tryParse` catches *"that isn't a number"*;
the range check catches *"that is a number, and it's ridiculous"*. Beginners
write the first and ship the second bug — the same lesson as Module 9's sleep
timer.

**Silent, then live.** `_autovalidate` starts `disabled` and flips to
`onUserInteraction` on the first failed submit. Never `always` — that yells at
an empty form before the user has typed anything.

## Two details worth copying

`cookMinutes` on `RecipeDraft` is **derived** (`total - prep`), not stored, so
it can never disagree with the two times it comes from.

The form's body is a `ListView`, not a `Column`. A `Column` of six fields
overflows the moment the keyboard opens — lesson 8.5, met again in the wild.

## Scope

No packages, no network, no storage. The saved recipe lives as long as the
route does.
