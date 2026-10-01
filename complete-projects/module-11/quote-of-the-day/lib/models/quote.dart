/// One quote, as a proper Dart object.
///
/// Note the field is called `text` while the JSON key is `'quote'`. They do
/// not have to match: the server names things its way, you name things your
/// way, and `fromJson` is the one place the two are introduced to each other.
class Quote {
  final int id;
  final String text;
  final String author;

  Quote({required this.id, required this.text, required this.author});

  /// A named constructor — the same idea as `Image.asset` from 7.12. A class
  /// can have more than one way to be built.
  ///
  /// This is where JSON STOPS. Past this line, nothing in the app knows what
  /// a Map is, and no widget ever contains the string 'quote'.
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] as int,
      text: json['quote'] as String,
      author: json['author'] as String,
    );
  }
}
