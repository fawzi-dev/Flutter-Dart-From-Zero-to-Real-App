// End of lesson 11.4 P2 -- "The Model and fromJson".
//
// The Map now lives for exactly one line. Quote.fromJson reads it and hands
// back a real Dart object, and from then on everything is typed:
// quote.text, quote.author -- autocomplete, red squiggles, the lot.
//
// Notice the server calls it 'quote' and we call it `text`. They don't have
// to match. fromJson is the one place the two names meet.
//
// QuoteView is new too. It receives a Quote -- never a Map, never a response.
// A ListView rather than a Column, because some quotes are long enough to
// overflow a small phone.
//
// Everything is still in one file. 11.4 P3 files it into folders.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quote of the Day',
      home: QuoteScreen(),
    );
  }
}

/// One quote, as a proper Dart object.
class Quote {
  final int id;
  final String text;
  final String author;

  Quote({required this.id, required this.text, required this.author});

  /// A named constructor -- the same idea as `Image.asset` from 7.12.
  /// This is where JSON STOPS.
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] as int,
      text: json['quote'] as String,
      author: json['author'] as String,
    );
  }
}

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  Quote? quote;

  Future<void> fetchQuote() async {
    final url = Uri.parse('https://dummyjson.com/quotes/random');
    final response = await http.get(url);
    if (!mounted) return;

    if (response.statusCode != 200) {
      debugPrint('The server said no: ${response.statusCode}');
      return;
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    setState(() => quote = Quote.fromJson(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quote of the Day')),
      body: quote == null
          ? const Center(child: Text('Tap the button for a quote.'))
          : QuoteView(quote: quote!),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchQuote,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

/// The data, drawn. It receives a `Quote` -- never a Map, never a response.
class QuoteView extends StatelessWidget {
  const QuoteView({super.key, required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 60),
      children: [
        const Icon(Icons.format_quote, size: 48, color: Color(0xFFB9C6D8)),
        const SizedBox(height: 20),
        Text(
          quote.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            height: 1.45,
            fontStyle: FontStyle.italic,
            color: Color(0xFF16202C),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          quote.author.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 3,
            fontWeight: FontWeight.w600,
            color: Color(0xFF7A8697),
          ),
        ),
      ],
    );
  }
}
