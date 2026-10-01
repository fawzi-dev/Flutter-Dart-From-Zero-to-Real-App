# Assets

- `shakshuka.jpg` — the dish photo, shown above the title with `BoxFit.cover`.
- `cook.jpg` — the cook, shown in a `CircleAvatar` at the bottom of the card.

Declared in `pubspec.yaml` as a whole folder:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/
```

`assets:` is indented exactly two spaces under `flutter:`; the list entry gets
two more spaces and a dash. Spaces only — never tabs. When an image "just will
not load," this is the first thing to check, and it is the answer roughly nine
times out of ten.
