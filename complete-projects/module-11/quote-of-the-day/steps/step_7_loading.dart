// End of lesson 11.5 P1 -- "Loading: Never a Blank Screen".
//
// Two of the three states. The quote arrives on its own now -- initState
// starts the first load, before anyone taps anything -- and while it's on
// its way the user sees a spinner, not a blank page.
//
// The lesson ENDS on purpose with this file broken. Turn on airplane mode
// and launch it: the spinner turns forever, and the console says
// "Unhandled Exception". fetchRandom threw, nobody caught it, and
// isLoading never went back to false. That's the third state, and 11.5 P2
// is where it gets handled.
//
//   flutter run -t steps/step_7_loading.dart

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
  bool isLoading = true;
  Quote? quote;

  @override
  void initState() {
    super.initState();
    // First load happens here, not in build -- build can run many times.
    loadQuote();
  }

  Future<void> loadQuote() async {
    setState(() => isLoading = true);

    final result = await QuoteService.fetchRandom();
    if (!mounted) return;
    setState(() {
      quote = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quote of the Day')),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        // null while a request is in flight: one question at a time.
        onPressed: isLoading ? null : loadQuote,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return QuoteView(quote: quote!);
  }
}
