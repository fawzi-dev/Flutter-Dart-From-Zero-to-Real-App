// Module 3 project — The Guessing Game, v2 (functions)
// Matches solution video 3.9. Same game as module-02, zero logic in main.
//
// Run it with:  dart run
//
// THE PAYOFF: in v1 you typed these three lines every single time you wanted
// a number from the user:
//     stdout.write(prompt);
//     final text = stdin.readLineSync() ?? '';
//     final value = int.parse(text);
// Here that becomes ONE named thing — askInt(...) — written once, used
// everywhere. That is the whole argument for functions, in your own code.

import 'dart:io';
import 'dart:math';

/// Ask the user something and return their answer as a number.
int askInt(String prompt) {
  stdout.write(prompt);
  return int.parse(stdin.readLineSync() ?? '');
}

int pickSecret() => Random().nextInt(100) + 1;

/// "Answers a question" — it reports, it doesn't print. Lesson 3.2.
bool isValid(int guess) => guess >= 1 && guess <= 100;

/// "Does something" — it prints, it doesn't answer.
void reportGuess(int guess, int secret) {
  if (guess < secret) {
    print('Too low!');
  } else {
    print('Too high!');
  }
}

void playRound(int secret) {
  var attempts = 0;

  while (true) {
    final guess = askInt('Your guess: ');
    attempts++;

    if (!isValid(guess)) {
      print('That is outside 1-100. Try again.');
      continue;
    }

    if (guess == secret) {
      print('Got it! The number was $secret. It took you $attempts guesses.');
      return;
    }

    reportGuess(guess, secret);
  }
}

// main() now reads like a table of contents.
void main() {
  print('--- Guess My Number ---');
  print("I'm thinking of a number between 1 and 100.");
  playRound(pickSecret());
}
