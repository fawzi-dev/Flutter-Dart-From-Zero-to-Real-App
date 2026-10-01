import 'package:flutter/material.dart';

import '../models/quote.dart';
import '../services/quote_service.dart';
import '../widgets/quote_view.dart';

/// The three-faced screen: loading, error, or data. Never a blank page, and
/// never a crash — including with the wi-fi switched off.
class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  // The trio. Two of them are nullable, and the nulls carry meaning:
  // `error` is null when there is no error; `quote` is null until we have one.
  bool isLoading = true;
  String? error;
  Quote? quote;

  @override
  void initState() {
    super.initState();
    // First load happens here, not in build — build can run many times.
    loadQuote();
  }

  Future<void> loadQuote() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final result = await QuoteService.fetchRandom();
      // The screen may be gone by the time a slow request comes back.
      if (!mounted) return;
      setState(() {
        quote = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        // Written for a human. Not "SocketException: Failed host lookup" —
        // users don't know what a host lookup is and can't fix one.
        error = "Couldn't reach the quote service. Check your connection.";
        isLoading = false;
      });
    }
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
    // Exactly one of three faces, chosen in this order. Loading wins, then
    // error, then data — so there is never a moment with nothing on screen.
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off, size: 64, color: Color(0xFF9AA5B4)),
              const SizedBox(height: 16),
              Text(
                error!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Color(0xFF5A6673)),
              ),
              const SizedBox(height: 20),
              // The SAME method, called again — not a copy of the fetch code.
              ElevatedButton(
                onPressed: loadQuote,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadQuote,
      child: QuoteView(quote: quote!),
    );
  }
}
