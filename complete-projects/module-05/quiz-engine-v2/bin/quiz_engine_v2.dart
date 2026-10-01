// Module 5 project — Quiz Engine v2 (classes)
// Matches solution video 5.8. Compare with module-04's parallel lists.
//
// Run it with:  dart run
//
// The fix: one object holds a question AND its answer, so they can never
// drift apart. Question(text: ..., answer: ...) is one rename away from a
// Flutter widget constructor — you will see that in Module 7.

import 'dart:io';

class Question {
  final String text;
  final bool answer;

  Question({required this.text, required this.answer});
}

/// The Quiz owns the questions AND the scoring. Behaviour lives with data.
class Quiz {
  final List<Question> questions;
  int score = 0;

  Quiz({required this.questions});

  int get total => questions.length;
  double get percent => total == 0 ? 0 : score / total * 100;

  void check(Question question, bool given) {
    if (given == question.answer) {
      print('Correct!\n');
      score++;
    } else {
      print('Wrong — the answer was ${question.answer}.\n');
    }
  }
}

bool askYesNo(String prompt) {
  stdout.write('$prompt (true/false): ');
  final answer = (stdin.readLineSync() ?? '').trim().toLowerCase();
  return answer == 'true' || answer == 't' || answer == 'yes' || answer == 'y';
}

void main() {
  final quiz = Quiz(
    questions: [
      Question(text: 'Dart is developed by Google.', answer: true),
      Question(text: 'A List index starts at 1.', answer: false),
      Question(
        text: 'Flutter can build iOS and Android from one codebase.',
        answer: true,
      ),
      Question(text: 'In Dart, 5 / 2 gives exactly 2.', answer: false),
    ],
  );

  print('--- Quiz Engine v2 ---');
  print('Answer each with true or false.\n');

  var number = 1;
  for (final question in quiz.questions) {
    final given = askYesNo('Q$number. ${question.text}');
    quiz.check(question, given);
    number++;
  }

  print('You scored ${quiz.score}/${quiz.total} '
      '(${quiz.percent.toStringAsFixed(0)}%)');
}
