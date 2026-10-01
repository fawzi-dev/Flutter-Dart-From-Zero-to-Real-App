// Module 14 — your first tests (lesson 14.9).
//
// These test the app's PURE FUNCTIONS — the ones with no widgets, that take a
// value and return a value. That's exactly why we kept logic in plain functions
// all course: a pure function is the easiest thing in the world to test.
//
// Run them with:  flutter test

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_day/app_colors.dart';
import 'package:my_day/models/task.dart';

void main() {
  group('colorForPriority', () {
    test('high is red', () {
      expect(colorForPriority(Priority.high), Colors.red);
    });

    test('medium is orange', () {
      expect(colorForPriority(Priority.medium), Colors.orange);
    });

    test('low is green', () {
      expect(colorForPriority(Priority.low), Colors.green);
    });
  });

  group('friendlyDate', () {
    test('includes the month name and the day number', () {
      final text = friendlyDate(DateTime(2026, 7, 15));
      expect(text, contains('July'));
      expect(text, contains('15'));
    });

    test('names the weekday correctly', () {
      // 1 January 2024 was a Monday — a fixed historical fact, so it makes a
      // safe, unchanging assertion.
      expect(friendlyDate(DateTime(2024, 1, 1)), startsWith('Monday'));
    });
  });
}
