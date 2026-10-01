// End of lesson 11.4 P1 -- "jsonDecode: Text Becomes a Map".
//
// One new import and one new line, and the wall of text turns into a Map --
// Module 4's Map, exactly as 4.4 promised. data['quote'] is the quote itself.
//
// But hover over `data`: dynamic. Dart has no idea what's inside, so it
// can't help you. Misspell the key -- data['qoute'] -- and nothing turns
// red. You find out at runtime, when the value comes back null.
//
// That is the problem 11.4 P2 solves.

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

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String text = 'Tap the button for a quote.';

  Future<void> fetchQuote() async {
    final url = Uri.parse('https://dummyjson.com/quotes/random');
    final response = await http.get(url);
    if (!mounted) return;

    if (response.statusCode != 200) {
      debugPrint('The server said no: ${response.statusCode}');
      return;
    }

    final data = jsonDecode(response.body);
    debugPrint('$data'); // print the shape first, every time

    setState(() => text = data['quote']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quote of the Day')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(text, style: const TextStyle(fontSize: 22)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchQuote,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
