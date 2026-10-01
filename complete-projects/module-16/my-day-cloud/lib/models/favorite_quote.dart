import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteQuote {
  final String id;
  final String text;
  final String author;

  FavoriteQuote({required this.id, required this.text, required this.author});

  factory FavoriteQuote.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteQuote(
      id: doc.id,
      text: data['text'] as String? ?? '',
      author: data['author'] as String? ?? 'Unknown',
    );
  }
}
