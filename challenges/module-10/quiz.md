# Module 10 Quiz — Lists & Navigation

Seven questions. **Pass mark: 70% (5 of 7).**

## Questions

1. **(concept)** Why use `ListView.builder` instead of a `Column` full of children for a long list?
2. **(code reading)** What's wrong with using `key: ValueKey(index)` on a `Dismissible`?
3. **(concept)** The add screen builds a new item and calls `Navigator.pop(context, item)`. Where should the list actually live, and why?
4. **(debugging)** After returning from the add screen the app crashes/warns: `push` returns `GroceryItem?`. What one line fixes both the "user pressed back" case and the type error?
5. **(concept)** Why compute the "items bought" count *inside* `build` rather than storing it in a variable you update by hand?
6. **(concept)** What does the multi-file split (`models/ screens/ widgets/`) buy you, and when does a file "earn its place"?
7. **(concept)** You started to feel the pain of passing data through several screens' constructors. What is that pain called, and what fixes it *later* (not now)?

---

## Answers & explanations

1. `ListView.builder` **only builds the items currently on screen**, so a 10,000-item list is as cheap as a 10-item one. A Column builds everything at once. (Lesson 10.1.)
2. Keying by **index** means when an item is removed, the keys shift and Flutter deletes the *wrong* tile. Key by the **item** (`ValueKey(item)`). (Lesson 10.4.)
3. In the **list screen's State** — the screen that owns and displays the data. The add screen just makes an item and pops it back; it owns nothing. (Lessons 10.3, 10.6.)
4. **`if (newItem == null) return;`** — `push` is nullable because the user might back out, and this handles the null before you use it. (Lesson 10.10.)
5. Because a value derived in `build` **can never go stale** — it's recomputed every rebuild from the source of truth. Hand-maintained counts drift. (Lesson 10.10.)
6. It keeps each concern in its own place and lets pieces be **shared** (e.g. one `app_colors.dart` imported everywhere). A file earns its place when something is used in more than one spot. (Lessons 10.7, 10.9.)
7. **Prop drilling** — threading data through screens that don't care. It's fixed by **state management** (Provider/Riverpod/Bloc) in the intermediate course — and it only makes sense *after* you've felt it. (Lesson 10.10.)
