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
f1c5faf35b9d14d7642755ff94852533a7078dca30e6b8fa9f693e7aa3104622  mechboards_crkbd_r2g_6col_vial_superleader.uf2
daeaebe4f86e8f972c675bbb8eb90e973c9f9916d23b95b1006852abe7990a42  mechboards_crkbd_r2g_6col_vial.uf2
```

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
