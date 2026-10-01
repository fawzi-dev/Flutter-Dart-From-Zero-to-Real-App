// Lesson 15.4 -- HALF A LOOP.
//
// *** THIS FILE READS BUT NEVER WRITES. THAT IS THE POINT. ***
//
// Run it. Add two contacts. Fully close the app. Reopen.
//
// Empty.
//
// And the reason is not subtle once you see it: `load()` is here and it is
// correct, but NOTHING EVER CALLS SAVE. Loading from an empty box gives you
// an empty list, forever. Obvious in hindsight; extremely common in practice,
// because the reading half is the interesting half to write.
//
// THE FIX, which is lesson 15.4's real idea:
//
//   void _change(VoidCallback update) {
//     setState(update);
//     ContactStorage.save(contacts);
//   }
//
// then route every mutation through it -- _change(() => contacts.add(c)),
// _change(() => contacts.remove(c)) -- instead of calling setState directly.
//
// Why one helper rather than pasting the save call after each setState:
// there are three places the list changes here, and there will be six in your
// own app. Pasting the same line in six spots is asking to miss one. With
// _change there is NO WAY to change the list without saving it -- the two are
// welded together in one method.
//
// That is the same instinct as derived state: do not rely on remembering to
// do a thing. Make the structure do it for you.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HalfALoopScreen(),
  ));
}

class Contact {
  final String name;
  final String phone;

  Contact({required this.name, required this.phone});

  Map<String, dynamic> toJson() => {'name': name, 'phone': phone};

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json['name'] as String,
        phone: json['phone'] as String? ?? '',
      );
}

class ContactStorage {
  static const _key = 'contacts';

  static Future<void> save(List<Contact> contacts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _key, jsonEncode(contacts.map((c) => c.toJson()).toList()));
  }

  static Future<List<Contact>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    // The first launch has nothing saved. Return an empty list, do not crash.
    if (jsonString == null) return [];
    final decoded = jsonDecode(jsonString) as List;
    return decoded
        .map((m) => Contact.fromJson(m as Map<String, dynamic>))
        .toList();
  }
}

class HalfALoopScreen extends StatefulWidget {
  const HalfALoopScreen({super.key});

  @override
  State<HalfALoopScreen> createState() => _HalfALoopScreenState();
}

class _HalfALoopScreenState extends State<HalfALoopScreen> {
  final List<Contact> contacts = [];
  final nameController = TextEditingController();

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
    final saved = await ContactStorage.load();
    if (!mounted) return;
    setState(() => contacts.addAll(saved));
  }

  void _add() {
    final name = nameController.text.trim();
    if (name.isEmpty) return;
    // <- the save is missing here. And here is where _change would go.
    setState(() => contacts.add(Contact(name: name, phone: 'no number yet')));
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts (${contacts.length})')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _add(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(onPressed: _add, child: const Text('Add')),
              ],
            ),
          ),
          Expanded(
            child: contacts.isEmpty
                ? const Center(child: Text('No contacts yet'))
                : ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, i) => ListTile(
                      leading: CircleAvatar(
                          child: Text(contacts[i].name[0].toUpperCase())),
                      title: Text(contacts[i].name),
                      subtitle: Text(contacts[i].phone),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
