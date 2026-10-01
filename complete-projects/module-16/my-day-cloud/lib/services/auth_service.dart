import 'package:firebase_auth/firebase_auth.dart';

/// The whole authentication system. Firebase handles password hashing,
/// session tokens and refresh — the parts that are genuinely easy to get wrong.
class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> logIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> logOut() => _auth.signOut();

  static Stream<User?> authStateChanges() => _auth.authStateChanges();

  static User? get currentUser => _auth.currentUser;
}

/// Firebase error codes are for machines. Users need sentences.
String messageForAuthCode(String code) {
  switch (code) {
    case 'invalid-email':
      return "That email address doesn't look right.";
    case 'email-already-in-use':
      return 'An account with that email already exists. Try logging in.';
    case 'weak-password':
      return 'Password should be at least 6 characters.';
    // Deliberately identical: saying which one was wrong tells an attacker
    // which email addresses are registered.
    case 'user-not-found':
    case 'wrong-password':
    case 'invalid-credential':
      return 'Email or password is incorrect.';
    case 'network-request-failed':
      return 'No internet connection.';
    default:
      return 'Something went wrong. Please try again.';
  }
}
