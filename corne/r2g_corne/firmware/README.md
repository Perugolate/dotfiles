# Mechboards Corne Pro R2G — Vial firmware + Super Leader

**This board is a "Corne Pro R2G", NOT a Corne Max** — identified from the
picotool dump's USB product string and the Vial UID in `v0.1.vil`
(`0x66117d73dcc5aa28` = UID bytes `28 AA C5 DC 73 7D 11 66`). The Mechboards
firmware-source guide doesn't list the Pro, which is how firmware for the
wrong board (`mechboards/crkbd/rp2g`, the Corne Max) got flashed here first
— both halves completely unresponsive, twice. Wrong-board firmware means
wrong pin mappings; nothing enumerates.

Correct source: `MechboardsLTD/vial-qmk`, branch **`r2g`** (built at
`d93757d10f`, 2026-07-06), keyboard **`mechboards/crkbd/r2g/6col`**
(RP2040; the 8×6 matrix in the `.vil` confirms 6col, not 5col).
This branch has community-module support, so Super Leader works.

| File | What it is |
|---|---|
| `mechboards_crkbd_r2g_6col_vial_superleader.uf2` | Stock vial keymap + **Super Leader** module with the sequences below |
| `mechboards_crkbd_r2g_6col_vial.uf2` | Stock vial keymap, same commit — fallback image |
| `r2g_shipped_left.uf2` / `r2g_shipped_right.uf2` | **Full picotool flash dumps of the shipped firmware** (keymap included) — the known-good restore point |

SHA-256:
```
213e09f1d4fe223bdbb8662ec77b273216390147ad1f668050085853dfd37f4f  mechboards_crkbd_r2g_6col_vial_superleader.uf2
daeaebe4f86e8f972c675bbb8eb90e973c9f9916d23b95b1006852abe7990a42  mechboards_crkbd_r2g_6col_vial.uf2
```

NB: QMK embeds a build timestamp, so rebuilding identical source yields a
different SHA-256 every time — a hash mismatch does not imply a code change.

Verified before release: Vial UID and USB product string ("Corne Pro R2G")
in these builds are byte-identical to the shipped dump; email string
present in the binary.

## Leader sequences (compiled in, same set as the AliExpress boards)

| Sequence | Result |
|---|---|
| LEADER, V | Cmd+V (held while V is held) |
| LEADER, M, E | types `me@example.com` |
| LEADER, D, F, U | bootloader (`QK_BOOT`): the USB-connected half reboots as `RPI-RP2` |


**Privacy note:** the committed `super_leader.def` uses a placeholder
address — the real one lives only in the local build tree (see rebuild
recipe). The built `*superleader.uf2` is deliberately NOT committed:
the real email is embedded in the binary (visible via `strings`).
Rebuild locally to regenerate it.


Bind LEADER in Vial via the **Any** key with keycode **`0x77C0`**
(same value as the other boards).


## Modules: Cyclotab + Select Word (added alongside Super Leader)

Community-module keycodes (bind in Vial via the **Any** key; identical on
all boards; stable as long as the module order in `keymap.json` is
super_leader, cyclotab, select_word):

| Keycode | Hex | What it does |
|---|---|---|
| `LEADER` | `0x77C0` | Super Leader |
| `SELECT_WORD` | `0x77C1` | select word; repeat to extend; +Shift = line |
| `SELECT_WORD_BACK` | `0x77C2` | select word backwards |
| `SELECT_LINE` | `0x77C3` | select line; repeat extends down |
| `SELECT_LINE_UP` | `0x77C4` | extend line selection up |

**Cyclotab** registers no keycode — bind `LGUI(KC_TAB)` (Any: `0x082B`) and
the module takes it over: tap once = app switcher opens with Cmd virtually
held (~2 s timeout); arrows navigate (whitelisted, refresh the timeout);
Enter (consumed) or timeout commits; Esc cancels. Configured for macOS
(`CYCLOTAB_KEYS LCMD(KC_TAB)`); Select Word sends macOS hotkeys
(`SELECT_WORD_OS_MAC`).

**Cyclotab layer-key patch:** upstream cyclotab ends cycling on any
non-whitelisted key, so pressing a layer key to reach arrows on another
layer killed the cycle before the arrows could be used. Patched to treat
layer-switch keys (MO/LM/LT-hold/TG/OSL/tri-layer) like the arrows: stay
active and refresh the timer. The patch lives in the fork
**github.com/Perugolate/qmk-modules** (commit "Cyclotab: keep cycling
active across layer-switch keys"), which both build trees now clone as
`modules/getreuer` — so it survives re-cloning. `upstream` remote points
at getreuer/qmk-modules for syncing.

## Flashing / recovery

Test procedure that keeps risk near zero:

1. Flash **one half only**, test it **standalone over USB** (it should type
   and appear in Vial).
2. Only then flash the other half with the same file.

Bootloader entry: bootmagic is enabled (hold top-left key while plugging
in USB), or the physical BOOT button while plugging in (RP2040 ROM —
always works). If a flash goes wrong: enter bootloader, drag the matching
`r2g_shipped_*.uf2` dump back on; it restores everything including the
keymap. Save your `.vil` before flashing. Once the superleader build is
on, **LEADER, D, F, U** enters the bootloader from then on.

## Rebuild recipe

Tree: `~/scratch/mechboards-vial-qmk`, checked out at `origin/r2g`
(`d93757d10f`); getreuer modules cloned at `modules/getreuer`. Keymap:
`keyboards/mechboards/crkbd/r2g/6col/keymaps/vial_superleader/`
(stock `vial` keymap + `keymap.json` + `super_leader.def`; copies kept
here — keep sequences in sync with
[../../firmware/superleader/super_leader.def](../../firmware/superleader/super_leader.def)).

```sh
cd ~/scratch/mechboards-vial-qmk
PATH="$HOME/scratch/arm-gnu-toolchain-14.2.rel1-darwin-arm64-arm-none-eabi/bin:$HOME/scratch/qmk-venv/bin:$PATH" \
  qmk compile -kb mechboards/crkbd/r2g/6col -km vial_superleader
# output: .build/mechboards_crkbd_r2g_6col_vial_superleader.uf2
```
