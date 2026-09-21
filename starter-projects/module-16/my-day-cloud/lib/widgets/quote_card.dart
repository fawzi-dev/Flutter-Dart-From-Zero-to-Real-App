import 'package:flutter/material.dart';

import '../models/quote.dart';
import '../services/quote_service.dart';

/// Its own StatefulWidget on purpose: when the quote fails, the task list
/// keeps working. Each piece owns only the state it needs.
class QuoteCard extends StatefulWidget {
  const QuoteCard({super.key});

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  bool isLoading = true;
  String? error;
  Quote? quote;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final result = await QuoteService.fetchRandom();
      if (!mounted) return;
      setState(() {
        quote = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = "Couldn't load today's quote — tap to retry";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: InkWell(
        onTap: error != null ? load : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (error != null) {
      return Row(
        children: [
          const Icon(Icons.refresh, size: 20, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(error!, style: const TextStyle(color: Colors.grey)),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '"${quote!.text}"',
          style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
        ),
        const SizedBox(height: 8),
        Text(
          '— ${quote!.author}',
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ],
    );
  }
}
