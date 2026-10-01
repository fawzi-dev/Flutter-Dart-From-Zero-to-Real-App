# Steps — Module 11, Quote of the Day

| File | End of | What it adds |
|---|---|---|
| `step_1_frozen.dart` | **11.1** | **Deliberately frozen.** `sleep()` kills the app for four seconds. |
| `../examples/lesson_02_p1_future.dart` | **11.2 P1** | DartPad: `Future<String>`, `async`, `await` — and the missing-await buzzer |
| `../examples/lesson_02_p2_order.dart` | **11.2 P2** | DartPad: `await` pauses its own function, not the program |
| `step_2_async.dart` | **11.2 P3** | The same wait, and the app stays alive. Plus `if (!mounted) return;` |
| `../examples/lesson_03_p2_image_network.dart` | **11.3 P2** | The opener: `Image.network`, the request you already made in 7.12 |
| `step_3_request.dart` | **11.3 P2** | `http.get` on a real server; the raw body on screen, as a String |
| `step_4_decode.dart` | **11.4 P1** | `jsonDecode` — the text becomes a Map, and `data['quote']` works |
| `../examples/lesson_04_p2_numbers.dart` | **11.4 P2** | `dart run` it: the `as num` trap. Not in DartPad, which does not throw |
| `step_5_model.dart` | **11.4 P2** | `Quote` + `Quote.fromJson`, and a `QuoteView` that takes a `Quote` |
| `step_6_service.dart` | **11.4 P3** | Filed into folders; the fetch becomes `QuoteService.fetchRandom()` and throws |
| `step_7_loading.dart` | **11.5 P1** | `initState`, `isLoading`, a spinner — and it breaks offline, on purpose |
| `lib/` | **11.5 P2** | `try`/`catch`, the error face with Retry, pull-to-refresh |

**11.3 P1 has no snapshot.** It happens in a browser: an API is a URL that
returns data, and nothing in the project changes.

## Run step 1. Do not skip it.

`step_1_frozen.dart` is the most useful file here. Tap **Load**, then tap the
counter. Nothing. Then every queued tap fires at once when the freeze ends.

Reading "your app runs on one thread" is not the same as watching your own app
die for four seconds. Run it, feel it, then run step 2 and feel the difference.

## Steps 1 to 5 are one file. Steps 6 and 7 are not.

Until 11.4 P3 the whole app lives in `main.dart`, so each snapshot is the whole
app. 11.4 P3 files it into `models/`, `services/` and `widgets/`, and those
three files never change again. From then on a snapshot only needs to hold the
screen, and it imports the rest from `lib/`:

    flutter run -t steps/step_6_service.dart

## The structure, and why it grew

`lib/` has four folders by the end — `models`, `screens`, `services`, `widgets`.
The one worth noticing is **`services/`**: 10.7 said it would arrive "when
there's actually a network call to put in it", and this is that call. No screen
in the app imports `http`. A screen asks `QuoteService.fetchRandom()` for a
Quote and gets one, or gets an exception.

## Break step 7 on purpose

Turn on airplane mode and launch `step_7_loading.dart`. The spinner turns
forever and the console says `Unhandled Exception`. That is the third state,
arriving uninvited — and it is exactly what 11.5 P2 fixes.

Then run `lib/` the same way: a sentence a human can read, and a Retry that
works when the wi-fi comes back.
