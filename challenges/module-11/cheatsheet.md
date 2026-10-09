# Cheat Sheet — Async & APIs (Module 11)

## Future / async / await
```dart
Future<String> fetchName() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Sam';
}
final name = await fetchName();   // pause here, don't freeze the app
```
- Forgot `await`? You'll see `Instance of 'Future<...>'` on screen.

## HTTP + JSON
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

final res = await http.get(Uri.parse(url));
if (res.statusCode != 200) throw Exception('Server ${res.statusCode}');
final map = jsonDecode(res.body) as Map<String, dynamic>;   // object
final list = jsonDecode(res.body) as List;                   // array
```

## Model with fromJson (raw JSON stops here)
```dart
class Quote {
  final int id;
  final String text;
  final String author;
  Quote({required this.id, required this.text, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] as int,
      text: json['quote'] as String,      // their name -> your name
      author: json['author'] as String,
    );
  }
}
// A number that could have decimals: (json['price'] as num).toDouble()
```

## The service (the wall JSON stops at)
```dart
class QuoteService {
  static final _url = Uri.parse('https://dummyjson.com/quotes/random');

  static Future<Quote> fetchRandom() async {
    final response = await http.get(_url);
    if (response.statusCode != 200) {
      throw Exception('Quote service returned ${response.statusCode}');
    }
    return Quote.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
// Call it on the class: QuoteService.fetchRandom()
```

## The loading / error / data trio
```dart
bool isLoading = true;  String? error;  Quote? quote;

@override
void initState() { super.initState(); loadQuote(); }

Future<void> loadQuote() async {
  setState(() { isLoading = true; error = null; });
  try {
    final result = await QuoteService.fetchRandom();
    if (!mounted) return;                        // screen still alive?
    setState(() { quote = result; isLoading = false; });
  } catch (e) {
    if (!mounted) return;
    setState(() {
      error = "Couldn't reach the quote service. Check your connection.";
      isLoading = false;                         // EVERY way out sets this
    });
  }
}

Widget buildBody() {
  if (isLoading) return const Center(child: CircularProgressIndicator());
  if (error != null) return Center(child: Text(error!));  // + Retry: onPressed: loadQuote
  return QuoteView(quote: quote!);               // '!' is safe: both other cases returned
}
```

## A problem with its own name (the challenge)
```dart
class CityNotFoundException implements Exception {}

try {
  ...
} on CityNotFoundException {     // specific first
  ...
} catch (e) {                    // general last
  ...
}
```
- Parallel JSON arrays (`time[i]`, `temperature_2m[i]` describe the same hour): one `for` loop reads across them into a `List` of models.
- Service lives in `services/` — **no `http` import in a screen file.**
- Always test **airplane mode**: friendly error + working Retry, never a crash.
