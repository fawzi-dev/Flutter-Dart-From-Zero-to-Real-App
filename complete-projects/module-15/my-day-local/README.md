# My Day (local) — Module 15 reference

The Module 14 capstone, upgraded so its tasks **survive closing the app**, using
`shared_preferences`.

The entire change from Module 14 is three small pieces — diff the two folders:

| File | What changed |
|---|---|
| `lib/models/task.dart` | added `toJson()` and `Task.fromJson()` (the encode side of Module 11's JSON) |
| `lib/services/task_storage.dart` | **new** — save/load the list as one JSON string via `SharedPreferences` |
| `lib/screens/home_screen.dart` | `_load()` in `initState`, and a `_change()` helper that saves after every mutation |

## Run it
```
flutter pub get
flutter run
```
Add a few tasks, fully close the app, reopen it — they're still there. That's the
whole point of the module.

Module 16 (Firebase) starts from the plain Module 14 app again and takes data all
the way to the cloud.
