# Steps — Module 16, My Day Cloud

**There are no `.dart` snapshots in this folder, on purpose.**

Every file in this project needs a `lib/firebase_options.dart` that
`flutterfire configure` generates **for your own Firebase project**. Mine
would not work for you, and it is not committed. A checkpoint file nobody can
run is not a checkpoint — so this is a map of the six build videos instead.

Before any of it runs, do the setup in
[`../README.md`](../README.md) — including **step 6**, uncommenting the two
Firebase lines in `lib/main.dart`.

## The six videos, and what exists after each

| Video | What you add | The file to look at |
|---|---|---|
| **16.2** | The project, both services, and `Firebase.initializeApp` | `lib/main.dart` |
| **16.3** | Sign up, log in, log out, and human error messages | `lib/services/auth_service.dart` |
| **16.4** | The gate that decides which screen you see | `lib/screens/auth_gate.dart` |
| **16.5** | Writing tasks, each labelled with its owner's `uid` | `lib/services/task_service.dart` |
| **16.6** | `.snapshots()` — and the home screen stops holding data | `lib/screens/home_screen.dart` |
| **16.8** | Ownership rules, enforced by the database | `firestore.rules` |

## The two files worth reading side by side

Open `services/task_service.dart` and `services/favorites_service.dart`
together. **Same structure, different nouns.** That similarity is the whole
point of the 16.9 challenge: transposing one into the other is not cheating,
it is the exercise.

## The diff that shows what this module actually did

Compare `screens/home_screen.dart` here against the Module 14 version:

```
complete-projects/module-14/my-day/lib/screens/home_screen.dart
complete-projects/module-16/my-day-cloud/lib/screens/home_screen.dart
```

**The cloud version is smaller.** Gone: the `tasks` list field, every
`setState` around tasks, the sorting-into-state logic, and the manual count.
Left: a `StreamBuilder`, a list, and three one-line service calls.

That is what happens when you stop holding data and telling the UI to update,
and start describing the UI in terms of a stream.

## One expected error, and one you should cause on purpose

**Expected:** `permission-denied` in 16.5. You chose production mode in 16.2,
so the database starts closed. That error is the system working.

**On purpose:** in 16.8, delete the `.where('uid', isEqualTo: _uid)` from
`watchTasks()` under the loose rules and run it. You will read another
account's tasks. That is the argument for security rules, and reading about it
is not the same as seeing it.

Then publish the real rules and try again — the server refuses it.

## If something breaks

[`challenges/module-16/troubleshooting.md`](../../../challenges/module-16/troubleshooting.md)
lists the errors people actually hit, with the versions this module was
recorded against.
