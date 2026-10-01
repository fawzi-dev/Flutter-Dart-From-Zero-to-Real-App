# Quote of the Day — the Module 11 lesson project

The app built in the videos across lessons 11.1 → 11.5.

```
flutter pub get
flutter run
```

**The one test that matters:** turn the wi-fi off and launch it. A friendly
message and a working Retry — no crash, no blank screen. Turn it back on, tap
Retry, and a quote appears.

## What each video adds

| Lesson | The app gains |
|--------|---------------|
| 11.1 · Why apps must wait | A button that freezes the app for four seconds, on purpose |
| 11.2 · Future, async, await | The same wait, and the app stays alive; `if (!mounted) return;` |
| 11.3 · APIs | `http`, a real request, a status code, and the raw body on screen |
| 11.4 · JSON to Dart | `jsonDecode`, then `Quote.fromJson`, then `QuoteService` — the line past which JSON stops existing |
| 11.5 · Loading, error, data | `initState`, the spinner, `try`/`catch`, the error face with Retry, and pull-to-refresh |

`steps/README.md` maps every snapshot to its lesson.

## API

`https://dummyjson.com/quotes/random` — keyless, no signup.

```json
{ "id": 619, "quote": "The best way out is always through.", "author": "Robert Frost" }
```

## Why quotes and not weather

Quotes teach every mechanic Weather Now needs, and leave the challenge's real
work for you. Weather Now still has to invent:

- **two chained calls** — geocode a city name, then feed the coordinates to the forecast
- **parallel arrays** parsed into a `List<HourForecast>` with a `for` loop
- a named **`CityNotFoundException`** and a `catch` that treats it differently
- a **sky gradient derived** from the weather code

None of that is here.

## Two things worth pausing on

**The service is the boundary.** No screen in this project imports `http` or
`dart:convert`. `QuoteService` is the only file that knows a network exists,
and `Quote.fromJson` is the only place a string like `'author'` appears. That's
a rubric line in the challenge.

**`if (!mounted) return;` after every `await`.** A slow request can come back
after the user has left the screen, and calling `setState` then is a crash.
One line, and it's the single most common async bug in student projects.

## The tests

`test/widget_test.dart` proves the offline behaviour without being offline.
`MockClient` comes with the `http` package, and `http.runWithClient` makes
every plain `http.get` inside it talk to a fake server instead of the internet.
So the airplane-mode test runs on every machine, every time:

```
flutter test
```
