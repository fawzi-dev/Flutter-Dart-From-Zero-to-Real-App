// End of lesson 10.2 P2 -- "Your Own Class, Driving the List".
//
// A ListView.builder, a Contact class, and a ListTile per row.
//
// The important half is the DATA. One object per person, so nothing can fall
// out of step. The alternative -- three parallel lists of names, phones and
// favourites -- is one sort() away from total nonsense.
//
// Scroll away and back: the star is still gold. The tile widget gets thrown
// away and rebuilt as you scroll, but contact.favourite lives in the list,
// which lives in the State class. The data survives; the widgets are
// disposable.

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      // .builder, even though the list is short. Build the habit on the small
      // one so it is automatic on the big one.
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
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
          );
        },
      ),
    );
  }
}
