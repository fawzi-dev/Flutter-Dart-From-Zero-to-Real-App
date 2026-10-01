// End of lesson 8.4 -- "Where a Value Lives: const and static".
//
// No layout changes at all. The colours move out of the top of the file and
// onto a class, which is the first time static appears in this course.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Five colours with a surname. One copy, kept on the class -- there is never
// a reason to write AppColors(), and that is the point of static.
class AppColors {
  static const surface = Color(0xFFF4F1EC);
  static const ink = Color(0xFF141220);
  static const red = Color(0xFFD8584A);
  static const blue = Color(0xFF4A7FB5);
  static const gold = Color(0xFFE0A33E);

  // Uncomment both lines. The second one will not compile:
  //   The instance member 'favourite' can't be accessed in an initializer.
  // favourite needs an AppColors object before it means anything. copy is
  // asking for it before any object exists. That is the whole of static.
  // final Color favourite = red;
  // static const copy = favourite;
}

// The spacing scale. Three numbers, and no raw ones anywhere else.
const kGapS = 8.0;
const kGapM = 16.0;
const kGapL = 24.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlaygroundScreen(),
    );
  }
}

class PlaygroundScreen extends StatelessWidget {
  const PlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('const & static'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kGapL),
        child: Row(
          children: const [
            Expanded(child: ColorCard(title: 'One', color: AppColors.red)),
            SizedBox(width: kGapS),
            Expanded(child: ColorCard(title: 'Two', color: AppColors.blue)),
            SizedBox(width: kGapS),
            Expanded(child: ColorCard(title: 'Three', color: AppColors.gold)),
          ],
        ),
      ),
    );
  }
}

// =========================================================== THE COMPONENT ==
// One widget, reused for the whole module. A coloured box with a word in the
// middle of it. Give it a title and a colour -- that is the whole thing.
//
// Nothing below this line changes from lesson to lesson.

class ColorCard extends StatelessWidget {
  const ColorCard({
    super.key,
    required this.title,
    required this.color,
    this.width,
    this.height,
  });

  final String title;
  final Color color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      // The two factors keep the card hugging its word when nothing is
      // forcing a size on it, and centre the word when something is.
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
