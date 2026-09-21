# Module 9 Quiz — State

Seven questions. **Pass mark: 70% (5 of 7).**

## Questions

1. **(concept)** What does calling `setState()` actually tell Flutter to do?
2. **(concept)** Why does changing an ordinary variable on a tap sometimes *not* update the screen?
3. **(code reading)** Will the counter update? Why or why not?
   ```dart
   void increment() {
     count++;
     setState(() {});
   }
   ```
4. **(concept)** When do you need a `StatefulWidget` instead of a `StatelessWidget`?
5. **(debugging)** A button's handler fires the instant the screen appears, before any tap. What was written?
   ```dart
   ElevatedButton(onPressed: doThing(), child: ...)
   ```
6. **(concept)** For a `TextField`, why create the `TextEditingController` as a field of the State class rather than inside `build`?
7. **(concept)** Switch, Slider, Dropdown, SegmentedButton — what single pattern do they all share?

---

## Answers & explanations

1. It tells Flutter: **the data changed — re-run `build()`** so the screen matches the new data. (Lesson 9.3.)
2. Because the screen only redraws when you call `setState`. Changing the variable updates the *data* but never asks for a rebuild, so the old UI stays. (Lesson 9.2.)
3. **Yes.** `count` changed and `setState` requested a rebuild — that's all Flutter needs. (Putting the change *inside* the `setState` closure is the more common style, but this works.) (Lesson 9.3.)
4. When the screen **changes over time** in response to interaction — anything that needs to hold and update data. Stateless never changes after it's built. (Lesson 9.3.)
5. `onPressed: doThing()` **calls** `doThing` during build and passes its result. Pass the function itself: `onPressed: doThing`. The Module 3.6 bug, in Flutter. (Lesson 9.1.)
6. A field is created **once**; inside `build` it would be recreated on every rebuild, throwing away whatever the user typed. (Lesson 9.5.)
7. **value + onChanged**: you give it the current value and a callback that `setState`s the new one. Learn one, you know all. (Lesson 9.6.)
