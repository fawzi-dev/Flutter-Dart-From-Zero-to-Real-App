// Tests for Contacts, made to remember.
//
// SharedPreferences has an in-memory test mode, so these run the real save
// and load paths without a device.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:contacts_remembered/main.dart';
import 'package:contacts_remembered/models/contact.dart';
import 'package:contacts_remembered/services/contact_storage.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('15.3/15.4 — an enum and a DateTime survive the round trip', () {
    final before = Contact(
      name: 'Sara Ahmed',
      phone: '0100 111 2233',
      group: ContactGroup.work,
      addedOn: DateTime(2026, 7, 24, 9, 30),
      favourite: true,
    );

    final after = Contact.fromJson(before.toJson());

    expect(after.name, 'Sara Ahmed');
    expect(after.group, ContactGroup.work);        // 'work' -> the enum
    expect(after.addedOn, DateTime(2026, 7, 24, 9, 30));
    expect(after.favourite, isTrue);
  });

  test('15.4 — orElse lets old saved data survive a rename', () {
    // A record written by a version that had a group we have since removed.
    final revived = Contact.fromJson({
      'name': 'Old Record',
      'phone': '000',
      'group': 'colleagues',      // no longer exists
      'addedOn': '2026-01-01T00:00:00.000',
      'favourite': false,
    });

    expect(revived.group, ContactGroup.other);   // fallback, not a crash
  });

  test('15.4 — the first launch returns an empty list, never a crash',
      () async {
    expect(await ContactStorage.load(), isEmpty);
  });

  test('15.3 — a saved list comes back as real objects', () async {
    await ContactStorage.save([
      Contact(name: 'Sara', phone: '1', group: ContactGroup.friends),
      Contact(name: 'Payam', phone: '2', favourite: true),
    ]);

    final loaded = await ContactStorage.load();

    expect(loaded, hasLength(2));
    expect(loaded.first.group, ContactGroup.friends);
    expect(loaded.last.favourite, isTrue);
  });

  test('15.4 — corrupt saved data starts empty instead of refusing to launch',
      () async {
    SharedPreferences.setMockInitialValues({'contacts': 'not json at all'});
    expect(await ContactStorage.load(), isEmpty);
  });

  testWidgets('15.4 — the one test that matters: add, restart, still there',
      (tester) async {
    // First run: empty, then add someone.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('No contacts yet'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Yara Saleh');
    await tester.enterText(find.byType(TextField).last, '0100 000 1111');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Yara Saleh'), findsOneWidget);

    // "Fully close the app and reopen it" — a brand new widget tree, reading
    // whatever is on disk.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Yara Saleh'), findsOneWidget);
    expect(find.text('Contacts (1)'), findsOneWidget);
  });
}
