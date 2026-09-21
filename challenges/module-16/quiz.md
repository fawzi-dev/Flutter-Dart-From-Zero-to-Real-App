# Module 16 Quiz — Firebase (Auth + Firestore)

Seven questions. **Pass mark: 70% (5 of 7).**

## Questions

1. **(concept)** What does local storage (Module 15) *not* give you that a backend does?
2. **(concept)** A `Future` gives one value later; what does a **Stream** give you, and which does `authStateChanges()` return?
3. **(concept)** What replaces `FutureBuilder` for realtime Firestore data, and how much code turns a one-time read into a live one?
4. **(code reading)** After moving tasks to Firestore, what disappeared from the home screen's State?
5. **(concept)** In a security rule, what's the difference between `resource.data` and `request.resource.data`, and why must `create` check the second one?
6. **(concept)** Why is "test mode" (allow all reads/writes) a trap for a real app?
7. **(concept)** Two accounts, one app: what single query clause keeps each user seeing only their own tasks — and why is that *not* the same as security?

---

## Answers & explanations

1. Data that **survives reinstalling** and **syncs across devices** / is tied to an **account**. Local storage is this-device-only. (Lesson 16.1.)
2. A **Stream** gives *many* values over time; `authStateChanges()` returns a `Stream<User?>` that emits whenever login state changes. (Lesson 16.4.)
3. **`StreamBuilder`** with `.snapshots()` instead of `.get()` — literally one method call turns a one-time read into a live, self-updating one. (Lesson 16.6.)
4. The **local task list and its `setState` calls** — the stream became the source of truth, so the screen got *smaller*. (Lesson 16.7.)
5. **`resource.data`** is the document as it already exists; **`request.resource.data`** is the incoming write. `create` must check the incoming one, or a user could plant a document stamped with someone else's `uid`. (Lesson 16.8.)
6. Test mode lets **anyone** read and write everything. It's fine for a demo and a disaster in production — anyone who can hit your project reads all data. (Lesson 16.8.)
7. The **`.where('uid', isEqualTo: currentUid)`** filter. But that's your *app* being polite — it doesn't stop someone querying directly. Real protection is the **security rules**. (Lessons 16.6, 16.8.)
