# Module 5 Quiz — Classes, Objects & Null Safety

Seven questions. **Pass mark: 70% (5 of 7).**

## Questions

1. **(concept)** In one sentence each: what is a **class**, and what is an **object**?

2. **(code reading)** What prints?
   ```dart
   class Dog {
     final String name;
     Dog({required this.name});
     String speak() => '$name says woof';
   }
   void main() => print(Dog(name: 'Rex').speak());
   ```

3. **(concept)** What does the `?` in `String? note` communicate to you and to the compiler?

4. **(concept)** When should you reach for `??` and when for `!`? Why is `!` described as "a last resort"?

5. **(code reading)** `name` is `String?` and might be null. Rewrite `print(name.length)` so it can't crash, printing `0` when name is null.

6. **(concept)** You have a fixed set of options: low, medium, high. Why is an `enum Priority` better than using the strings `'low'`, `'medium'`, `'high'`?

7. **(debugging)** `readLineSync()` returns `String?`. Why does Dart force you to write `?? ''` after it before you can use it as a normal `String`?

---

## Answers & explanations

1. A **class** is a blueprint (the definition of what a Dog *is* and can *do*); an **object** is one actual thing built from that blueprint (`Dog(name: 'Rex')`). (Lesson 5.1.)
2. **`Rex says woof`.** The object is created with a named required parameter, and `speak()` reads its field. Note `Question(text: ...)` is the same shape as a Flutter `Text(...)`. (Lesson 5.2.)
3. It means the value **can be null** ("there might be no note"). The compiler then forces you to handle the null case before using it — the billion-dollar mistake, prevented. (Lesson 5.5.)
4. Use **`??`** to supply a safe fallback (`name ?? 'Anonymous'`). Use **`!`** only when you can *say out loud* why the value can't be null right there. `!` is a last resort because it *removes* the compiler's protection — if you're wrong, it crashes. (Lesson 5.5.)
5. **`print(name?.length ?? 0);`** — `?.` reads length only if name isn't null, and `??` supplies `0` if it is. (Lesson 5.5.)
6. An enum is a **fixed, checked menu**: the compiler catches typos and can prove a `switch` handled every case. `'hgih'` as a string is a silent bug; `Priority.hgih` won't compile. (Lesson 5.4.)
7. Because input can genuinely **end** (piped file runs out, Ctrl-D) and return null — so the type is `String?`. Dart won't let you use a possibly-null value as a non-null `String` until you deal with it; `?? ''` is you dealing with it. (Lesson 5.5.)
