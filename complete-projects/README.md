# Complete Projects

The finished code for every project in the course — what each app looks like
at the end of its videos.

**Use them to compare, not to copy.** When something in your own project won't
work, open the same file here and diff it against yours. That is the closest a
recorded course gets to someone looking over your shoulder.

For a challenge, try it yourself first. The solution is here, but you only
learn from it after you've been stuck on the problem.

## Running a project

Flutter projects (Module 7 onwards), from the project folder:

```
flutter pub get
flutter run
```

Console projects (Modules 1–6), from the project folder:

```
dart run
```

## Snapshots: `steps/`

Most Flutter projects have a `steps/` folder. Each file in it is `lib/main.dart`
exactly as it stood at the end of one lesson, and `steps/README.md` says which
lesson. If you fall behind, or want to start a lesson from a clean point, copy
that step over your `lib/main.dart`.

A few steps are **broken on purpose** — the bug a lesson is about. Their header
comment says so. Run them anyway: watching the bug happen beats reading about it.

## Projects

| Folder | Module | What it is |
|---|---|---|
| `module-00/day-zero/` | 0 | The app you poke in lesson 0.3 |
| `module-01/tip-calculator/` | 1 | Console |
| `module-02/guessing-game-v1/` | 2 | Console |
| `module-03/guessing-game-v2/` | 3 | Console — v1 refactored into functions; diff against v1 |
| `module-04/quiz-engine-v1/` | 4 | Console — parallel lists, deliberately flawed |
| `module-05/quiz-engine-v2/` | 5 | Console — classes; diff against v1 |
| `module-06/expense-tracker/` | 6 | Console capstone |
| `module-07/recipe-card/` | 7 | The lesson project |
| `module-07/about-me-card/` | 7 | Challenge solution |
| `module-08/layout-playground/` | 8 | The concept lessons, on three coloured cards |
| `module-08/ticket-booking/` | 8 | The lesson project |
| `module-08/dicee-v1-static/` | 8 | Challenge solution — layout only |
| `module-09/state-playground/` | 9 | The concept lessons, one screen per idea |
| `module-09/ticket-booking-v2-interactive/` | 9 | The lesson project — the Module 8 screen, woken up |
| `module-09/dicee-v2-interactive/` | 9 | Lesson 9.4 — your Dicee, rolling; diff against v1 |
| `module-09/bmi-calculator/` | 9 | Challenge solution |
| `module-10/contacts/` | 10 | The lesson project |
| `module-10/shopping-list/` | 10 | Challenge solution |
| `module-11/quote-of-the-day/` | 11 | The lesson project |
| `module-11/weather-now/` | 11 | Challenge solution |
| `module-12/add-a-recipe/` | 12 | The lesson project |
| `module-12/signup-form/` | 12 | Challenge solution |
| `module-13/ticket-booking-v3-adaptive/` | 13 | The lesson project — responsive and themed |
| `module-13/adaptive-gallery/` | 13 | Challenge solution |
| `module-14/my-day/` | 14 | The capstone |
| `module-15/contacts-remembered/` | 15 | The lesson project — Contacts that remembers |
| `module-15/my-day-local/` | 15 | Challenge solution — My Day with local storage |
| `module-16/my-day-cloud/` | 16 | My Day with Firebase |

**`module-16/my-day-cloud` needs setup before it runs.** It needs a
`lib/firebase_options.dart` generated for your own Firebase project. The steps
are in that project's README.
