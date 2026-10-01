// Sign Up — Module 12 project: FORMS & VALIDATION
// Built in the solution video. One screen, one Form, real validation.
//
// The whole point of the module: stop hand-rolling validation with tryParse and
// error strings (Module 9), and use Flutter's Form system —
//   Form + GlobalKey<FormState> + TextFormField(validator: ...)
// — which validates every field with one call and shows each error in place.

import 'package:flutter/material.dart';

import 'signup_screen.dart';

void main() {
  runApp(const SignUpApp());
}

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      debugShowCheckedModeBanner: false,
      // No ThemeData here on purpose. Setting an app-wide input style is
      // Module 13's subject; today every field asks fieldDecoration() for its
      // look, which is one place to change and nothing new to learn.
      home: const SignUpScreen(),
    );
  }
}
