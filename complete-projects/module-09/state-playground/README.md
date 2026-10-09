# State playground — Module 9

The learning project for Module 9. A few tiny screens and nothing else.

Every new idea in the module that needs a clean screen to be seen on is shown
here first: a button and what `onPressed` waits for, passing a function
without calling it, a screen that will not change, `StatefulWidget` and
`setState`, input that cannot be trusted,
and two inputs that make bad input impossible: a slider and a segmented
button. One idea per screen, nothing on it that you have to read past.

The TextField and controller are taught on the ticket card. The slider and segmented button lead into the ticket booking app in
`../ticket-booking-v2-interactive/`, your BMI calculator in the 9.9 challenge.

```
Learn it here  →  practise it here  →  apply it in a real app.
```

## Running it

```sh
flutter run
```

`lib/main.dart` is the finished state. To go back to any lesson, copy a file
out of `steps/` over `lib/main.dart` — see `steps/README.md` for what each one
covers and the beats for the video it belongs to.

## What is deliberately not here

No theme, no packages, no navigation, no models, no layout to speak of. Each
video adds one screen below the last and points `home:` at it, so the older
screens stay in the file as they were left. If something in this project is
hard to explain in one sentence, it is a bug.
