import 'package:flutter/material.dart';

import '../models/recipe_draft.dart';

/// Where a valid form lands. Nothing clever — its whole job is to prove the
/// values arrived, which is the payoff a form needs at the end.
class RecipeDoneScreen extends StatelessWidget {
  const RecipeDoneScreen({super.key, required this.recipe});

  final RecipeDraft recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(Icons.check_circle, size: 64, color: Colors.green),
          const SizedBox(height: 20),
          Text(
            recipe.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _Line(label: 'Prep', value: '${recipe.prepMinutes} min'),
          _Line(label: 'Cook', value: '${recipe.cookMinutes} min'),
          _Line(label: 'Total', value: '${recipe.totalMinutes} min'),
          _Line(label: 'Serves', value: '${recipe.servings}'),
          _Line(label: 'Difficulty', value: recipe.difficulty),
          _Line(
            label: 'Vegetarian',
            value: recipe.isVegetarian ? 'Yes' : 'No',
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
