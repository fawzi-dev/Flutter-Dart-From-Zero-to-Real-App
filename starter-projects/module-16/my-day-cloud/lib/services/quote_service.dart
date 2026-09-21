import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/quote.dart';

class QuoteService {
  static const _url = 'https://dummyjson.com/quotes/random';

  static Future<Quote> fetchRandom() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode != 200) {
      throw Exception('Server returned ${response.statusCode}');
    }

    return Quote.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
