import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../services/contact_storage.dart';
import '../widgets/contact_tile.dart';
import 'add_contact_screen.dart';
import 'contact_detail_screen.dart';

/// The screen that owns the data. Every other screen is handed what it needs
/// and gives back what it made — the list lives here and nowhere else.
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  // Starts EMPTY now. Whatever is on screen came off the disk — no hardcoded
  // rows to hide the fact that loading works.
  final contacts = <Contact>[];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Once, at the start — the same place the quote app kicked off its fetch.
    _load();
  }

  Future<void> _load() async {
    final saved = await ContactStorage.load();
    // We waited, so the screen might be gone. Module 11's caution, unchanged.
    if (!mounted) return;
    setState(() {
      contacts.addAll(saved);
      isLoading = false;
    });
  }

  /// Apply the change, rebuild, and save — in ONE place.
  ///
  /// The list changes in three methods below. Pasting a save call into each
  /// of them is asking to forget one, and a forgotten save is a bug you only
  /// find after losing real data. Weld them together instead.
  void _change(VoidCallback update) {
    setState(update);
    ContactStorage.save(contacts);
  }

  void openDetail(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactDetailScreen(contact: contact),
      ),
    );
  }

  void toggleFavourite(Contact contact) {
    _change(() => contact.favourite = !contact.favourite);
  }

  void deleteContact(Contact contact) {
    final removedContact = contact;
    final removedIndex = contacts.indexOf(contact);

    _change(() => contacts.remove(contact));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedContact.name} removed'),
        action: SnackBarAction(
          label: 'UNDO',
          // Remember the contact AND its position, then put it back where it
          // was. Undo is cheaper than it looks.
          onPressed: () => _change(
            () => contacts.insert(removedIndex, removedContact),
          ),
        ),
      ),
    );
  }

  Future<void> openAddScreen() async {
    final newContact = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(builder: (context) => const AddContactScreen()),
    );

    // The user may have pressed BACK instead of Save, and then nothing was
    // popped. Both exits have to be handled — this guard is where most
    // add-screen crashes come from.
    if (newContact == null) return;

    _change(() => contacts.add(newContact));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Computed inside build, so it can never go stale.
      appBar: AppBar(title: Text('Contacts (${contacts.length})')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : contacts.isEmpty
          ? const _EmptyState()
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ContactTile(
                  contact: contact,
                  onTap: () => openDetail(contact),
                  onToggleFavourite: () => toggleFavourite(contact),
                  onDelete: () => deleteContact(contact),
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

/// A blank white screen tells the user nothing. This tells them what to do,
/// for about eight lines.
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_add_alt, size: 80, color: Colors.grey),
          SizedBox(height: 12),
          Text('No contacts yet', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 4),
          Text('Tap + to add your first one',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
