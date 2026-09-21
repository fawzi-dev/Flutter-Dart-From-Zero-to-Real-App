# Cheat Sheet — Dart (Part A)

One-page reference for everything in Modules 1–6. Keep it open while you code.

## Variables & types
```dart
int count = 3;          double price = 9.99;
String name = 'Sam';    bool isDone = false;
var x = 5;              // type inferred
final title = 'Fixed'; // set once, never reassigned
const pi = 3.14;        // compile-time constant
```

## Numbers
```dart
5 / 2      // 2.5   (double, always)
5 ~/ 2     // 2     (integer division)
17 % 5     // 2     (remainder)
(9.99).toStringAsFixed(2)   // '9.99'
int.parse('42')   double.parse('9.9')
int.tryParse('x') // null instead of crashing
```

## Strings
```dart
'Hello $name'              // insert a value
'Sum: ${a + b}'            // insert an expression
'It\'s'                    // escape a quote
'Price: \$5'               // literal dollar sign
```

## Reading input (local console)
```dart
import 'dart:io';
stdout.write('Name: ');
final line = stdin.readLineSync() ?? '';   // ?? '' : "or empty if nothing"
final n = int.parse(stdin.readLineSync() ?? '');
```

## Control flow
```dart
if (score >= 90) { ... } else if (...) { ... } else { ... }
for (var i = 0; i < 10; i++) { ... }     // known count
for (final item in list) { ... }         // each item
while (condition) { ... }                 // unknown count
break;      // leave the loop
continue;   // skip to the next pass
switch (value) { case 'a': ...; default: ...; }
a && b   a || b   !a           // and / or / not
== != < <= > >=                // comparisons -> bool
cond ? whenTrue : whenFalse    // ternary
```

## Functions
```dart
int add(int a, int b) { return a + b; }
int square(int n) => n * n;                    // arrow (one-liner)
void greet({required String name, int times = 1}) { ... }  // named + default
greet(name: 'Sam');
final f = square;   // a function is a value — pass it (no parens)
```

## Collections
```dart
final xs = <int>[1, 2, 3];
xs.add(4);  xs.remove(2);  xs.length;  xs[0];  xs.contains(3);
xs.isEmpty;  xs.sort();  xs.indexOf(3);
final doubled = xs.map((n) => n * 2).toList();   // don't forget .toList()
final evens   = xs.where((n) => n.isEven).toList();

final ages = <String, int>{'sam': 20};
ages['sam'];  ages['x'] = 9;  ages.containsKey('sam');
ages['k'] = (ages['k'] ?? 0) + 1;   // running total pattern
```

## Classes, enums & null safety
```dart
enum Priority { low, medium, high }

class Task {
  final String title;
  final String? note;          // ? -> may be null
  bool isDone;
  Task({required this.title, this.note, this.isDone = false});
  String describe() => isDone ? '$title (done)' : title;
}

final t = Task(title: 'Write');
String? maybe;
maybe ?? 'default';   // fallback if null
maybe?.length;        // read only if not null
maybe!;               // "I promise it's not null" — LAST resort
```

## Common errors (and what they mean)
- `FormatException` → `parse` got text that isn't a number. Use `tryParse`.
- `RangeError (index)` → asked a list for an index it doesn't have (0-based!).
- `type 'int' is not a subtype of 'double'` → JSON number; use `(x as num).toDouble()`.
- Red squiggle on a nullable → you must handle the `null` before using it.
