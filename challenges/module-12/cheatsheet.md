# Cheat Sheet — Forms & Validation (Module 12)

## The three pieces
```dart
final _formKey = GlobalKey<FormState>();          // handle to the whole form

Form(
  key: _formKey,
  autovalidateMode: _autovalidate,                // disabled -> onUserInteraction
  child: ListView(                                // ListView, not Column (scroll + keyboard)
    children: [ /* TextFormFields */ ],
  ),
)

// check the whole form with ONE call:
if (_formKey.currentState!.validate()) { /* all fields returned null */ }
```

## A validator — null means valid
```dart
validator: (value) {
  if (value == null || value.trim().isEmpty) return 'Please enter your name';
  return null;                 // null = VALID (not '')
}
```
- Return a **String** → invalid, message shows in red under the field, automatically.
- Return **null** → valid. Never return `''`.

## The validators you'll reuse
```dart
// length
if (value == null || value.length < 8) return 'At least 8 characters';

// email (copy this)
final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value?.trim() ?? '');
if (!ok) return 'That email doesn\'t look right';

// cross-field: confirm password compares to the PASSWORD's controller
if (value != _passwordController.text) return 'Passwords don\'t match';

// optional-but-validated: empty is fine, non-empty must match
final t = value?.trim() ?? '';
if (t.isEmpty) return null;    // optional
// ...then the pattern check
```

## The input family — two groups
```dart
// GROUP 1: form-aware — has a validator, validate() covers it
DropdownButtonFormField<String>(
  initialValue: _country,
  items: const [DropdownMenuItem(value: 'eg', child: Text('Egypt'))],
  onChanged: (v) => setState(() => _country = v),
  validator: (v) => v == null ? 'Pick one' : null,
)

// GROUP 2: plain state — NO validator, YOU check it in submit()
CheckboxListTile(value: _agreed, onChanged: (v) => setState(() => _agreed = v ?? false),
  title: const Text('I agree'))
SwitchListTile(value: _on, onChanged: (v) => setState(() => _on = v), title: const Text('...'))
```
- **Ends in `FormField`** → inside the form, `validate()` checks it. **Plain `Checkbox`/`Switch`** → you check the bool by hand.

## Feel: keyboard + focus
```dart
final _emailFocus = FocusNode();
TextFormField(
  keyboardType: TextInputType.emailAddress,   // or .number / .phone
  obscureText: true,                          // passwords
  textInputAction: TextInputAction.next,      // last field: .done
  onFieldSubmitted: (_) => _emailFocus.requestFocus(),   // jump to next
  focusNode: _emailFocus,                     // on the field being jumped TO
)
```

## The good submit (silent, then live)
```dart
AutovalidateMode _autovalidate = AutovalidateMode.disabled;

void _submit() {
  final ok = _formKey.currentState!.validate();
  if (!ok || !_agreed) {                       // checkbox checked by hand
    setState(() => _autovalidate = AutovalidateMode.onUserInteraction);
    if (!_agreed) ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please accept the terms.')));
    return;
  }
  // success: navigate / save
}
```

## Don't forget
- **Dispose** every `TextEditingController` and `FocusNode` in `dispose()`.
- Write `dispose()` the moment you create the controller — not later.
- Good error messages say *what's wrong and how to fix it* — never "Invalid input".
