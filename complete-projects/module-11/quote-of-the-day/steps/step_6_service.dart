// End of lesson 11.4 P3 -- "The Service: Where JSON Stops".
//
// The app is filed now. Quote went to lib/models/, QuoteView to
// lib/widgets/, and the fetch went to lib/services/ as a static method --
// QuoteService.fetchRandom(). Those three files don't change again, so this
// snapshot imports them from lib/ and holds only the screen.
//
// Look at what the screen no longer imports: no http, no dart:convert. It
// asks for a Quote and gets one. A bad status code is no longer a
// debugPrint either -- the service THROWS, and 11.5 P2 catches it.
//
//   flutter run -t steps/step_6_service.dart

import 'package:flutter/material.dart';

import 'package:quote_of_the_day/models/quote.dart';
import 'package:quote_of_the_day/services/quote_service.dart';
import 'package:quote_of_the_day/widgets/quote_view.dart';

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
  Quote? quote;

  Future<void> fetchQuote() async {
    final result = await QuoteService.fetchRandom();
    if (!mounted) return;
    setState(() => quote = result);
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
