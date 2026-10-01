// Lesson 11.2 P2 -- "await Pauses a Function, Not the App". Paste into
// DartPad, or:
//   dart run examples/lesson_02_p2_order.dart
//
// Run it as it is: main does NOT await cook(), so main carries on reading
// the menu while the kitchen works.
//
//   Order placed
//   Kitchen: started
//   Reading the menu
//   Kitchen: done
//
// Then put `await` in front of cook() and run it again. Now main waits:
//
//   Order placed
//   Kitchen: started
//   Kitchen: done
//   Reading the menu
//
// Same code, one word, different order. await pauses the function it is
// written in -- nothing else.

// ignore_for_file: avoid_print

Future<void> cook() async {
  print('Kitchen: started');
  await Future.delayed(const Duration(seconds: 2));
  print('Kitchen: done');
}

Future<void> main() async {
  print('Order placed');
  cook();
  print('Reading the menu');
}
