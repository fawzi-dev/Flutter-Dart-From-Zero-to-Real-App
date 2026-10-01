// Module 4 project — Quiz Engine v1 (parallel lists — DELIBERATELY flawed)
// Matches solution video 4.7. Module 5 fixes the flaw with a class.
//
// Run it with:  dart run
//
// The flaw to notice: the question and its answer live in TWO separate lists,
// linked only by position. Sort one, insert into one, and the quiz silently
// starts marking the wrong answers. Hold that thought until Module 5.

import 'dart:io';

/// Ask a yes/no question and return true for yes.
bool askYesNo(String prompt) {
  stdout.write('$prompt (true/false): ');
  final answer = (stdin.readLineSync() ?? '').trim().toLowerCase();
  return answer == 'true' || answer == 't' || answer == 'yes' || answer == 'y';
}

void main() {
  // Two lists that MUST stay in the same order. Nothing enforces that.
  final questions = [
    'Dart is developed by Google.',
    'A List index starts at 1.',
    'Flutter can build iOS and Android from one codebase.',
    'In Dart, 5 / 2 gives exactly 2.',
  ];
  final answers = [true, false, true, false];

  print('--- Quiz Engine v1 ---');
  print('Answer each with true or false.\n');

  var score = 0;

  for (var i = 0; i < questions.length; i++) {
    final given = askYesNo('Q${i + 1}. ${questions[i]}');

    if (given == answers[i]) {
      print('Correct!\n');
      score++;
    } else {
      print('Wrong — the answer was ${answers[i]}.\n');
    }
  }

  final percent = score / questions.length * 100;
  print('You scored $score/${questions.length} (${percent.toStringAsFixed(0)}%)');
}
