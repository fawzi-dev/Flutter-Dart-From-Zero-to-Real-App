# Cheat Sheet — Persistence & the Cloud (Modules 13–14, bonus)

## Local storage — shared_preferences (Module 15)
```dart
import 'package:shared_preferences/shared_preferences.dart';

final prefs = await SharedPreferences.getInstance();
await prefs.setString('name', 'Sam');   // strings / int / double / bool ONLY
final name = prefs.getString('name') ?? '';   // null on first launch
```

## Saving a list = one JSON string
```dart
// model
Map<String, dynamic> toJson() => {
  'title': title, 'priority': priority.name, 'createdAt': createdAt.toIso8601String(),
};
factory Task.fromJson(Map<String, dynamic> j) => Task(
  title: j['title'], createdAt: DateTime.parse(j['createdAt']),
  priority: Priority.values.firstWhere((p) => p.name == j['priority']),
);

// service
save(List<Task> t) async => (await SharedPreferences.getInstance())
    .setString('tasks', jsonEncode(t.map((x) => x.toJson()).toList()));
load() async {
  final s = (await SharedPreferences.getInstance()).getString('tasks');
  if (s == null) return <Task>[];                     // first launch
  return (jsonDecode(s) as List).map((m) => Task.fromJson(m)).toList();
}
```
- Load once in `initState`; save on **every** change (one `_change()` helper).

## Firebase Auth (Module 16)
```dart
final auth = FirebaseAuth.instance;
await auth.createUserWithEmailAndPassword(email: e, password: p);
await auth.signInWithEmailAndPassword(email: e, password: p);
await auth.signOut();
Stream<User?> gate = auth.authStateChanges();   // Stream = many values over time
final uid = auth.currentUser!.uid;
```

## Firestore + realtime StreamBuilder
```dart
final db = FirebaseFirestore.instance;
db.collection('tasks').add({'title': t, 'uid': uid, 'createdAt': FieldValue.serverTimestamp()});

Stream<List<Task>> watch() => db.collection('tasks')
  .where('uid', isEqualTo: uid)        // only mine (app-level; NOT security)
  .snapshots()                          // .snapshots() not .get() = live
  .map((s) => s.docs.map(Task.fromDoc).toList());

StreamBuilder<List<Task>>(stream: watch(), builder: (c, snap) {
  if (snap.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
  final tasks = snap.data ?? [];
  return ListView(...);
});
```

## Security rules (the real protection)
```
match /tasks/{id} {
  allow read, update, delete: if request.auth.uid == resource.data.uid;
  allow create: if request.auth.uid == request.resource.data.uid;  // incoming doc
}
```
- The `where` filter is politeness; **rules** are security. Never ship "test mode".
