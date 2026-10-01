# Layout playground — Module 8

The learning project for Module 8. Three coloured cards and nothing else.

Every layout concept in the module — Row, Column, alignment, spacing,
`Expanded`, `flex`, `Flexible`, overflow, `Stack`, `Positioned` — is taught
here first, on cards boring enough that the only thing you can look at is the
layout property that just changed.

Then, and only then, it goes into the real screen: `../ticket-booking/`.

```
Learn it here  →  practise it here  →  apply it in the ticket booking app.
```

## Running it

```sh
flutter run
```

`lib/main.dart` is the finished state. To go back to any lesson, copy a file
out of `steps/` over `lib/main.dart` — see `steps/README.md` for what each one
covers.

## What is deliberately not here

No state, no packages, no navigation, no architecture, no `onPressed`. One
`StatelessWidget` called `ColorCard`, written once and reused for seven
lessons. If something in this project is hard to explain in one sentence, it
is a bug.
