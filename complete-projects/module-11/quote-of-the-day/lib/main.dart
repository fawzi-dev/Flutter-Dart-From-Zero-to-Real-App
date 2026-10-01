// Quote of the Day — the project you build across Module 11.
//
//   11.3 P2  the first request: a status code and a wall of JSON
//   11.4      jsonDecode, then Quote.fromJson, then a service — where JSON stops
//   11.5      loading, then error: the trio, Retry, and pull-to-refresh
//
// The one test that matters: turn the wi-fi off and launch it. A friendly
// message and a working Retry — no crash, no blank screen.

import 'package:flutter/material.dart';

import 'screens/quote_screen.dart';

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
