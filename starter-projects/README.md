# Starter Projects

Minimal skeletons students open before each Flutter challenge. **The student types the code — the starter only removes setup friction.**

## The anti-80% rule

Every starter is a **complete, runnable Flutter project** created with `flutter create` (Android + iOS platform folders included) — `flutter pub get && flutter run` must work with zero errors on a fresh clone. But the *Dart code* the student sees is minimal:
1. `pubspec.yaml` — name, pinned SDK, assets and packages already declared (nobody loses an hour to YAML indentation)
2. `assets/` — images/fonts the project needs
3. `lib/main.dart` — **~20 lines**: imports, `main()`, one empty `Scaffold`, and `// TODO` comments naming what to build
4. `README.md` — the mission, the challenge-file link, run instructions
5. `android/` + `ios/` — untouched `flutter create` output (no `test/` folder — starters ship without tests)

**Never** prebuilt widgets to "fill in", **never** helper functions, **never** commented-out answers. If a starter grows past 30 lines of Dart, it's doing the student's work — cut it.

**Quality gate for every starter:** `flutter analyze` reports zero issues, `flutter run` boots to the empty TODO scaffold on a device. The profile and dice assets are already real; the remaining recording-gate asset is the My Day app icon.

## The template `main.dart`

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        // TODO: build the About Me card here.
        // Target screenshot: see README.md
      ),
    );
  }
}
```

## Starters in this course

| Folder | Module | Notes |
|---|---|---|
| `module-07/about-me-card/` | 7 | assets: profile photo |
| `module-08/dicee/` | 8–9 | assets: dice1–6 images |
| `module-09/bmi-calculator/` | 9 | plain template |
| `module-10/shopping-list/` | 10 | plain template |
| `module-11/weather-now/` | 11 | `http` pre-added in pubspec |
| `module-12/signup-form/` | 12 | themed `MaterialApp` shell |
| `module-13/adaptive-gallery/` | 13 | themed `MaterialApp` shell |
| `module-14/my-day/` | 14 | app icon assets only |
| `module-15/my-day-local/` | 15 | **exception (like M16):** the COMPLETE My Day app — the module adds local storage to an app you already built |
| `module-16/my-day-cloud/` | 16 | **exception:** the COMPLETE My Day app — the module adds Firebase. Students who built Module 14 continue in their own code instead |

Modules 0–6 are Dart console modules: **no starters** — the challenge brief in `challenges/` is the starter, and DartPad is the editor.
