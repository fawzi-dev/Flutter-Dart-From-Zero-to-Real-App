# Cheat Sheet — Flutter Widgets & Layout (Modules 7–8)

One-page reference for the Flutter modules so far. Keep it open while you build.

## App skeleton
```dart
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('Title')),
      body: const Center(child: Text('Hello')),
    ),
  );
}
```

## Your own widget
```dart
class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Row(children: [Icon(icon), Text(text)]);
}
// use it:  InfoCard(icon: Icons.email_outlined, text: 'me@example.com')
```

## Text
```dart
Text('Hi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
  color: Colors.teal, letterSpacing: 2))
Text(long, maxLines: 2, overflow: TextOverflow.ellipsis)   // cut off with …
```

## Box: Container / Padding / SizedBox
```dart
Container(
  margin: const EdgeInsets.all(16),          // space OUTSIDE
  padding: const EdgeInsets.all(12),         // space INSIDE
  decoration: BoxDecoration(
    color: Colors.white,                     // color goes INSIDE decoration
    borderRadius: BorderRadius.circular(12),
    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
    // gradient: LinearGradient(colors: [a, b])   instead of color
    // shape: BoxShape.circle                     instead of borderRadius
  ),
  child: ...,
)
const SizedBox(height: 16)   // fixed empty space
```

## Row & Column
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,      // along the axis
  crossAxisAlignment: CrossAxisAlignment.stretch,   // across it
  children: [ ... ],
)
Row(mainAxisSize: MainAxisSize.min, children: [...])  // hug the children
```
- **Row:** main axis = horizontal. **Column:** main axis = vertical.
- `MainAxisAlignment.spaceBetween` pushes the first and last child to the edges.

## Expanded / Spacer (share space)
```dart
Row(children: [
  const Icon(Icons.event),                  // fixed
  Expanded(child: Text(title)),             // takes the rest
])
Row(children: [
  Expanded(flex: 2, child: A()),            // 2 shares
  Expanded(flex: 1, child: B()),            // 1 share
])
const Spacer()                               // eats the leftover space
```
- **Expanded must be a direct child of a Row or Column.**

## The mantra
> **Constraints go down. Sizes go up. The parent sets position.**
When a size is mysterious, ask: what constraint did the parent give, what size did the child pick?

## Stack (overlap)
```dart
Stack(children: [
  Base(),                                          // sets the Stack's size
  Positioned(top: 8, right: 8, child: Badge()),    // pinned on top of it
])
```

## Images & assets
```dart
Image.asset('assets/pic.png', fit: BoxFit.cover)
const CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/pic.png'))
```
```yaml
# pubspec.yaml (mind the indentation: spaces, never tabs)
flutter:
  assets:
    - assets/
```

## Safe and scrollable
```dart
SafeArea(                        // clear of the notch and the home bar
  child: SingleChildScrollView(  // scroll instead of overflowing
    child: Column(children: [...]),
  ),
)
```

## Fixing overflow (yellow/black stripes)
1. `Expanded` it   2. make it smaller   3. wrap in `SingleChildScrollView`
