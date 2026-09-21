# Module 10 Assignment — Notes App

**Independent practice (Level 2).** The list→detail→add skeleton on a new noun.

## Brief
A multi-file notes app: a list of notes, tap a note to see it full-screen, a `+` to add one, swipe to delete. (No persistence yet — that's the bonus module.)

## Requirements
1. A `Note` model (`title`, `body`, `createdAt`) in `models/`.
2. `models/ · screens/ · widgets/` structure; the note tile is its own widget.
3. Add screen returns the note via `pop`; the list screen `await`s it and handles the back-out case.
4. Tap a note → a detail screen receiving the note **through its constructor**.
5. Swipe-to-delete with a confirmation dialog; a friendly empty state.

## Rubric
- [ ] `ListView.builder`, not a Column
- [ ] Add → appears → tap → detail → back → swipe-delete → empty state all work
- [ ] State lives only in the list screen
- [ ] Three folders, clean imports

## Difficulty
**Level 2 — Independent.** Extension (**Level 3**): let the detail screen edit the note and return the changes.

⏱️ Minimum 90 minutes.
