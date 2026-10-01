# Starter Projects

The project you open before a lesson or challenge starts. Each one takes care
of setup — packages, images, colours, the parts the lesson isn't about — so
your time goes on what the lesson teaches. **The code the lesson teaches, you
type.**

## Using a starter

Open the starter's own folder in your editor (the one with `pubspec.yaml` in
it), then:

```
flutter pub get
flutter run
```

It should start without errors and show a mostly empty screen. That's correct:
you fill it in.

Keep your work. Several later modules pick up a project you built earlier, and
continuing in your own code is better than switching to a starter.

## Starters in this course

| Folder | Module | What's already there |
|---|---|---|
| `module-07/about-me-card/` | 7 | Your profile photo, wired into `pubspec.yaml` |
| `module-08/layout-playground/` | 8 | `ColorCard`, the colours and the spacing scale — the concept lessons |
| `module-08/ticket-booking/` | 8 | The colours, the spacing scale and `assets/event.jpg` |
| `module-08/dicee/` | 8–9 | The six dice images |
| `module-09/state-playground/` | 9 | One empty screen — the concept lessons |
| `module-09/bmi-calculator/` | 9 | An empty app |
| `module-10/shopping-list/` | 10 | An empty app |
| `module-11/weather-now/` | 11 | The `http` package, already added |
| `module-12/signup-form/` | 12 | A themed, empty app |
| `module-13/adaptive-gallery/` | 13 | A themed, empty app |
| `module-14/my-day/` | 14 | The app icon |
| `module-15/my-day-local/` | 15 | **The finished My Day app.** This module adds storage to an app you already built — or use your own Module 14 code |
| `module-16/my-day-cloud/` | 16 | **The finished My Day app.** This module adds Firebase — or use your own Module 14 code |

Modules 0–6 are Dart console programs, so they have no starters. You create
each one yourself with `dart create`, the way lesson 0.5 shows, and the brief
in `challenges/` tells you what to build.
