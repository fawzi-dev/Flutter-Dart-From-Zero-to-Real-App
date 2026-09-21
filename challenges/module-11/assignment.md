# Module 11 Assignment — Random Advice (or Quote) App

**Independent practice (Level 2).** The loading/error/data trio on a fresh, keyless API.

## Brief
One screen that fetches a random piece of advice from `https://api.adviceslip.com/advice` (or a quote from `https://dummyjson.com/quotes/random`), with a button to fetch a new one. Handle all three states.

## Requirements
1. A model + `fromJson` in `models/`; a fetch function in `services/` (no `http` import in the screen).
2. The boolean-flags trio (`isLoading`, `error`, `data`) + `setState`; first fetch in `initState`.
3. `try/catch` with a human error message and a working Retry.
4. **The airplane-mode test:** offline → friendly error + Retry; back online + Retry → data. No crash.

## Rubric
- [ ] Zero JSON keys in the widget code
- [ ] Spinner, error+retry, and data states all reachable
- [ ] Survives airplane mode with no crash
- [ ] `await` used correctly (no `Instance of Future` on screen)

## Difficulty
**Level 2 — Independent.** Extension (**Level 3**): keep a short in-session history of the last five results.

⏱️ Minimum 75 minutes.
