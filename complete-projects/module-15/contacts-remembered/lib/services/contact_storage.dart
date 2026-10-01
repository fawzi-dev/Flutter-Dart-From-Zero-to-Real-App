import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/contact.dart';

/// Everything that knows about the disk lives here.
///
/// No screen in this app imports `shared_preferences` or `dart:convert` — the
/// same boundary as the weather service, for the same reason. `jsonEncode`
/// and `toJson` are messy details, and they stay in one file.
class ContactStorage {
  static const _key = 'contacts';

  /// Object → Map → String → disk.
  static Future<void> save(List<Contact> contacts) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(contacts.map((c) => c.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  /// disk → String → Map → object. The same trip backwards.
  static Future<List<Contact>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    // THE line. On the very first launch nothing has ever been saved, so
    // getString returns null. Hand back an empty list — a fresh start, no
    // crash. This is the case nobody remembers to test.
    if (jsonString == null) return [];

    try {
      final decoded = jsonDecode(jsonString) as List;
      return decoded
          .map((item) => Contact.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      // Saved data can be corrupt or written by an older, incompatible
      // version. Starting empty is bad; refusing to launch is worse.
      return [];
    }
  }
}
