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
class Weather {
  final double temp; final int code;
  Weather({required this.temp, required this.code});
  factory Weather.fromJson(Map<String, dynamic> j) => Weather(
    temp: (j['temperature'] as num).toDouble(),   // num->double: JSON gotcha
    code: j['weathercode'] as int,
  );
}
// array -> List: for (var i...) list.add(Model.fromJson(items[i]));
```

## The loading / error / data trio
```dart
bool isLoading = true;  String? error;  Weather? data;

@override
void initState() { super.initState(); load(); }

Future<void> load() async {
  setState(() { isLoading = true; error = null; });
  try {
    final result = await Service.fetch();
    if (!mounted) return;                        // screen still alive?
    setState(() { data = result; isLoading = false; });
  } catch (e) {
    if (!mounted) return;
    setState(() { error = 'Could not connect.'; isLoading = false; });  // BOTH set here
  }
}

Widget build(context) {
  if (isLoading) return const CircularProgressIndicator();
  if (error != null) return ErrorView(message: error!, onRetry: load);
  return DataView(data: data!);                  // '!' justified: both cases returned
}
```
- Service lives in `services/` — **no `http` import in a screen file.**
- Always test **airplane mode**: friendly error + working Retry, never a crash.
