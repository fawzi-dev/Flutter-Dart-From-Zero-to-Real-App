// Lesson 11.3 P2 -- the one-minute opener. 7.12 promised Image.network for
// Module 11; this is it. Run it with:
//   flutter run -t examples/lesson_03_p2_image_network.dart
//
// One line, and Flutter makes a request, waits for the response, and paints
// the picture when it arrives -- the whole of 11.2 and 11.3 P1, done for you.
// That's for pictures. For DATA, nobody does it for you: that's http.get.
//
// Not kept in the project. The quote screen replaces it straight away.

import 'package:flutter/material.dart';

void main() {
  // No const anywhere: Image.network can't be const, because the picture
  // isn't known while you type -- it arrives when the app runs.
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: Image.network('https://picsum.photos/600/400'),
      ),
    ),
  ));
}
