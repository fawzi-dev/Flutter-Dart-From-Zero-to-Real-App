/// One person. Three facts — which in Dart means a class (Module 5).
///
/// `name` and `phone` are final; `favourite` is not, because it is the one
/// that changes when you tap the star. Lesson 5.2's rule, unchanged:
/// final by default, mutable when the thing genuinely changes.
class Contact {
  final String name;
  final String phone;
  bool favourite;

  Contact({
    required this.name,
    required this.phone,
    this.favourite = false,
  });

  /// The letter in the avatar circle. A tiny bit of display logic that
  /// belongs to the data, not to a widget.
  String get initial => name.isEmpty ? '?' : name[0].toUpperCase();
}
