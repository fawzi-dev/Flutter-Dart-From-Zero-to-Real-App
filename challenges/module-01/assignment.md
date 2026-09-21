# Module 1 Assignment — Unit Converter

**Independent practice (Level 2).** Different app from the tip calculator, same Module 1 skills. No starter — a blank `.dart` file, run with `dart run`.

## Brief
Build a console program that **asks** the user for a distance in kilometres and prints it converted to miles, metres and centimetres — a small, useful tool.

## Requirements
1. Ask for the distance with `stdout.write` + `stdin.readLineSync()` and convert with `double.parse` (the lesson 1.7 shape).
2. All conversions **computed**, none hardcoded: miles = km × 0.621371; metres = km × 1000; centimetres = metres × 100.
3. Every result printed to **2 decimal places** with `toStringAsFixed(2)`.
4. Use `final` for values that don't change; sensible `lowerCamelCase` names.
5. A tidy labelled output block, like the tip calculator's receipt.

## Rubric
- [ ] Prompts for input and converts it — not hardcoded
- [ ] Every printed number is derived by calculation
- [ ] 2-decimal formatting throughout
- [ ] Runs twice with different inputs and every line changes

## Difficulty
**Level 2 — Independent.** You get the requirements, not the steps.

⏱️ Minimum 30 minutes. It's fine (and expected) that typing `abc` still crashes — Module 5 fixes that.
