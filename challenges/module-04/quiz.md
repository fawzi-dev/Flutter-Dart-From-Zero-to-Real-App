# Module 4 Quiz — Lists & Maps

Six questions. **Pass mark: 70% (5 of 6).**

## Questions

1. **(concept)** A list has 5 items. What are the valid index numbers, and what happens if you ask for index `5`?

2. **(code reading)** What prints?
   ```dart
   final scores = [10, 20, 30];
   scores.add(40);
   print(scores.length);
   print(scores[1]);
   ```

3. **(concept)** You need to look something up *by name* (e.g. a word's count). Is a `List` or a `Map` the right tool, and why?

4. **(code reading)** What's the type and value of `doubled`?
   ```dart
   final nums = [1, 2, 3];
   final doubled = nums.map((n) => n * 2).toList();
   ```

5. **(debugging)** A student writes `final doubled = nums.map((n) => n * 2);` and then tries to use `doubled[0]`. It won't compile. What did they forget?

6. **(concept)** Why is a `List<Question>` (each question owning its answer) safer than two parallel lists — a list of questions and a separate list of answers?

---

## Answers & explanations

1. **0, 1, 2, 3, 4.** Indexing is zero-based, so a 5-item list stops at index 4. Index `5` throws a `RangeError` — a precise, helpful error. (Lesson 4.1.)
2. **`4`** then **`20`.** `add` made the length 4; index `1` is the *second* item, `20`. (Lesson 4.1.)
3. **A `Map`.** When you look something up by a key instead of a position, a Map is the right tool — direct lookup beats searching a list. (Lesson 4.4.)
4. **`List<int>`, value `[2, 4, 6]`.** `.map` transforms each item; `.toList()` turns the result back into a usable list. (Lesson 4.5.)
5. **`.toList()`.** `.map` returns a lazy iterable, not a list — you can't index it until you call `.toList()`. The classic gotcha from lesson 4.5.
6. Parallel lists are correct **only by coincidence of order** — sort or edit one and they silently desync, giving wrong answers with no error. Bundling each question with its answer makes desync *impossible*. (Lesson 4.6 → Module 5.)
