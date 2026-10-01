// Module 2 project — The Guessing Game, v1 (interactive console)
// Matches solution video 2.9. Refactored into functions in module-03.
//
// Run it with:  dart run
//
// Now that a program can ask, this is the REAL game: the computer picks,
// YOU guess, and the loop repeats until you get it. That is exactly what
// `while` exists for — repeating an unknown number of times.

import 'dart:io';
import 'dart:math';

void main() {
  final secret = Random().nextInt(100) + 1;
  var attempts = 0;

  print('--- Guess My Number ---');
  print("I'm thinking of a number between 1 and 100.");

  while (true) {
    stdout.write('Your guess: ');
    final guess = int.parse(stdin.readLineSync() ?? '');
    attempts++;

    if (guess < 1 || guess > 100) {
      print('That is outside 1-100. Try again.');
      continue; // skip the rest of this pass, go straight back to asking
    }

    if (guess == secret) {
      print('Got it! The number was $secret. It took you $attempts guesses.');
      break; // the only way out of `while (true)`
    } else if (guess < secret) {
      print('Too low!');
    } else {
      print('Too high!');
    }
  }
}
