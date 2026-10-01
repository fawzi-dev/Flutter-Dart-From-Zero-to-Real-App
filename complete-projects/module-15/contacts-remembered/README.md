# Contacts, Remembered — the Module 15 lesson project

The contacts app from Module 10, which forgot every person you added the
moment you closed it. Now it doesn't.

```
flutter pub get
flutter run
```

**The one test that matters:** add three contacts, star one, **fully close the
app** (swipe it away), reopen → all three are there, the starred one still
starred.

## What each video adds

| Lesson | The app gains |
|--------|---------------|
| 15.1 · The problem | Nothing. Add contacts, kill the app, watch them vanish. Let it sting |
| 15.2 · shared_preferences | The recipe, on a trivial value first — one new thing at a time |
| 15.3 · Saving a list | `Contact.toJson`, `jsonEncode`, and `ContactStorage.save` |
| 15.4 · Loading and wiring | `ContactStorage.load`, `initState`, and saving welded to every change |

## Why contacts and not My Day

The challenge asks you to make My Day remember its tasks. Contacts is a
different model with **the same two hard fields**, so you see every move the
challenge needs without seeing the answer:

| The challenge grades | This project teaches it on |
|----------------------|----------------------------|
| `priority` — an enum | `group` — an enum (`family`/`work`/`friends`/`other`) |
| `createdAt` — a DateTime | `addedOn` — a DateTime |

Both are stored the same way (`.name` and `toIso8601String()`).

## Four things worth pausing on

**`if (jsonString == null) return [];`** On the very first launch nothing has
ever been saved. Hand back an empty list — a fresh start, not a crash. This is
the case nobody remembers to test, and there's a test for it here.

**`orElse` on the enum lookup is a migration story.** Rename a group in
version 2 and every contact saved under the old name would crash the launch
without it. Same for the `??` defaults on fields added later. Old saved data
outlives your code, and it doesn't get to be re-saved first.

**`_change()` welds saving to mutating.**

```dart
void _change(VoidCallback update) {
  setState(update);
  ContactStorage.save(contacts);
}
```

The list changes in four places. Pasting a save call into each is asking to
forget one, and a forgotten save is a bug you only find after losing real
data. Don't rely on remembering — make the structure do it.

**The seed contacts are gone.** The list starts empty, so everything on screen
came off the disk. Hardcoded rows would have hidden whether loading actually
worked.

## Scope

Local only — this device, this install. Delete the app and it's gone. Module
16 is where it moves to the cloud.
