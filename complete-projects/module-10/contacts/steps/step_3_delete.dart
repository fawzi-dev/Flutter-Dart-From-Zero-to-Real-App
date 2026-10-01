// End of lesson 10.4 -- "Removing Items & Swipe-to-Delete".
//
// Dismissible gives you swipe-to-delete in a few lines. The important line is
// the key.
//
//   key: ValueKey(contact)     <- identifies the THING
//   key: ValueKey(index)       <- identifies the PLACE, and deletes the wrong
//                                 row the moment anything moves
//
// Keys are how Flutter tells widgets apart between rebuilds. Index keys work
// perfectly until you delete something, which is the worst kind of bug.
//
// Deletion is undoable rather than confirmed, because the more often people
// delete, the more a dialog every time gets exhausting.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// One person. Three facts -- which in Dart means a class (Module 5).
class Contact {
  final String name;
  final String phone;
  bool favourite;

  Contact({required this.name, required this.phone, this.favourite = false});

  String get initial => name.isEmpty ? '?' : name[0].toUpperCase();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts',
      home: ContactsScreen(),
    );
  }
}

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final List<Contact> contacts = [
    Contact(name: 'Sara Ahmed', phone: '0100 111 2233'),
    Contact(name: 'Payam Rezaei', phone: '0100 444 5566', favourite: true),
    Contact(name: 'Nour Hassan', phone: '0100 777 8899'),
  ];

  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // The four-step pipeline. Every add feature you ever build is these four,
  // in this order.
  void addContact() {
    final name = nameController.text.trim(); // 1. read
    if (name.isEmpty) return; // 2. guard, and get out
    setState(() {
      // 3. change the list
      contacts.add(Contact(name: name, phone: 'no number yet'));
    });
    nameController.clear(); // 4. clear the field
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Counted from the list, every build. Never stored.
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
                    // So the keyboard's return key works too.
                    onSubmitted: (_) => addContact(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(onPressed: addContact, child: const Text('Add')),
              ],
            ),
          ),
          // A scrolling widget inside a Column has no height to work with.
          // Expanded answers the question. Lesson 10.1's headline error.
          Expanded(
            child: contacts.isEmpty
                ? const _EmptyState()
                : ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return Dismissible(
                        // Keyed by the CONTACT, never the index. With
                        // ValueKey(index), deleting row two makes Flutter
                        // think row three BECAME row two, and the wrong one
                        // vanishes.
                        key: ValueKey(contact),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (_) {
                          final removed = contact;
                          final at = contacts.indexOf(contact);
                          setState(() => contacts.remove(contact));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${removed.name} removed'),
                              action: SnackBarAction(
                                label: 'UNDO',
                                // Back to where it was, not onto the end.
                                onPressed: () => setState(
                                  () => contacts.insert(at, removed),
                                ),
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(contact.initial),
                          ),
                          title: Text(
                            contact.name,
                            style: TextStyle(
                              fontWeight: contact.favourite
                                  ? FontWeight.bold
                                  : null,
                              color: contact.favourite
                                  ? Colors.amber.shade900
                                  : null,
                            ),
                          ),
                          subtitle: Text(contact.phone),
                          trailing: IconButton(
                            onPressed: () => setState(() {
                              contact.favourite = !contact.favourite;
                            }),
                            icon: Icon(
                              contact.favourite
                                  ? Icons.star
                                  : Icons.star_border,
                              color: contact.favourite
                                  ? Colors.amber
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// An empty state is the difference between an app that feels finished and
/// one that feels unfinished.
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text('No contacts yet', style: TextStyle(fontSize: 18)),
          SizedBox(height: 4),
          Text(
            'Add someone above to get started',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
