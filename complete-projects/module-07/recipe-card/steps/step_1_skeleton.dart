// End of lesson 7.8 — "Writing Your Own Widget".
//
// Written from an empty file. A Scaffold, an app bar, the dish name, and one
// widget of our own used three times. No styling yet: everything here is the
// default size, the default weight, the default grey. That is on purpose —
// 7.8 is where it starts looking designed.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Kitchen')),
        body: const Center(child: RecipeCard()),
      ),
    );
  }
}

/// Extracted from the Column with the IDE's "Extract Widget" refactor.
/// The screen looked identical afterwards — behaviour unchanged, structure
/// improved. That is the whole demonstration.
class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Shakshuka'),
        Text('Breakfast · 20 minutes'),
        IngredientLine(amount: '4', item: 'eggs'),
        IngredientLine(amount: '1 tin', item: 'chopped tomatoes'),
        IngredientLine(amount: '½', item: 'onion, sliced'),
      ],
    );
  }
}

/// A class with constructor parameters that knows how to draw itself.
/// That is what a custom widget IS.
class IngredientLine extends StatelessWidget {
  const IngredientLine({super.key, required this.amount, required this.item});

  final String amount;
  final String item;

  @override
  Widget build(BuildContext context) {
    return Text('$amount   $item');
  }
}
