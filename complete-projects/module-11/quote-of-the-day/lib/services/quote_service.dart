import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/quote.dart';

/// Everything that knows about the network lives here.
///
/// No screen in this app imports `http` or `dart:convert`. 10.7 promised this
/// folder "when there's actually a network call to put in it" — this is that
/// call, and keeping it here is a rubric line in the challenge.
class QuoteService {
  // The one `static final` that 8.4 promised. A Uri can't be written as a
  // literal, so it can't be const; it is worked out once, when the app runs.
  static final _url = Uri.parse('https://dummyjson.com/quotes/random');

  // A static METHOD: it belongs to the class, so you call it on the class —
  // QuoteService.fetchRandom() — without building a QuoteService first.
  static Future<Quote> fetchRandom() async {
    final response = await http.get(_url);

    // Check the status BEFORE parsing. A 500's body isn't the JSON you
    // expect, and parsing it explodes far away from the actual cause.
    if (response.statusCode != 200) {
      throw Exception('Quote service returned ${response.statusCode}');
    }

    return Quote.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
