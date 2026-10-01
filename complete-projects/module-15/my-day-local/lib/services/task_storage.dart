import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

/// Saves and loads the task list on the device.
///
/// SharedPreferences is a tiny key/value store — perfect for small things
/// like this. But it only holds strings, numbers and bools, NOT a
/// `List<Task>`. So the trick is: turn the whole list into ONE JSON string
/// on the way out, and back into a list on the way in. It's the encode side
/// of the JSON you learned to decode in Module 11.
class TaskStorage {
  static const _key = 'tasks';

  static Future<void> save(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    // Each Task -> a Map, the whole list -> a JSON string.
    final jsonString = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  static Future<List<Task>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    // First ever launch: nothing has been saved, so start empty.
    // getString returns String? — null means "no value" — so this is the
    // Module 5 null check earning its keep again.
    if (jsonString == null) return [];

    final decoded = jsonDecode(jsonString) as List;
    return decoded
        .map((item) => Task.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
