# Challenge — Weather Now

Your first app that talks to the internet — searchable, and it never shows a blank screen or crashes offline. The loading/error/data trio you build here is in every networked app you will ever write.

**Starter:** `starter-projects/module-11/weather-now/` — empty Scaffold, `http` package pre-added.

## The APIs (keyless — no signup)
Turning a typed city name into weather takes **two chained calls** — the answer of the first feeds the second:
```
1. Geocode:  https://geocoding-api.open-meteo.com/v1/search?name=Cairo&count=1
             → gives you { latitude, longitude, name }
2. Forecast: https://api.open-meteo.com/v1/forecast?latitude=..&longitude=..
             &current_weather=true&hourly=temperature_2m,weathercode
             &daily=temperature_2m_max,temperature_2m_min&timezone=auto&forecast_days=2
```
The forecast returns `current_weather`, a `daily` high/low, and **`hourly` as parallel arrays** (`time[]`, `temperature_2m[]`, `weathercode[]`) — item `i` of each list is the same hour. `forecast_days=2` because at 10pm "the next 8 hours" runs into tomorrow.

Open both URLs in a browser before you write any code, and try `name=asdfgh` too: the geocode answer has **no `results` key at all**.

## The product
One screen: a **search bar** at the top over a **full-screen gradient sky that changes with the weather**, and below it exactly one of three faces:
1. **Loading:** a centered spinner while fetching
2. **Error:** a friendly message + a Retry button that actually retries — and a *specific* message when the city just isn't found ("Couldn't find 'Xyz'")
3. **Data:** city name, temperature large and proud (`31°`), a condition icon + label, a today high/low + wind line, and a **horizontal hourly strip** (the next several hours)

Plus **pull-to-refresh** on the data view.

## Requirements
1. Models in `models/`: a `WeatherData` (city, temp, wind, code, high, low, and a `List<HourForecast>`) and an `HourForecast` (time, temp, code). `WeatherData.fromJson` does all the JSON work — including **looping the hourly arrays into the list**. The UI never sees a raw Map.
2. A `WeatherService.fetchForCity(String city)` in `services/` that makes **both** calls in order; **no `http` import in any screen file**. Throw a named `CityNotFoundException` when geocoding returns no results.
3. State = the trio from 11.5 (`isLoading`, `error`, `weather`); first load in `initState`; guard `setState` with `if (!mounted) return;` after each `await` (11.2 P3).
4. `try/catch` around the fetch, with a **specific catch** for `CityNotFoundException` (specific message) and a general catch for everything else. Non-200 = error too.
5. Weathercode → icon, label, **and the sky gradient** are plain Dart functions (in a `widgets/` visuals file). Codes 0–1 clear, 2–48 cloudy, 51+ rainy is plenty.
6. `RefreshIndicator` for pull-to-refresh, reloading the current city.

## Handed over
Four pieces of syntax this challenge needs that 11.1–11.5 didn't teach. Use them freely; the solution videos explain each one.

| Syntax | What it means | Explained in |
|---|---|---|
| `class CityNotFoundException implements Exception {}` | A problem with its own name, so it can be thrown and caught on its own. `implements Exception` marks it as a problem type. | 11.7 P1 |
| `on CityNotFoundException { ... }` above `catch (e) { ... }` | Catches only that one type. Dart tries catches top to bottom, so the specific one goes first. | 11.7 P3 |
| `geoData['results'] as List?` | "A List, or missing." Check it for `null` (and empty) on the next line. | 11.7 P1 |
| `DateTime.parse('2026-09-28T21:00')` and `.hour` | Turns the API's time text into a `DateTime`; `.hour` is `21`. | 11.7 P2 |

Optional polish: `textInputAction: TextInputAction.search` (a search key on the keyboard) and `FocusScope.of(context).unfocus()` (close the keyboard after searching). Module 12 L5 owns keyboards and focus; copy them if you want them.

Already yours: `scrollDirection: Axis.horizontal` (8.5 — it works on `ListView.builder` too, inside a `SizedBox` with a height), `LinearGradient` (Module 7), `(x as num).toDouble()` (11.4 P2).

## Rubric
- [ ] **The airplane-mode test:** networking off, launch → friendly error + working Retry; back on, retry → data. No crash at ANY point
- [ ] Search a nonsense city ("asdfgh") → the *specific* "couldn't find" message, not a generic error
- [ ] The hourly strip is built from the **parsed array** — a `List<HourForecast>` in a horizontal `ListView.builder`, not hand-typed
- [ ] UI code contains zero JSON keys — only `weather.temperature`, `hour.time`, etc.
- [ ] `await` used correctly — if you ever see `Instance of 'Future<...>'` on screen, you know exactly what happened (11.2)

## Hints (gated)
- **Order:** service first — `print` the geocode body, then the forecast body — before you build a single widget. Network code first, pixels last. Then models, then the screen.
- **The chain:** `await` the geocode call, pull `latitude`/`longitude` out of `results.first`, and only then build the forecast URL. One request's answer becomes the next request's input.
- **The array loop:** `hourly['time']` is a `List`. Read the three parallel lists, then `for (var i = ...) forecasts.add(HourForecast(...))`. The arrays start at midnight, so start `i` at the current hour (`DateTime.parse(current['time'] as String).hour`) and take 8.
- **The gradient is derived:** a `gradientForCode(int)` returning a `LinearGradient` — the sky is a value mapped to something visual, exactly like the BMI scale's marker.

## Bonus
Highlight the "Now" card in the hourly strip (a brighter background for `index == 0`). One `bool` passed into the hour widget — clean model, cheap feature.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 2 hours. Reference: `complete-projects/module-11/weather-now/`.
