import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';

/// The quote-of-the-day hero. Its OWN StatefulWidget on purpose: if the quote
/// fails to load, the task list keeps working. Each piece owns only the state
/// it needs.
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
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.primary, Color(0xFF8B94FF)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: error != null ? load : null,
        child: SizedBox(width: double.infinity, child: buildContent()),
      ),
    );
  }

  Widget buildContent() {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
        ),
      );
    }

    if (error != null) {
      return Row(
        children: [
          const Icon(Icons.refresh, size: 20, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(error!, style: const TextStyle(color: Colors.white)),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.format_quote, color: Colors.white70, size: 28),
        const SizedBox(height: 4),
        Text(quote!.text, style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.4)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('— ${quote!.author}', style: const TextStyle(color: Colors.white70, fontSize: 13)),
            TextButton.icon(
              icon: const Icon(Icons.refresh, size: 20, color: Colors.white),
              onPressed: load,
              label: const Text('New quote', style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
          ],
        ),
      ],
    );
  }
}
