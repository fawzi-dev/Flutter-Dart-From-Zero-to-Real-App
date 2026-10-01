// My Day Cloud — Module 16 BONUS (Firebase Auth + Firestore)
//
// ⚠️ SETUP REQUIRED before this runs:
//   1. Create a Firebase project (lesson 16.2)
//   2. Enable Email/Password auth and Firestore (production mode)
//   3. Run `flutterfire configure` in this folder — it generates
//      lib/firebase_options.dart, which is NOT committed here because
//      it is specific to your own Firebase project.
//   4. Publish the rules in firestore.rules (lesson 16.8)
//
// Diff this against complete-projects/module-14/my-day/ — notice the app
// got SMALLER: the local task list and its setState calls are gone.

import 'package:flutter/material.dart';

// import 'firebase_options.dart';
import 'app_colors.dart';
import 'screens/auth_gate.dart';

void main() async {
  // Required before any async work in main.
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Uncomment this line after you run `flutterfire configure` and it generates
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Day',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      // Not a screen: a gate that watches the auth stream and picks one.
      home: const AuthGate(),
    );
  }
}
