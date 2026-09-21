# Challenge 2 — Fix the Bugs (error-reading practice)

Five broken programs. For each one: **read the error, find the line, fix it** — then write one line in your bug journal (what it said → what it was). Programs 4 and 5 produce errors you haven't seen in the videos. That's on purpose: the ritual works on errors you've never met. Read. Locate. Compare.

### Bug 1

```dart
void main() {
  final city = 'Hawler'
  print('I live in $city');
}
```

### Bug 2

```dart
void main() {
  final temperature = 28;
  print('It is $temprature degrees today');
}
```

### Bug 3

```dart
void main() {
  int stars = 4;
  stars = stars + 0.5;
  print('Rating: $stars');
}
```

### Bug 4

```dart
void main() {
  final message = 'Let's learn Dart';
  print(message);
}
```

### Bug 5

```dart
void main() {
  final price = 19.99;
  print('Total: $price')
```

_(Hint for #5 only: count the closing braces… and check the end of the print line.)_

**Difficulty:** Level 1 — Guided. The steps are spelled out; follow along and fix/build as you go.
