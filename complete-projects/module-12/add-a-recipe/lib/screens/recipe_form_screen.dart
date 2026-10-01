import 'package:flutter/material.dart';

import '../models/recipe_draft.dart';
import 'recipe_done_screen.dart';

/// The Add a Recipe form — the project Module 12 builds.
///
/// Six inputs, one `validate()` call. Every rule lives next to the field it
/// judges; nothing here keeps a list of error strings.
class RecipeFormScreen extends StatefulWidget {
  const RecipeFormScreen({super.key});

  @override
  State<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  // One handle to the whole form. A controller is your handle to one field;
  // this key is your handle to all of them.
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  // The prep field keeps a controller not for its own sake, but so the TOTAL
  // field's validator can read it. That's the cross-field trick.
  final _prepController = TextEditingController();
  final _totalController = TextEditingController();
  final _servingsController = TextEditingController();

  final _prepFocus = FocusNode();
  final _totalFocus = FocusNode();
  final _servingsFocus = FocusNode();

  String? _difficulty;
  bool _hasCookedIt = false;
  bool _isVegetarian = false;

  // Silent until the first failed Submit, then live. Never `always` — that
  // yells at an empty form before the user has done anything.
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void dispose() {
    // Every controller and every focus node you create, you dispose.
    _nameController.dispose();
    _prepController.dispose();
    _totalController.dispose();
    _servingsController.dispose();
    _prepFocus.dispose();
    _totalFocus.dispose();
    _servingsFocus.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------- validators --

  String? _requiredName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter a dish name';
    if (value.trim().length < 3) return 'A bit longer than that';
    return null;
  }

  /// Two guards, not one. The first catches "that isn't a number"; the second
  /// catches "that is a number, and it's ridiculous".
  String? _minutes(String? value) {
    final minutes = int.tryParse(value ?? '');
    if (minutes == null) return 'Minutes, as a number';
    if (minutes < 1 || minutes > 600) return 'Somewhere between 1 and 600';
    return null;
  }

  /// A field whose rule depends on ANOTHER field. A validator is ordinary
  /// Dart, so it can read whatever it likes — here, the prep controller.
  String? _totalTime(String? value) {
    final basic = _minutes(value);
    if (basic != null) return basic;

    final total = int.parse(value!);
    final prep = int.tryParse(_prepController.text) ?? 0;
    if (total < prep) return "Total can't be less than prep time";
    return null;
  }

  String? _servings(String? value) {
    final servings = int.tryParse(value ?? '');
    if (servings == null) return 'Servings, as a number';
    if (servings < 1 || servings > 20) return 'Between 1 and 20';
    return null;
  }

  // -------------------------------------------------------------- submit --

  void _submit() {
    // ONE call checks all five form fields and lights up every failure.
    final formValid = _formKey.currentState!.validate();

    // The checkbox is NOT a form field, so validate() knows nothing about it.
    // It has to be checked by hand — this is the trap the module exists for.
    if (!formValid || !_hasCookedIt) {
      setState(() => _autovalidate = AutovalidateMode.onUserInteraction);

      if (formValid && !_hasCookedIt) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please confirm you have cooked this.'),
          ),
        );
      }
      return;
    }

    final draft = RecipeDraft(
      name: _nameController.text.trim(),
      prepMinutes: int.parse(_prepController.text),
      totalMinutes: int.parse(_totalController.text),
      servings: int.parse(_servingsController.text),
      difficulty: _difficulty!,
      isVegetarian: _isVegetarian,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeDoneScreen(recipe: draft)),
    );
  }

  // --------------------------------------------------------------- build --

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a recipe')),
      body: Form(
        key: _formKey,
        autovalidateMode: _autovalidate,
        // ListView, not Column — a form has to survive the keyboard opening.
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _prepFocus.requestFocus(),
              decoration: const InputDecoration(
                labelText: 'Dish name',
                border: OutlineInputBorder(),
              ),
              validator: _requiredName,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _prepController,
              focusNode: _prepFocus,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _totalFocus.requestFocus(),
              decoration: const InputDecoration(
                labelText: 'Prep time (minutes)',
                border: OutlineInputBorder(),
              ),
              validator: _minutes,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _totalController,
              focusNode: _totalFocus,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _servingsFocus.requestFocus(),
              decoration: const InputDecoration(
                labelText: 'Total time (minutes)',
                border: OutlineInputBorder(),
              ),
              validator: _totalTime,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _servingsController,
              focusNode: _servingsFocus,
              keyboardType: TextInputType.number,
              // The last field says "done" and submits.
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              decoration: const InputDecoration(
                labelText: 'Servings',
                border: OutlineInputBorder(),
              ),
              validator: _servings,
            ),
            const SizedBox(height: 16),

            // A dropdown that validates WITH the form, because it is a form
            // field. Compare with the checkbox below.
            DropdownButtonFormField<String>(
              initialValue: _difficulty,
              decoration: const InputDecoration(
                labelText: 'Difficulty',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Easy', child: Text('Easy')),
                DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                DropdownMenuItem(value: 'Hard', child: Text('Hard')),
              ],
              onChanged: (value) => setState(() => _difficulty = value),
              validator: (value) =>
                  value == null ? 'Please pick a difficulty' : null,
            ),
            const SizedBox(height: 8),

            // NOT a form field. validate() returns true with this unticked,
            // which is exactly why submit() checks it by hand.
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('I have actually cooked this'),
              value: _hasCookedIt,
              onChanged: (v) => setState(() => _hasCookedIt = v ?? false),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Vegetarian'),
              value: _isVegetarian,
              onChanged: (v) => setState(() => _isVegetarian = v),
            ),
            const SizedBox(height: 16),

            FilledButton(
              onPressed: _submit,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Save recipe'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
