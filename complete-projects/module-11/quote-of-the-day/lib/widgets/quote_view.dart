import 'package:flutter/material.dart';

import '../models/quote.dart';

/// The data state. It receives a `Quote` — never a Map, never a response.
class QuoteView extends StatelessWidget {
  const QuoteView({super.key, required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    // ListView rather than Column: a long quote on a small phone would
    // overflow a Column (11.4 P2), and pull-to-refresh needs something that
    // scrolls (11.5 P2).
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
