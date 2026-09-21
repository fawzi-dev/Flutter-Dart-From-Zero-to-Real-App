# Module 16 — Firebase Troubleshooting

**This is the doc the videos point at.** Module 16 is the most version-fragile
part of the course: the Firebase console gets redesigned, the CLI changes, and
Gradle moves underneath everyone periodically. The *concepts* in the videos do
not change. Button positions do.

**If a console button isn't where the video shows it, look for the same
words.** "Authentication", "Sign-in method", "Email/Password", "Firestore
Database", "Rules". Those names are stable even when the layout is not.

Versions this module was recorded against:

| | Version |
|---|---|
| Flutter SDK constraint | `^3.9.2` |
| `firebase_core` | `^4.12.1` |
| `firebase_auth` | `^6.5.6` |
| `cloud_firestore` | `^6.7.1` |
| Android `compileSdk` / `minSdk` | Flutter defaults (`flutter.compileSdkVersion`) |
| Java / Kotlin JVM target | 17 |
| iOS deployment target | 13.0 |

---

## Setup problems (lesson 16.2)

### `flutterfire: command not found`

The CLI installed but isn't on your PATH.

```bash
dart pub global activate flutterfire_cli
```

Then add Dart's global bin folder to your PATH:

- **Windows** — `%LOCALAPPDATA%\Pub\Cache\bin`
- **macOS / Linux** — `$HOME/.pub-cache/bin`

Open a **new** terminal afterwards; PATH changes don't apply to already-open
ones. That single detail accounts for most "I did it and it still doesn't work".

### `firebase: command not found`, or `flutterfire configure` can't find your projects

`flutterfire` drives the **Firebase CLI**, which is a separate install.

```bash
npm install -g firebase-tools     # needs Node.js
firebase login
```

If you'd rather not install Node, Firebase publishes standalone binaries — see
`firebase.google.com/docs/cli`. After `firebase login`, run `firebase projects:list`.
If your project isn't listed, you're logged into the wrong Google account:
`firebase logout`, then `firebase login` again.

### `flutterfire configure` finished but nothing seems connected

Run it **from inside the Flutter project folder** — the one with `pubspec.yaml`.
Running it from a parent directory appears to succeed and configures nothing.

Re-running it is always safe.

### Android build fails: `minSdkVersion` too low

Firebase Auth needs a higher minimum than very old Flutter templates set. The
error names the number it wants. In `android/app/build.gradle.kts`:

```kotlin
    defaultConfig {
        minSdk = 23        // was flutter.minSdkVersion
    }
```

Then `flutter clean` and rebuild. Current Flutter templates already default
high enough, so you may never see this.

### Android build fails on Java or Gradle versions

Symptoms mention `jvmTarget`, `sourceCompatibility`, or "Unsupported class file
major version". This module builds against **Java 17**. Check
`android/app/build.gradle.kts` has:

```kotlin
    compileOptions { sourceCompatibility = JavaVersion.VERSION_17 }
    kotlin { compilerOptions { jvmTarget = JvmTarget.JVM_17 } }
```

`flutter doctor -v` prints the Java version Flutter is actually using, which is
often not the one you think you installed.

### iOS: pod install fails or the deployment target is too low

```bash
cd ios && pod repo update && pod install
```

If it complains about the deployment target, open `ios/Podfile` and set
`platform :ios, '13.0'` (uncommenting that line if needed), then `pod install`
again. Firebase's iOS SDKs move their minimum up over time; the error states
the required version.

---

## Runtime problems

### `No Firebase App '[DEFAULT]' has been created`

The single most common error in this module. It means `Firebase.initializeApp`
never ran. Three causes, in order of likelihood:

**1. You downloaded the finished project.** `complete-projects/module-16/my-day-cloud/lib/main.dart`
ships with the two Firebase lines **commented out**, because
`firebase_options.dart` is generated per project and the instructor's is not
yours. Run `flutterfire configure`, then **uncomment them**:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
...
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
```

**2. You forgot `await`.** `Firebase.initializeApp` returns a Future. Without
`await`, `runApp` runs before Firebase is ready.

**3. You forgot `WidgetsFlutterBinding.ensureInitialized()`** as the first line
of `main`. It must come before any async work in `main`.

The correct shape:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

### `[firebase_auth/operation-not-allowed]`

Email/Password sign-in isn't enabled. Console → **Authentication** →
**Sign-in method** → **Email/Password** → enable the *first* toggle and save.
Not the passwordless one below it.

### `[cloud_firestore/permission-denied]`

**In lesson 16.5 this is expected and correct** — you chose production mode in
16.2, so the database starts closed. Publish the minimal rule from 16.5, then
the proper ownership rules in 16.8.

**After 16.8**, it usually means one of:

- **Your query has no `uid` filter.** With ownership rules, Firestore *rejects
  queries that could return documents you're not allowed to read* — it does not
  quietly filter them. The `.where('uid', isEqualTo: _uid)` and the rule have to
  agree. This is the point lesson 16.8 demonstrates on purpose.
- **You're creating a document without a `uid` field**, or with someone else's.
  `create` checks `request.resource.data.uid`.
- **You swapped `resource` and `request.resource`.** `resource.data` is the
  document as it already exists; `request.resource.data` is the one arriving.
  `create` must use `request.resource` — there is no existing document yet.
- **Rules haven't propagated.** Wait ten seconds after publishing and retry
  before assuming the rule is wrong.

Use the **Rules Playground** (Console → Firestore → Rules) to test a rule
without touching the app. It is much faster than rebuilding.

### `The query requires an index` / composite index error

Triggered by combining `.where()` with `.orderBy()` on different fields.

**The error message contains a URL.** Click it — the console opens with the
index already configured. Click create, wait a minute or two, and re-run.

Or avoid it entirely at this scale by sorting in Dart after the data arrives,
which is what the videos do.

### Nothing syncs between devices

- Both devices must be logged in as the **same account**.
- You must be using `.snapshots()`, not `.get()`. `.get()` fetches once.
- Check the `uid` on the documents in the console matches the user in the
  Authentication tab.

### The app works offline, which seems wrong

It isn't. Firestore caches locally and shows you your own writes immediately,
then syncs when the connection returns. That is intended behaviour. Be aware
that if two devices edit the same document while offline, **the last write to
reach the server wins** — nothing merges for you.

---

## Console and account problems

### I can't find a setting the video shows

Search by the words, not the position. Firebase reorganises its console
regularly. `Authentication`, `Firestore Database`, `Rules`, `Sign-in method`
and `Users` have all kept their names through several redesigns.

### Will this cost me money?

No. Everything in this module sits far inside the free tier. Two things worth
knowing anyway:

- Firestore bills on **document reads**, and a live `snapshots()` listener on a
  large collection reads a lot. Fine here; worth knowing before you point one
  at a big collection.
- Use a **separate Google account for course projects** rather than your
  personal one, as lesson 16.1 recommends.

### Is it safe that `firebase_options.dart` is in my repo?

Yes. Those keys **identify** your project; they don't **authorize** access.
Firebase's security comes from the rules you wrote in 16.8. What is genuinely
unsafe is shipping `allow read, write: if true` — which is exactly why 16.2
chose production mode.

---

## Still stuck?

Use the method from lesson 14.2, which works here as well as anywhere:

1. **Read the error and find the layer.** Build failure (Gradle/Pods),
   startup failure (initialization), or permission failure (rules)? Those are
   three different problems with three different fixes.
2. **Search the exact error message**, in quotes, including the
   `[firebase_auth/...]` or `[cloud_firestore/...]` code.
3. **Check the sequence.** Almost every setup failure in this module is a step
   from 16.2 that didn't finish cleanly. Re-running `flutterfire configure` is
   safe and fixes a surprising amount.
