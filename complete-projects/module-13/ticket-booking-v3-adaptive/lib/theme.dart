import 'package:flutter/material.dart';

/// Both palettes, from one seed colour.
///
/// This file is the whole point of lessons 13.4 and 13.5. Every colour the app
/// draws comes from here by ROLE — `surface`, `onSurface`, `primary` — and no
/// widget in the project contains a hex code or a `Colors.something`.
///
/// Get that right and dark mode is four lines. Get it wrong and dark mode is a
/// week of hunting for `Colors.white` in a haystack.
const seed = Color(0xFFB4453A);

ThemeData lightTheme() => _build(Brightness.light);
ThemeData darkTheme() => _build(Brightness.dark);

ThemeData _build(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: brightness,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
    ),
  );
}

/// The spacing scale, unchanged since Module 8. Four numbers, reused.
const kGapS = 8.0;
const kGapM = 12.0;
const kGapL = 24.0;
const kGapXL = 32.0;

/// The one breakpoint. Below it, phones and phones in portrait; above it,
/// big phones in landscape, tablets, and desktop windows.
const kWideBreakpoint = 600.0;

/// Prices with thousands separators, without a package.
///
/// A loop, a remainder check, and string joining — Modules 1 and 2, doing a
/// small real job.
String money(int amount) {
  final digits = amount.toString();
  var out = '';

  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      out = '$out,';
    }
    out = '$out${digits[i]}';
  }

  return '$out IQD';
}

/// One ticket type: a name and a price. The Module 5 data-class recipe.
class Tier {
  final String name;
  final int price;

  const Tier({required this.name, required this.price});
}

const tiers = [
  Tier(name: 'Standard', price: 35000),
  Tier(name: 'VIP', price: 60000),
  Tier(name: 'Backstage', price: 95000),
];
