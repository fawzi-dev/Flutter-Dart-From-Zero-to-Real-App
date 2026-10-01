import 'package:flutter/material.dart';

/// A tiny design system. Naming every colour once, in one shared file used
/// across screens and widgets, is what keeps the whole app looking coherent —
/// and it's a good example of WHY multi-file organization helps: this lives in
/// one place and everything imports it.
class AppColors {
  static const background = Color(0xFFF6F7FB);
  static const card = Colors.white;
  static const accent = Color(0xFF22C55E); // emerald
  static const ink = Color(0xFF1A1D2E);
  static const muted = Color(0xFF9AA0B4);
  static const track = Color(0xFFE6E8F0); // the empty part of the progress bar
}
