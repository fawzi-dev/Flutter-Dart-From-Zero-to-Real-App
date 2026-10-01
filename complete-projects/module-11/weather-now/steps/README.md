# Steps — Module 11, Weather Now (the solution)

| File | End of | What it adds |
|---|---|---|
| `step_1_chain.dart` | **11.7 P1** | Two chained calls and `CityNotFoundException`; everything printed, nothing drawn |
| `step_2_models.dart` | **11.7 P2** | `WeatherData` and the loop that turns three JSON arrays into a `List<HourForecast>` |
| `step_3_screen.dart` | **11.7 P3** | The trio, two catches, the search bar, and the sky from `gradientForCode` |
| `lib/` | **11.7 P4** | `WeatherView`, the hourly strip, `ErrorView` with Retry, pull-to-refresh |

The challenge asks for folders from the start, so the solution is filed from
its first line. Step 1 is the only flattened snapshot, because its service
isn't finished — it prints instead of returning. From step 2 on, the service
and models are final and the snapshots import them from `lib/`:

    flutter run -t steps/step_2_models.dart

## Fetch first, pixels last

Steps 1 and 2 have no weather UI at all, and that's the build order the brief
asks for. If step 2 prints eight hours of forecast, the data layer is proven.
Anything that goes wrong after that is a layout problem, and you know it.

## Two bugs worth reproducing

1. **The empty search** in `step_1_chain.dart`. Delete the
   `if (results == null || results.isEmpty)` check and tap *Try asdfgh*.
   `type 'Null' is not a subtype of type 'List<dynamic>'` — the crash that
   tells nobody anything. Put the check back and the same tap says
   `CityNotFoundException`.
2. **The catch order** in `step_3_screen.dart`. Move `catch (e)` above
   `on CityNotFoundException`, search "asdfgh", and read the wrong message.
   Dart tries catches top to bottom.

## Then the airplane-mode test

Run `lib/`, turn on airplane mode, relaunch. The error face and a Retry. Turn
it off, tap Retry, and the sky comes back. That sequence, with no crash, is
the rubric's first line.
