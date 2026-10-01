// End of lesson 10.6 P2 -- "Back, Through pop".
//
// This is the last single-file version of the app. Three screens, one model,
// one list -- and step 3's 209 lines have become 300. That length is the
// whole reason 10.7 exists: nothing here is wrong, it is just all in one
// place.
//
// The two directions data travels, both of them ordinary Dart:
//
//   forward   ContactDetailScreen(contact: contact)   <- a constructor
//   backward  Navigator.pop(context, newContact)      <- a return value
//
// And the line that catches the most bugs in this module:
//
//   if (newContact == null) return;
//
// The user can leave the add screen by pressing BACK, and then nothing was
// popped. Both exits have to be handled.

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

/// The screen that owns the data. The other two are handed what they need,
/// and hand back what they made.
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

  // The text field moved to a screen of its own, so the controller went with
  // it. A whole screen can ask two questions; a row above a list can ask one.
  Future<void> openAddScreen() async {
    // push returns the result EVENTUALLY -- when the screen closes. await is
    // "wait for that, without freezing the app". Module 11 explains it.
    final newContact = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(builder: (context) => const AddContactScreen()),
    );

    // Back button instead of Save: nothing was popped, so this is null.
    if (newContact == null) return;

    setState(() => contacts.add(newContact));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Counted from the list, every build. Never stored.
      appBar: AppBar(title: Text('Contacts (${contacts.length})')),
      // The Column and the Expanded left with the text field. A ListView on
      // its own has the whole body to work with.
      body: contacts.isEmpty
          ? const _EmptyState()
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Dismissible(
                  // Keyed by the CONTACT, never the index. With
                  // ValueKey(index), deleting row two makes Flutter think row
                  // three BECAME row two, and the wrong one vanishes.
                  key: ValueKey(contact),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
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
                          onPressed: () =>
                              setState(() => contacts.insert(at, removed)),
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(child: Text(contact.initial)),
                    title: Text(
                      contact.name,
                      style: TextStyle(
                        fontWeight: contact.favourite ? FontWeight.bold : null,
                        color: contact.favourite ? Colors.amber.shade900 : null,
                      ),
                    ),
                    subtitle: Text(contact.phone),
                    trailing: IconButton(
                      onPressed: () => setState(() {
                        contact.favourite = !contact.favourite;
                      }),
                      icon: Icon(
                        contact.favourite ? Icons.star : Icons.star_border,
                        color: contact.favourite ? Colors.amber : Colors.grey,
                      ),
                    ),
                    // Forward. The whole object travels -- not a copy of the
                    // name, the actual object.
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ContactDetailScreen(contact: contact),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Data travels FORWARD through the constructor. A screen is a widget, a
/// widget is a class, and classes take parameters. No special mechanism.
class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(contact.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 44,
              child: Text(
                contact.initial,
                style: const TextStyle(fontSize: 34),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              contact.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              contact.phone,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

/// Data travels BACKWARD through Navigator.pop(context, value).
///
/// Notice what this screen does NOT have: the contacts list. It builds one
/// object and hands it back -- "here is what the user made, do with it what
/// you like."
class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String? nameError;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  // The same four-step pipeline as 10.3, with the last two steps done by pop.
  void save() {
    final name = nameController.text.trim(); // 1. read
    if (name.isEmpty) {
      // 2. guard, and get out
      setState(() => nameError = 'A contact needs a name');
      return;
    }
    Navigator.pop(
      // 3 + 4. hand it back, and go
      context,
      Contact(name: name, phone: phoneController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New contact')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: nameError,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: save,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
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
            'Tap + to add your first one',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
