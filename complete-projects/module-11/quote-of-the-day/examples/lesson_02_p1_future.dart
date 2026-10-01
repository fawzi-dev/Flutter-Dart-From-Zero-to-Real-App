// Lesson 11.2 P1 -- "A Value That Arrives Later". Paste into DartPad, or:
//   dart run examples/lesson_02_p1_future.dart
//
// Future<String>  a String -- later. The restaurant buzzer, not the food.
// async           this function contains an await
// await           wait here for the food, without freezing anything else
//
// Then break it on purpose: delete the `await` in main. The program prints
// "Instance of 'Future<String>'" -- you printed the buzzer.

// ignore_for_file: avoid_print

Future<String> fetchGreeting() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Hello from the future!';
}

Future<void> main() async {
  print('Before');
  final greeting = await fetchGreeting();
  print(greeting);
  print('After');
}
