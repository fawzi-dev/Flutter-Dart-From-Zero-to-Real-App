# BONUS Challenge — Cloud Favorites

By now (videos 16.1–16.8) My Day Cloud has login and tasks syncing through Firestore — built along with me. This challenge: add a **second synced feature entirely on your own**, proving you can wire Firebase without me in your ear.

**Start from:** your own My Day Cloud code (or `starter-projects/module-16/my-day-cloud/` + the module build-alongs).

## The feature
Let users **save favorite quotes** to the cloud:
1. A heart icon on the quote card. Tapping it saves the current quote to Firestore.
2. A "Favorites" screen (reachable from the AppBar) listing the user's saved quotes in **realtime** — add a favorite, watch it appear without any refresh.
3. Long-press (or swipe) a favorite to remove it, with confirm.
4. Favorites are **per user**: a second account must see only its own favorites.

## Requirements
1. New collection `favorites` — each doc: quote text, author, the owner's `uid`, saved-at timestamp.
2. All Firestore calls in a service file (`favorites_service.dart`) — same discipline as tasks.
3. The list uses `snapshots()` + StreamBuilder filtered by uid — mirror the tasks wiring.
4. **Extend your security rules** so users can only read/write their own favorites — and TEST it with your second account before checking the box.
5. Heart icon reflects state: filled if the current quote is already saved (bonus-level nice-to-have; a always-outline heart passes).

## Rubric
- [ ] Two-device test: favorite on device A → appears on device B within a second
- [ ] Second-account test: account B sees zero of account A's favorites AND cannot write into them (try it from code — expect a permission error, and read what that error looks like)
- [ ] Signed-out state handled (favorites UI only reachable when logged in)
- [ ] No Firestore imports in any screen file

## Gated hints
1. This is the tasks feature with different fields. Open `task_service.dart` side by side and transpose — recognizing "I've built this shape before" IS the skill.
2. Rules: copy the tasks match block, change the collection name. Then break it on purpose (remove the uid check, retry with account B) so you SEE what the rule was protecting.

## When you finish this…
…you have independently: modeled data, synced it realtime, secured it per-user, and structured the code cleanly. That's not "foundation student" work — that's junior-developer work. Video 16.10 walks the solution and then the road to intermediate. Go watch it proud.


**Difficulty:** Level 2 — Independent. You get the requirements, not the steps. Stuck? The gated hints are the Level 1 (Guided) path; the bonus/extension is Level 3.

⏱️ Minimum 3 hours. Reference: `complete-projects/module-16/my-day-cloud/`.
