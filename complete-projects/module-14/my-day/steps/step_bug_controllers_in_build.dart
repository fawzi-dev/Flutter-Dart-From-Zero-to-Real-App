// Lesson 14.5 -- the controllers-in-build bug, on its own.
//
// *** THIS FILE IS BROKEN ON PURPOSE. RUN IT ANYWAY. ***
//
// Type a title. Then tap a priority chip. Your title disappears.
//
// No error. No crash. No red screen. The app just quietly eats your input
// whenever anything else on the screen changes -- which is the worst kind of
// bug, because there is nothing to read.
//
// Debug it with the ladder from 14.2 before you scroll down:
//
//   1. Is it running?        Obviously. Skip it.
//   2. Is the data right?    Add a debugPrint in the chip's onSelected and
//                            print titleController.text. It is correct while
//                            you type, and empty after the tap.
//   3. So something RESETS it. What happens when you tap a chip?
//                            setState -> rebuild -> build runs AGAIN ->
//                            and the line below runs again with it.
//
// The fix is four lines down from here, commented out.
//
// The general rule, worth writing in your bug journal:
//   ANYTHING THAT MUST SURVIVE A REBUILD GOES IN THE STATE CLASS, NOT BUILD.
// Controllers, your data, scroll positions. build describes the screen; it
// does not create things. Same lesson as the broken counter in 9.2.

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BuggyAddScreen(),
  ));
}

enum Priority { low, medium, high }

class BuggyAddScreen extends StatefulWidget {
  const BuggyAddScreen({super.key});

  @override
  State<BuggyAddScreen> createState() => _BuggyAddScreenState();
}

class _BuggyAddScreenState extends State<BuggyAddScreen> {
  Priority priority = Priority.medium;

  // THE FIX -- uncomment these two, delete the line inside build, and add a
  // dispose(). Then the text survives every rebuild.
  //
  // final titleController = TextEditingController();
  //
  // @override
  // void dispose() {
  //   titleController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // THE BUG. build runs on every setState, so this makes a brand-new,
    // empty controller every time the chips change.
    final titleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('New Task (broken)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'What needs doing?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Priority'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: Priority.values.map((p) {
                return ChoiceChip(
                  label: Text(p.name),
                  selected: priority == p,
                  // Tap this and watch the title field empty itself.
                  onSelected: (_) => setState(() => priority = p),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Title was: "${titleController.text}"')),
                );
              },
              child: const Text('Show me what the controller holds'),
            ),
          ],
        ),
      ),
    );
  }
}
