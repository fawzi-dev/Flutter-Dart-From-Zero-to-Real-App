// Module 6 CAPSTONE — Console Expense Tracker (reference implementation)
// Matches solution videos 6.4–6.8. Grade yourself against the RUBRIC, not this file.
//
// Run it with:  dart run
//
// This is the first program in the course that keeps running until the user
// says stop. That menu loop — show options, read a choice, do the thing,
// repeat — is the shape of nearly every console tool ever written.

import 'dart:io';

/// The five categories this app knows about, and the only five it will accept.
///
/// A String category would let 'food', 'Food' and 'fodo' all be different
/// things. An enum is a fixed menu, so the wrong value cannot be typed at all —
/// lesson 5.4, doing real work on a real project.
enum Category { food, transport, bills, fun, other }

class Expense {
  final String description;
  final double amount;
  final Category category;

  Expense({
    required this.description,
    required this.amount,
    required this.category,
  });
}

class Tracker {
  final List<Expense> expenses = [];

  void add(Expense e) => expenses.add(e);

  double get total => expenses.fold(0.0, (sum, e) => sum + e.amount);

  void printAll() {
    if (expenses.isEmpty) {
      print('No expenses yet.');
      return;
    }
    print('--- Expenses ---');
    for (var i = 0; i < expenses.length; i++) {
      final e = expenses[i];
      print('${i + 1}. ${e.description}  '
          '\$${e.amount.toStringAsFixed(2)}  (${e.category.name})');
    }
    print('Total: \$${total.toStringAsFixed(2)}');
  }

  /// A Map is the right tool: one running total per category.
  /// The keys are Category values now, not Strings — so a typo cannot invent
  /// a sixth category the way 'fodo' silently would have.
  void printByCategory() {
    if (expenses.isEmpty) {
      print('No expenses yet.');
      return;
    }
    final totals = <Category, double>{};
    for (final e in expenses) {
      totals[e.category] = (totals[e.category] ?? 0) + e.amount;
    }
    print('--- By category ---');
    totals.forEach((category, sum) {
      print('${category.name}: \$${sum.toStringAsFixed(2)}');
    });
  }

  void printLargest() {
    if (expenses.isEmpty) {
      print('No expenses yet.');
      return;
    }
    var biggest = expenses.first;
    for (final e in expenses) {
      if (e.amount > biggest.amount) biggest = e;
    }
    print('Largest: ${biggest.description} '
        '(\$${biggest.amount.toStringAsFixed(2)})');
  }
}

// ---- asking the user -------------------------------------------------

String askText(String prompt) {
  stdout.write(prompt);
  return (stdin.readLineSync() ?? '').trim();
}

double askAmount(String prompt) {
  while (true) {
    final text = askText(prompt);
    final value = double.tryParse(text);
    // tryParse returns null when the text isn't a number — so we can ask
    // again instead of crashing. Null safety earning its keep (lesson 5.5).
    if (value != null && value > 0) return value;
    print('Please enter a number greater than zero.');
  }
}

/// Show the categories and let the user pick one by number.
///
/// Category.values is the list of every value in the enum, in order, and it
/// comes free — so adding a sixth category to the enum adds a sixth menu line
/// here with no other change anywhere.
Category askCategory() {
  print('Category:');
  for (var i = 0; i < Category.values.length; i++) {
    print('  ${i + 1}) ${Category.values[i].name}');
  }
  while (true) {
    final choice = int.tryParse(askText('Choose 1-${Category.values.length}: '));
    if (choice != null && choice >= 1 && choice <= Category.values.length) {
      return Category.values[choice - 1];
    }
    print('Please pick a number from the list.');
  }
}

void addExpense(Tracker tracker) {
  final description = askText('Description: ');
  final amount = askAmount('Amount: ');
  final category = askCategory();
  tracker.add(
    Expense(description: description, amount: amount, category: category),
  );
  print('Added.\n');
}

void printMenu() {
  print('');
  print('1) Add expense');
  print('2) List expenses');
  print('3) Totals by category');
  print('4) Largest expense');
  print('5) Quit');
}

void main() {
  final tracker = Tracker();
  print('--- Expense Tracker ---');

  var running = true;
  while (running) {
    printMenu();
    final choice = askText('Choose: ');

    switch (choice) {
      case '1':
        addExpense(tracker);
      case '2':
        tracker.printAll();
      case '3':
        tracker.printByCategory();
      case '4':
        tracker.printLargest();
      case '5':
        running = false;
      default:
        print('Please pick 1-5.');
    }
  }

  print('Bye!');
}
