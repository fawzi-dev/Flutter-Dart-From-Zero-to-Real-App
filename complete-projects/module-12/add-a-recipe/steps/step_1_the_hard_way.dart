// End of lesson 12.1 -- "Why Forms Exist".
//
// *** THIS IS THE VERSION THAT DOES NOT SCALE. That is the point. ***
//
// Everything here is Module 9, and everything here works. Five fields, five
// error strings, one giant setState that re-checks all of them, and a return
// condition that ORs every error together.
//
// Now ask the question lesson 12.1 asks: what would it take to add a SIXTH
// field? You edit _submit in three separate places -- a new String, a new
// check, a new clause in the ||. Miss the last one and the form submits with
// bad data, and nobody finds out until a user complains.
//
// Open lib/screens/recipe_form_screen.dart afterwards and count again.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Add a Recipe',
      home: HardWayForm(),
    );
  }
}

class HardWayForm extends StatefulWidget {
  const HardWayForm({super.key});

  @override
  State<HardWayForm> createState() => _HardWayFormState();
}

class _HardWayFormState extends State<HardWayForm> {
  final nameController = TextEditingController();
  final prepController = TextEditingController();
  final totalController = TextEditingController();
  final servesController = TextEditingController();

  // One error field per input. All of them managed by hand.
  String? nameError;
  String? prepError;
  String? totalError;
  String? servesError;
  String? difficultyError;

  String? difficulty;
  bool cooked = false;

  @override
  void dispose() {
    nameController.dispose();
    prepController.dispose();
    totalController.dispose();
    servesController.dispose();
    super.dispose();
  }

  // The method that does not scale. Every rule, in one place, by hand.
  void submit() {
    setState(() {
      nameError = nameController.text.trim().isEmpty ? 'Enter a dish name' : null;

      final prep = int.tryParse(prepController.text.trim());
      prepError = prep == null ? 'Enter a number of minutes' : null;

      final total = int.tryParse(totalController.text.trim());
      if (total == null) {
        totalError = 'Enter a number of minutes';
      } else if (prep != null && total < prep) {
        totalError = 'Total must be at least the prep time';
      } else {
        totalError = null;
      }

      final serves = int.tryParse(servesController.text.trim());
      servesError = serves == null ? 'Enter a number' : null;

      difficultyError = difficulty == null ? 'Pick a difficulty' : null;
    });

    // And now OR every single one together. Forget one and bad data submits.
    if (nameError != null ||
        prepError != null ||
        totalError != null ||
        servesError != null ||
        difficultyError != null ||
        !cooked) {
      return;
    }

    debugPrint('Saved: ${nameController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a Recipe -- the hard way')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Dish name',
              errorText: nameError,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: prepController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Prep time (minutes)',
              errorText: prepError,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: totalController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Total time (minutes)',
              errorText: totalError,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: servesController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Serves',
              errorText: servesError,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButton<String>(
            value: difficulty,
            hint: const Text('Difficulty'),
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: 'Easy', child: Text('Easy')),
              DropdownMenuItem(value: 'Medium', child: Text('Medium')),
              DropdownMenuItem(value: 'Hard', child: Text('Hard')),
            ],
            onChanged: (v) => setState(() => difficulty = v),
          ),
          if (difficultyError != null)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 12),
              child: Text(
                difficultyError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          CheckboxListTile(
            value: cooked,
            onChanged: (v) => setState(() => cooked = v ?? false),
            title: const Text('I have actually cooked this'),
          ),
          const SizedBox(height: 8),
          FilledButton(onPressed: submit, child: const Text('Save recipe')),
        ],
      ),
    );
  }
}
