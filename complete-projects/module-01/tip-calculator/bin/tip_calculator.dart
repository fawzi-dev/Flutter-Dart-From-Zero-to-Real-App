// Module 1 project — Tip Calculator (interactive console)
// Matches solution video 1.8 and challenge-solutions/module-01/tip-calculator.md
//
// Run it with:  dart run
//
// New in Module 1: the program ASKS. Two pieces do it every time —
//   stdout.write(...)           print a prompt with NO newline after it
//   stdin.readLineSync() ?? ''  read the line the user typed
// Treat `?? ''` as a recipe for now: "if nothing came back, use empty text".
// Lesson 5.5 explains exactly what it is and why it has to be there.

import 'dart:io';

void main() {
  print('--- Tip Calculator ---');

  stdout.write('Bill amount: ');
  final bill = double.parse(stdin.readLineSync() ?? '');

  stdout.write('Tip percent: ');
  final tipPercent = int.parse(stdin.readLineSync() ?? '');

  stdout.write('Split between how many people? ');
  final people = int.parse(stdin.readLineSync() ?? '');

  // The math — everything computed, nothing hardcoded
  final tip = bill * tipPercent / 100;
  final total = bill + tip;
  final perPerson = total / people;

  // The receipt
  print('');
  print('--- Dinner Receipt ---');
  print('Bill:      \$${bill.toStringAsFixed(2)}');
  print('Tip ($tipPercent%): \$${tip.toStringAsFixed(2)}');
  print('Total:     \$${total.toStringAsFixed(2)}');
  print('Per person ($people people): \$${perPerson.toStringAsFixed(2)}');
}
