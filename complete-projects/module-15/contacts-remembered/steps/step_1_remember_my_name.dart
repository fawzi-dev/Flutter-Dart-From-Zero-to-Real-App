// End of lesson 15.2 -- "The shared_preferences Recipe".
//
// The whole pause-and-code from 15.2, in one runnable file: a text field, a
// Save button, and a counter -- and all of it survives a full restart.
//
// THE TEST: type a name, tap Save, tap the counter a few times, then FULLY
// CLOSE the app (swipe it out of the recent-apps list -- minimising proves
// nothing, because the process is still alive). Reopen it.
//
// Both are still there.
//
// Three moves, and one of them is an old friend:
//   getInstance()   opens the box. Touches the disk, so it is awaited.
//   setString(k, v) writes. Also awaited.
//   getString(k)    reads. NOT awaited -- the box is already open.
//
// And note the `?? ''`. On the very first launch nothing is saved under
// 'username', so getString returns null -- its type is String?. That is the
// Module 5 null check turning up exactly where you would expect it.
//
// The limit that shapes lesson 15.3: setString, setInt, setBool, setDouble.
// That is the entire menu. There is no setObject and no setContactList.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RememberMeScreen(),
  ));
}

class RememberMeScreen extends StatefulWidget {
  const RememberMeScreen({super.key});

  @override
  State<RememberMeScreen> createState() => _RememberMeScreenState();
}

class _RememberMeScreenState extends State<RememberMeScreen> {
  final nameController = TextEditingController();
  int count = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      nameController.text = prefs.getString('username') ?? '';
      count = prefs.getInt('count') ?? 0;
    });
  }

  Future<void> _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', nameController.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Saved')));
  }

  Future<void> _bump() async {
    setState(() => count++);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('count', count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Remember me')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Your name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _saveName(),
            ),
            const SizedBox(height: 12),
            FilledButton(onPressed: _saveName, child: const Text('Save')),
            const SizedBox(height: 48),
            Text('$count', textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _bump,
              child: const Text('Count (this survives too)'),
            ),
          ],
        ),
      ),
    );
  }
}
