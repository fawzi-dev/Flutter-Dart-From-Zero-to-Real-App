import 'package:flutter/material.dart';

/// A real sign-up form: a Form with a GlobalKey, TextFormFields with validators,
/// a dropdown, a "must agree" checkbox, focus flow between fields, and a submit
/// that validates everything at once.
/// One place for how every field on this form looks.
///
/// A function that returns a value -- Module 3, unchanged. Change the corner
/// radius here and all five fields follow, which is the same "one idea, one
/// place" instinct as AppColors in Module 9.
///
/// (There IS an app-wide way to do this, `InputDecorationTheme`. That is
/// Module 13's job, and it needs the theme system to make sense.)
InputDecoration fieldDecoration(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
  );
}


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // The key is the handle to the whole form's state — validate() / save() / reset().
  final _formKey = GlobalKey<FormState>();

  // Controllers: one per text field, disposed at the end (Module 9's rule).
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  // Focus nodes let one field's "next" button jump to the following field.
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  String? _country;
  bool _agreed = false;

  // Start silent; switch to "validate as they type" only after the first submit,
  // so the form isn't yelling at the user before they've done anything.
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  void _submit() {
    // One call validates every field and the dropdown. It returns true only if
    // every validator returned null.
    final formValid = _formKey.currentState!.validate();

    // The checkbox isn't a form field, so validate it ourselves.
    if (!formValid || !_agreed) {
      setState(() => _autovalidate = AutovalidateMode.onUserInteraction);
      if (!_agreed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please accept the terms to continue.')),
        );
      }
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WelcomeScreen(name: _nameController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your account'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: _autovalidate,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _emailFocus.requestFocus(),
              decoration: fieldDecoration('Full name', Icons.person_outline),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null; // null = valid
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _emailController,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
              decoration: fieldDecoration('Email', Icons.email_outlined),
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return 'Please enter your email';
                // Good-enough email check — a simple pattern, not RFC-perfect.
                final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text);
                return ok ? null : 'That email doesn\'t look right';
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _passwordController,
              focusNode: _passwordFocus,
              obscureText: true,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _confirmFocus.requestFocus(),
              decoration: fieldDecoration('Password', Icons.lock_outline),
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'At least 8 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _confirmController,
              focusNode: _confirmFocus,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              decoration: fieldDecoration('Confirm password', Icons.lock_outline),
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'Passwords don\'t match';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // A form-aware dropdown — it validates alongside the text fields.
            DropdownButtonFormField<String>(
              initialValue: _country,
              decoration: fieldDecoration('Country', Icons.public),
              items: const [
                DropdownMenuItem(value: 'eg', child: Text('Egypt')),
                DropdownMenuItem(value: 'us', child: Text('United States')),
                DropdownMenuItem(value: 'uk', child: Text('United Kingdom')),
                DropdownMenuItem(value: 'other', child: Text('Somewhere else')),
              ],
              onChanged: (value) => setState(() => _country = value),
              validator: (value) =>
                  value == null ? 'Please pick your country' : null,
            ),
            const SizedBox(height: 8),

            CheckboxListTile(
              value: _agreed,
              onChanged: (v) => setState(() => _agreed = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: const Text('I agree to the terms and conditions'),
            ),
            const SizedBox(height: 16),

            FilledButton(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Create account'),
            ),
            TextButton(
              onPressed: () {
                _formKey.currentState!.reset();
                setState(() {
                  _country = null;
                  _agreed = false;
                  _autovalidate = AutovalidateMode.disabled;
                });
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Where a valid form lands.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 96, color: Color(0xFF24D876)),
            const SizedBox(height: 16),
            Text(
              'Welcome, $name!',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('Your account is ready.'),
          ],
        ),
      ),
    );
  }
}
