// Lesson 11.4 P2 -- the number trap. Run it with:
//   dart run examples/lesson_04_p2_numbers.dart
// NOT in DartPad: on the web every number is secretly a double, so the trap
// hides there. On a phone it doesn't.
//
// JSON has one kind of number. Dart has two. jsonDecode picks for you:
// 9.99 becomes a double, 10 becomes an int -- and `10 as double` throws.
// The quote has no decimals, so this lives here instead of in the app.
// Weather Now needs it for every temperature.

// ignore_for_file: avoid_print

import 'dart:convert';

void main() {
  final monday = jsonDecode('{"price": 9.99}');
  final tuesday = jsonDecode('{"price": 10}');

  print((monday['price'] as num).toDouble());  // 9.99
  print((tuesday['price'] as num).toDouble()); // 10.0

  // The version that works for a week. Uncomment it and run:
  // print(tuesday['price'] as double);
  // type 'int' is not a subtype of type 'double' in type cast
}
