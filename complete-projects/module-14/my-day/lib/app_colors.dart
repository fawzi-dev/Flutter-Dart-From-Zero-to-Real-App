import 'package:flutter/material.dart';

/// A tiny design system — every colour named once.
class AppColors {
  static const background = Color(0xFFF3F4FA);
  static const card = Colors.white;
  static const primary = Color(0xFF5B67F0); // indigo
  static const ink = Color(0xFF1A1D2E);
  static const muted = Color(0xFF9AA0B4);
}

/// Formats a date like "Wednesday, 23 July" without adding a package —
/// just two lookup lists and the DateTime's own numbers.
String friendlyDate(DateTime d) {
  const weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  // DateTime.weekday is 1..7 (Mon..Sun); month is 1..12. Subtract 1 to index.
  return '${weekdays[d.weekday - 1]}, ${d.day} ${months[d.month - 1]}';
}
