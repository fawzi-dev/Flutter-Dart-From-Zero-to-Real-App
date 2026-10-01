/// What a valid form produces. Nothing here knows about widgets — it is the
/// Module 5 data-class recipe, holding the answers.
class RecipeDraft {
  final String name;
  final int prepMinutes;
  final int totalMinutes;
  final int servings;
  final String difficulty;
  final bool isVegetarian;

  RecipeDraft({
    required this.name,
    required this.prepMinutes,
    required this.totalMinutes,
    required this.servings,
    required this.difficulty,
    required this.isVegetarian,
  });

  /// Derived, not stored — so it can never disagree with the two times.
  int get cookMinutes => totalMinutes - prepMinutes;
}
