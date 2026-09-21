# Module 3 Quiz — Functions

Six questions. **Pass mark: 70% (5 of 6).**

## Questions

1. **(concept)** A function "does a job" versus a function that "answers a question." Which one is `void`, and which one `return`s a value?

2. **(code reading)** What does `main` print?
   ```dart
   int doubleIt(int n) => n * 2;
   void main() {
     print(doubleIt(doubleIt(5)));
   }
   ```

3. **(concept)** In `void greet({required String name, int times = 1})`, what do `required` and `= 1` each mean?

4. **(debugging)** A button in Module 9 will "fire the instant the screen builds" instead of on tap because of a bug you can meet *now*. What is different between passing `sayHello` and `sayHello()` to something?

5. **(code reading)** Does this compile? If not, why?
   ```dart
   String describe(int age) {
     if (age >= 18) {
       return 'adult';
     }
   }
   ```

6. **(concept)** Why is it better to `return` a computed value from a function than to `print` it inside the function?

---

## Answers & explanations

1. A **"do something"** function is **`void`** (it acts, returns nothing); a **"answer a question"** function **`return`s** a value. Being able to say which is which is the core skill of the module. (Lesson 3.2.)
2. **`20`.** Inner `doubleIt(5)` is 10, outer `doubleIt(10)` is 20. Arrow syntax `=>` is just a one-line function. (Lessons 3.2–3.3.)
3. **`required`** means the caller *must* provide `name`; **`= 1`** gives `times` a default so it's optional and defaults to 1. This is exactly Flutter's constructor syntax. (Lesson 3.4.)
4. **`sayHello`** passes the function itself (the recipe) to be called later; **`sayHello()`** *calls it right now* and passes its result. Handing `onPressed:` a called function fires it during build. (Lesson 3.6.)
5. **No.** If `age < 18` the function reaches the end without returning a `String`, but its signature promises one. Add a final `return 'minor';`. (Lesson 3.2.)
6. A function that `return`s can be **reused, tested, and combined** (its answer can be printed, stored, or fed into another function). One that prints can only ever print. Separating "compute" from "show" is what keeps code flexible. (Lessons 3.2, 3.7.)
