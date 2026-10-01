import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task.dart';

class TaskService {
  static final _db = FirebaseFirestore.instance;

  // The `!` is justified: this service is only reachable from behind the
  // AuthGate, so if this code runs, somebody is logged in.
  static String get _uid => FirebaseAuth.instance.currentUser!.uid;

  static Future<void> add(Task task) async {
    await _db.collection('tasks').add({
      'title': task.title,
      'note': task.note,
      'priority': task.priority.name, // enums can't go in directly
      'isDone': task.isDone,
      'uid': _uid, // the label that makes multi-user data work
      'createdAt': FieldValue.serverTimestamp(), // phone clocks lie
    });
  }

  /// snapshots(), not get(): emits a fresh list every time the data changes
  /// on any device. That one method call is the whole realtime feature.
  static Stream<List<Task>> watchTasks() {
    return _db
        .collection('tasks')
        .where('uid', isEqualTo: _uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(Task.fromDoc).toList());
  }

  static Future<void> toggle(String id, bool isDone) =>
      _db.collection('tasks').doc(id).update({'isDone': isDone});

  static Future<void> delete(String id) =>
      _db.collection('tasks').doc(id).delete();
}
