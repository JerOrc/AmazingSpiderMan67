# Villain start award

Implemented against ASM67_2026_10_11_10pm.zip on October 12, 2026.

All 55 villain gameplay modes award:

**100,000 + (50,000 × collected Case Files)**

| Collected Case Files | Start award |
| --- | ---: |
| 0 | 100,000 |
| 1 | 150,000 |
| 2 | 200,000 |
| 3 | 250,000 |
| 4 | 300,000 |
| 5 | 350,000 |

The award is paid once in `mode_start`, when gameplay starts after the intro
finishes or is skipped. Opening chapter selection, selecting a villain, holding
the flipper to display instructions, and showing an intro do not pay it.
An immediate gameplay drain retains the award in the player's score and the
villain summary's TOTAL MODE POINTS.

The five collected Case File flags are counted at gameplay start. Consuming a
helper later does not reduce the award. Jackpot multipliers and helper effects
do not modify it. The start award does not add points to chapter bonus banks.
Existing Case File banking toward wizard preparation continues normally.
Wizard modes and their scoring are unchanged.

## Implementation

`modes/common/case_file_mixin.py` owns the formula and score payment in
`reset_active_mode_summary()`. All 55 villains call it once from `mode_start`.
The award seeds the shared `active_mode_points` slot and the local
`mode_points` or `active_mode_points` accumulator where used. Startup helper
methods that previously reset shared points to zero now retain this seed.
Master Technician uses the shared slot directly and requires no local edit.

No new persistent player variables or YAML configuration are required.
The Progression Case Files tab in the current tracker records the same rule.

## Validation

Run from the machine root:

```text
python tests/test_villain_start_bonus.py
```

330 scenarios passed: all 55 actual villain startup methods with every Case
File count from zero through five, local/shared totals, mode stop, formatted
summary totals, and a fresh attempt on the same mode instance. Representative
subsequent scoring was checked across local and shared accumulator styles.
MPF services, event dispatch, timers, and hardware are stubbed in this test.
Python compilation passed. Wizard source files are byte-for-byte unchanged.

Machine testing remains unconfirmed. Test one villain with no Case Files and
one with all five: verify the score increases by 100,000 or 350,000 when
gameplay begins, drain immediately, and confirm the summary retains it.

## Install patch

Extract the patch ZIP into the machine project root and overwrite the included
files. It contains the shared helper, 54 villain scripts, this rule document,
the regression check, and the updated tracker. Restart MPF after applying it.
