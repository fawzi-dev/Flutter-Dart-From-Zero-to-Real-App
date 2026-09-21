# Module 11 Quiz — Async & APIs

Seven questions. **Pass mark: 70% (5 of 7).**

## Questions

1. **(concept)** Why must network calls be asynchronous — what happens if they aren't?
2. **(concept)** What does `await` actually do?
3. **(code reading)** The screen shows `Instance of 'Future<Weather>'`. What went wrong?
4. **(concept)** An API sends a JSON string. Why convert it into a `Weather` model instead of reading the Map directly in your widgets?
5. **(concept)** Name the three (or four) states every networked screen must handle.
6. **(debugging)** Offline, your app spins forever instead of showing an error. The `catch` block sets `error` but the spinner never stops. What line is missing?
7. **(concept)** Why the `if (!mounted) return;` after an `await` before calling `setState`?

---

## Answers & explanations

1. Because a synchronous network call **freezes the whole UI** while it waits (seconds, sometimes). Async lets the app stay alive and responsive during the wait. (Lesson 11.1.)
2. `await` **pauses this function** until the `Future` completes, then hands back its value — without blocking the rest of the app. (Lesson 11.2.)
3. A **missing `await`** — you displayed the Future itself instead of the value it will produce. (Lesson 11.2.)
4. So JSON messiness (`jsonDecode`, string keys, `as num`) lives in **one place** (`fromJson`), and the rest of the app reads typed fields. If the API changes, you fix one method, not fifty files. (Lesson 11.4.)
5. **Loading, error, and data** (and often **empty**). One visible at a time. (Lesson 11.5.)
6. **`isLoading = false;`** inside the `catch` — it must be set on *every* exit path (success and failure), or `build` keeps showing the spinner. (Lesson 11.8.)
7. Because the `await` took time and the screen may have been disposed meanwhile; calling `setState` on a gone widget throws. (Lesson 11.8.)
