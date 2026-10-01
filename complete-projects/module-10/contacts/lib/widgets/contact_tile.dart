import 'package:flutter/material.dart';

import '../models/contact.dart';

/// One row of the list.
///
/// It owns NO state. It is handed a contact to display and three functions to
/// call: tapped, starred, deleted. It doesn't know what a contacts list is, and
/// it never calls setState. It displays, and it reports.
class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.contact,
    required this.onTap,
    required this.onToggleFavourite,
    required this.onDelete,
  });

  final Contact contact;
  final VoidCallback onTap;
  final VoidCallback onToggleFavourite;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      // Keyed by the CONTACT, never by the index. With ValueKey(index),
      // deleting row two makes Flutter think row three became row two, and
      // the wrong one vanishes. Lesson 10.4's headline bug.
      key: ValueKey(contact),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: ListTile(
        leading: CircleAvatar(child: Text(contact.initial)),
        title: Text(
          contact.name,
          style: TextStyle(
            // null means "no opinion — let the theme decide", which is
            // almost always what you want.
            fontWeight: contact.favourite ? FontWeight.bold : null,
            color: contact.favourite ? Colors.amber.shade900 : null,
          ),
        ),
        subtitle: Text(contact.phone),
        // The star is its own button, so tapping it doesn't also open the
        // detail screen. Two taps, two jobs, no surprises.
        trailing: IconButton(
          onPressed: onToggleFavourite,
          icon: Icon(
            contact.favourite ? Icons.star : Icons.star_border,
            color: contact.favourite ? Colors.amber : Colors.grey,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
