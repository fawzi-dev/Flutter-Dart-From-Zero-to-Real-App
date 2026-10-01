# Steps — Module 15, Contacts Remembered

| File | End of | What it is |
|---|---|---|
| `step_1_remember_my_name.dart` | **15.2** | The recipe on something tiny. A name and a counter, both surviving a restart. |
| `step_2_half_a_loop.dart` | **15.4** | **Deliberately broken.** It loads. It never saves. |
| `lib/` | **15.4** | The finished app: a service, `toJson`/`fromJson`, and one place that saves. |

## The test never changes

Add something. **Fully close the app** — swipe it out of the recent-apps
list. Minimising proves nothing, because the process is still alive and the
list is still sitting in memory. Reopen.

## Run step 2 before you read the fix

`step_2_half_a_loop.dart` is the useful one. Everything in it looks right:
there is a storage service, `toJson` and `fromJson` are correct, the
first-launch null check is there, and `initState` loads. Add two contacts,
restart, and they are gone anyway — **because nothing ever calls `save`.**

Loading from an empty box gives you an empty list, forever. It is obvious in
hindsight and extremely common in practice, because the reading half is the
more interesting half to write.

## What changes between the steps and the finished app

- **15.3** — `toJson`, then `.map((c) => c.toJson()).toList()`, then
  `jsonEncode`. **Print the string and look at it** — that is your whole list
  as one line of JSON, the same shape the weather API sent you in Module 11,
  except this time you built it.
- **15.4** — `load()`, and the `_change` helper that welds "change the list"
  to "save the list" so you physically cannot do one without the other.

## The two fields JSON will not take

Every model you ever save has at least one. The move is always the same:
turn it into a string on the way out, turn the string back on the way in.

| Field | Out | Back |
|---|---|---|
| `ContactGroup group` | `group.name` → `'work'` | `ContactGroup.values.firstWhere(..., orElse: ...)` |
| `DateTime addedOn` | `.toIso8601String()` | `DateTime.parse(...)` |

**The `orElse` matters more than it looks.** Ship a new version that renames a
group, and every contact saved under the old name would otherwise crash the
app on launch. `orElse` is what lets old saved data survive a new build — the
same reason the `?? ''` and `?? false` defaults are there.
