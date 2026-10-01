// Add a Recipe — the project you build across Module 12.
//
// The form behind the recipe card from Module 7. Six inputs, one validate()
// call, and every rule sitting next to the field it judges.
//
//   12.2  Form + _formKey + one TextFormField
//   12.3  the validator catalogue, and total-time depending on prep-time
//   12.4  the difficulty dropdown, and the checkbox that ISN'T a form field
//   12.5  keyboard types, focus traversal, dispose, silent-then-live submit

import 'package:flutter/material.dart';

import 'screens/recipe_form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Add a recipe',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFFB3341F),
        useMaterial3: true,
      ),
      home: const RecipeFormScreen(),
    );
  }
}
