# Corne v4.1 Vial firmware — Chordal Hold + Flow Tap

`crkbd_rev4_1_standard_vial_chordalhold.uf2` — a community build of the
Corne v4.1 (standard, Vial) firmware with modern QMK tap-hold features
(**Chordal Hold** and **Flow Tap / Tap Flow**) exposed as runtime settings
in Vial's QMK Settings → Tap-Hold tab.

## Why this exists

The official foostan firmware (`foostan/kbd_firmware`) is pinned to an old
vial-qmk and predates Chordal Hold (mainline ~Feb 2025) and Flow Tap
(~late 2024), so its Tap-Hold tab shows only the legacy settings. This
build bumps the vial-qmk submodule forward so both features are available.

NB: our AliExpress clones are sold as "v4 TRRS" but are **v4.1-based** —
the `crkbd_rev4_1_...` (v4.1) firmware is the one that drives their split
correctly; the `_0_` (v4.0) firmware breaks inter-half comms. (Discovered
from other buyers' reviews of the same product.)

## Provenance

- Source: **foostan/kbd_firmware PR #21** by jellydn (unmerged, community).
  - PR: https://github.com/foostan/kbd_firmware/pull/21
  - PR branch: jellydn's fork `main`, commit `b73bd94aae37baabb5418e74a6f6a57430add033`
- File in that repo (renamed here to avoid colliding with the official
  same-named file): `keyboards/crkbd/vial-kb/vial-qmk/.build/crkbd_rev4_1_standard_vial.uf2`
- Fetched via:
  `https://raw.githubusercontent.com/foostan/kbd_firmware/b73bd94aae37baabb5418e74a6f6a57430add033/keyboards/crkbd/vial-kb/vial-qmk/.build/crkbd_rev4_1_standard_vial.uf2`
- Bumps the vial-qmk submodule to `0f7eae3a556831d1f639d89b7a281ebf5c5a136b`
  (2025-08-06), which contains both `CHORDAL_HOLD` and `FLOW_TAP`.
- SHA-256: `3d2413a98dcd6816d869780646806093cdbe502d26638217111d91a478477ba6`
- RP2040 UF2, loads at 0x10000000, 329 blocks (168448 bytes).

## Recovery / fallback

This is an unmerged third-party build. If it ever misbehaves, restore a
known-good image (RP2040 = drag-drop, unbrickable):
- `../../corne_working_*.uf2` — picotool dumps of the working vendor firmware
  (also `~/corne_working_left.uf2` / `~/corne_working_right.uf2`)
- the official `../crkbd_rev4_0_standard_vial.uf2` is the WRONG (v4.0) variant
  — do not use; the working official variant is the v4.1 `_1_` build.

## Flashing

Flash to **both halves**: BOOT → `RPI-RP2` mounts → drag the uf2 → repeat.
Then Vial → QMK Settings → Tap-Hold: enable Chordal Hold, set Flow Tap
~150ms, Tapping Term ~200-250. Home-row mods (GACS) go on A/S/D/F and
J/K/L/;. Combos on mod-tap keys must reference the mod-tap keycodes
(e.g. `LCTL_T(KC_D)`), not the bare letters.
