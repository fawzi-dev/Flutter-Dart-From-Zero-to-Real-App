# My Day Cloud — Module 16 (bonus)

My Day with Firebase Authentication and Cloud Firestore: real login,
cloud-stored tasks, live sync across devices, and per-user security rules.

## Setup (required — this will not run without it)

1. Create a Firebase project — see lesson 16.2.
2. Enable **Email/Password** authentication.
3. Create a **Firestore database in production mode**.
4. From this folder:
   ```
   dart pub global activate flutterfire_cli
   flutterfire configure
   flutter pub get
   ```
   This generates `lib/firebase_options.dart` for *your* project.
   It is intentionally not committed — yours will differ.
5. Paste [`firestore.rules`](firestore.rules) into the Firebase console
   (Firestore → Rules) and publish.
6. **Uncomment the two Firebase lines in `lib/main.dart`.** They ship
   commented out so the project still analyzes without your generated
   `firebase_options.dart`. Skip this and the app launches but every
   Firebase call throws *No Firebase App '[DEFAULT]' has been created*.

## What to look at

- `services/auth_service.dart` — the entire auth system, three methods
- `services/task_service.dart` — `snapshots()` is what makes sync realtime
- `services/favorites_service.dart` — the Module 16 challenge solution;
  put it beside `task_service.dart` and notice it's the same shape
- `screens/auth_gate.dart` — no navigation code: the UI follows the auth stream
- `firestore.rules` — the ownership pattern; `resource` vs `request.resource`

## Diff against Module 14

`complete-projects/module-14/my-day/` is the same app without the cloud.
The interesting part of the diff: the home screen lost its task list and
every task-related `setState`.
