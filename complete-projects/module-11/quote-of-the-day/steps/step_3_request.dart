// End of lesson 11.3 P2 -- "Your First Request".
//
// The freeze demo is gone. In its place: one button that asks a real server
// for a quote, and puts whatever comes back straight on the screen.
//
// What comes back is a wall of text. That is the point of this snapshot:
// response.body is a String. It LOOKS like data, and it isn't yet --
// response.body['quote'] is a compile error. 11.4 turns the text into Dart.
//
// Read every piece of the request:
//   as http          a nickname, so it reads http.get and not just get
//   Uri.parse(...)   http.get wants a Uri, not a String
//   await            the request takes time -- 11.2 exactly
//   statusCode       200 fine . 404 no such thing . 500 the server broke

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
  String body = 'Tap the button to ask the server.';

  Future<void> fetchQuote() async {
    final url = Uri.parse('https://dummyjson.com/quotes/random');
    final response = await http.get(url);
    if (!mounted) return;

    debugPrint('${response.statusCode}');

    // Anything but 200 means the body isn't the answer we asked for.
    if (response.statusCode != 200) {
      debugPrint('The server said no: ${response.statusCode}');
      return;
    }

    setState(() => body = response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quote of the Day')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(body),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchQuote,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
