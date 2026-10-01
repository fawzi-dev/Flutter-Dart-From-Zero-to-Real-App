import 'package:flutter/material.dart';

import '../models/contact.dart';

/// Data travels FORWARD through the constructor. A screen is a widget, a
/// widget is a class, and classes take parameters — there is no special
/// mechanism here. Lesson 5.4's data-class recipe, unchanged.
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
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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
