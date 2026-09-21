# Cheat Sheet — Flutter Widgets & Layout (Modules 7–8)

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
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    ),
  );
}
```

## Text
```dart
Text('Hi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
  color: Colors.teal, letterSpacing: 2, decoration: TextDecoration.lineThrough))
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
  ),
  child: ...,
)
const SizedBox(height: 16)   // fixed empty space (spacer)
```

## Row & Column
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,      // along the axis
  crossAxisAlignment: CrossAxisAlignment.stretch,   // across it
  children: [ ... ],
)
```
- **Row:** main axis = horizontal. **Column:** main axis = vertical.

## Expanded / Flexible (share space)
```dart
Row(children: [
  const Icon(Icons.search),                 // fixed
  Expanded(child: TextField()),             // takes the rest
  Expanded(flex: 2, child: A()),            // 2 shares
  Expanded(flex: 1, child: B()),            // 1 share
])
```
- **Expanded must be a direct child of Row/Column/Flex.**

## The mantra
> **Constraints go down. Sizes go up. The parent sets position.**
When a size is mysterious, ask: what constraint did the parent give, what size did the child pick?

## Stack (overlap)
```dart
Stack(children: [ Base(), Positioned(top: 0, right: 0, child: Badge()) ])
```

## Images & assets
```dart
Image.asset('assets/pic.png')
const CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/pic.png'))
```
```yaml
# pubspec.yaml (mind the indentation!)
flutter:
  assets:
    - assets/pic.png
```

## Fixing overflow (yellow/black stripes)
1. `Expanded` it   2. make it smaller   3. wrap in `SingleChildScrollView`
