// Smoke tests for the contacts app. Each one covers a thing a video promises
// works — if these pass, the module's demo is intact.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:contacts/main.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/screens/add_contact_screen.dart';
import 'package:contacts/screens/contact_detail_screen.dart';

void main() {
  testWidgets('10.2 P2 — the list renders and the star toggles', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Contacts (3)'), findsOneWidget);
    expect(find.text('Sara Ahmed'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget); // Payam starts starred

    await tester.tap(find.byIcon(Icons.star_border).first);
    await tester.pump();
    expect(find.byIcon(Icons.star), findsNWidgets(2));
  });

  testWidgets('10.6 P1 — tapping a row opens the detail screen', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Sara Ahmed'));
    await tester.pumpAndSettle();

    expect(find.byType(ContactDetailScreen), findsOneWidget);
    expect(find.text('0100 111 2233'), findsWidgets);
  });

  testWidgets('10.6 P2 — the add screen returns a contact', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.byType(AddContactScreen), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'Yara Saleh');
    await tester.enterText(find.byType(TextField).last, '0100 000 1111');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Yara Saleh'), findsOneWidget);
    expect(find.text('Contacts (4)'), findsOneWidget);
  });

  testWidgets('10.6 P2 — backing out of the add screen does not crash',
      (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // The other exit. `push` returns null and the guard clause has to hold.
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Contacts (3)'), findsOneWidget);
  });

  testWidgets('10.6 P2 — an empty name is refused', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '   ');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('A contact needs a name'), findsOneWidget);
    expect(find.byType(AddContactScreen), findsOneWidget);
  });

  test('10.2 P2 — the avatar initial handles an empty name', () {
    expect(Contact(name: 'sara', phone: '').initial, 'S');
    expect(Contact(name: '', phone: '').initial, '?');
  });
}
