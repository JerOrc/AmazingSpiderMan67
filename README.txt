ASM67 October 11 2026 checkpoint - shared final jackpot summary audio window

Changed file:
  modes/villain_bookends/code/villain_bookends.py

Behavior:
  For any villain mode posting play_mode_jackpot or play_mode_super_jackpot,
  a subsequent summary request within 2 seconds is delayed until that window
  expires. Ordinary jackpots during an ongoing mode do not pause gameplay.

This protects the summary MUSIC TRANSITION timing, not audio already stopped
by a mode-specific stop action. Check on-machine with Rhino and other modes;
no claim of completed audio testing.

Does not adjust jackpot audio volume, sound bus, or mode completion logic.
