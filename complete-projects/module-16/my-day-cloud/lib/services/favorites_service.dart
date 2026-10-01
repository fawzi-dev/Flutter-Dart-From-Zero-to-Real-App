import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/favorite_quote.dart';
import '../models/quote.dart';

/// The Module 16 challenge solution. Put this beside task_service.dart:
/// same structure, different nouns. Recognizing that was the exercise.
class FavoritesService {
  static final _db = FirebaseFirestore.instance;
  static String get _uid => FirebaseAuth.instance.currentUser!.uid;

  static Future<void> save(Quote quote) async {
    await _db.collection('favorites').add({
      'text': quote.text,
      'author': quote.author,
      'uid': _uid,
      'savedAt': FieldValue.serverTimestamp(),
    });
  }

  static Stream<List<FavoriteQuote>> watch() {
    return _db
        .collection('favorites')
        .where('uid', isEqualTo: _uid)
        .snapshots()
        .map((snap) => snap.docs.map(FavoriteQuote.fromDoc).toList());
  }

  static Future<void> remove(String id) =>
      _db.collection('favorites').doc(id).delete();
}
