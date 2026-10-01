# Flutter & Dart Course Resources

Everything you need alongside the videos of **Flutter & Dart: From Zero to a
Real App** — the challenge briefs, the projects you start from, and the
finished code to check yourself against.

You don't need to read this repo front to back. Each video tells you which
folder to open.

## What's in here

| Folder | What it is | When you use it |
|---|---|---|
| [`challenges/`](challenges/) | The brief for every challenge, plus a cheatsheet for most modules | When a video ends with a challenge |
| [`starter-projects/`](starter-projects/) | The project you open before you start building | At the start of a lesson or challenge that uses one |
| [`complete-projects/`](complete-projects/) | The finished code for every project, with `steps/` snapshots | After you've tried it yourself |

## Getting started

1. **Install Flutter.** Follow [docs.flutter.dev/get-started](https://docs.flutter.dev/get-started).
   The course is recorded on Flutter **3.44.7**. A newer version will almost
   always work too.
2. **Download this repo.** Either clone it:

   ```
   git clone https://github.com/fawzi-dev/Flutter-Dart-From-Zero-to-Real-App.git
   ```

   or use **Code → Download ZIP** on GitHub and unzip it.
3. **Open one project at a time.** In VS Code, open the project's own folder —
   for example `starter-projects/module-09/state-playground` — not the whole
   repo.
4. **Run it.** From that project's folder:

   ```
   flutter pub get
   flutter run
   ```

   Console projects (Modules 1–6) run with `dart run` instead.

## How to use the three folders

**Starter projects** take care of setup so you can spend your time on what the
lesson teaches: colours, images and the parts a lesson isn't about are already
there. Everything the lesson teaches, you type.

**Challenges** give you the requirements, not the steps. Give yourself the time
the brief suggests before you look at the solution. Getting stuck and then
getting unstuck is how the learning happens.

**Complete projects** are for comparing, not copying. When your code won't
work, open the same file in the finished project and find the difference. Most
Flutter projects have a `steps/` folder too. Each file in it is `lib/main.dart`
as it stood at the end of one lesson, so if you fall behind you can copy that
file over yours and carry on from there.

## The course, module by module

| Module | Topic | Challenge |
|---|---|---|
| 0 | Welcome & your first taste of Flutter | — |
| 1 | Dart basics: variables, types & your first program | Tip calculator |
| 2 | Making decisions & repeating work | Guessing game |
| 3 | Functions | Refactor the guessing game |
| 4 | Lists & maps | Quiz engine v1 |
| 5 | Classes, objects & null safety | Quiz engine v2 |
| 6 | Dart capstone | Expense tracker |
| 7 | Hello Flutter: widgets & your first app | About Me card |
| 8 | Layouts: rows, columns & where things go | Dicee UI |
| 9 | State: making apps respond | BMI calculator |
| 10 | Lists & navigation | Shopping list |
| 11 | Async & APIs: talking to the internet | Weather Now |
| 12 | Forms & validation | Sign-up form |
| 13 | Responsive layout & dark mode | Adaptive gallery |
| 14 | Foundation capstone | My Day |
| 15 | Bonus: making data last (local storage) | Persist My Day |
| 16 | Bonus: Firebase | Cloud favourites |

## When something won't run

- **Run `flutter doctor`** and fix anything it marks with a red cross.
- **Run `flutter pub get`** in the project folder. Most "package not found"
  errors are this.
- **Make sure you opened the project's own folder**, the one with
  `pubspec.yaml` in it, and not the whole repo.
- **Compare with the complete project.** Open the same file in
  `complete-projects/` and look for the difference.
- **Module 16 needs a Firebase project of your own.** The steps are in
  `complete-projects/module-16/my-day-cloud/README.md`, and the errors people
  usually hit are in `challenges/module-16/troubleshooting.md`.
