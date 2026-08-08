# Corne v4.1 Vial firmware — Chordal Hold + Flow Tap + Super Leader

`crkbd_rev4_1_standard_vial_superleader.uf2` — same base as the known-good
chordalhold build (vial-qmk `0f7eae3a`, foostan kbd_firmware build recipe),
plus Pascal Getreuer's **Super Leader** community module.

- SHA-256: `18bb2f003c1e2c594e86bd9d868ad4d3dc0c4a8e1722ce9eaba2fa8ba4996264`
- Module docs: https://getreuer.info/posts/keyboards/super-leader
- Everything from the chordalhold build is still present (Chordal Hold,
  Flow Tap, combos, QMK Settings) and the Vial keyboard UID is unchanged,
  so existing `.vil` layouts still load.

## Leader sequences baked into this build

Sequences are compiled into the firmware (not editable in Vial). Current
definitions ([super_leader.def](super_leader.def)):

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

Notes: successive keys must come within 1000 ms; tap-hold keys count as
their tap keycode, so home-row mods don't interfere; layer keys are
ignored mid-sequence.

## Binding the LEADER key in Vial

The module registers keycode `KC_SUPER_LEADER` (alias `LEADER`) at
**`0x77C0`** (decimal **30656**) — the first community-module keycode slot.
Vial doesn't know this keycode by name, so bind it with the **Any** key:

1. In Vial, select the key position you want.
2. Choose the **Any** key (Quantum tab), and enter `0x77C0`.
3. The key will show as a raw keycode. Do this on whichever layer you like.

The keycode value is stable as long as `super_leader` is the only (or first)
module listed in `keymap.json` — re-derive it from the generated
`community_modules.h` if more modules are added.

## Flashing

**Future flashes** (once this build is on the boards): no Vial bootloader
key or unlock combo needed — type **LEADER, D, F, U** on the USB-connected
half, it mounts as `RPI-RP2`, drag the new `.uf2` on. TRRS stays connected;
move USB-C to the other half and repeat.

**First flash** of this build: identical procedure to the chordalhold build — see
[../jellydn/README.md](../jellydn/README.md) and the CC_CAT_Store_corne_v4
repo: same `.uf2` to **both halves**, software-bootloader method preferred,
save your `.vil` first, TRRS stays connected, only USB-C moves.

## How it was built (rebuild recipe)

One-time setup (already done on this machine):

- `~/scratch/kbd_firmware` — clone of foostan/kbd_firmware; submodule
  `src/vial-kb/vial-qmk` checked out at `0f7eae3a` (the chordalhold base),
  nested submodules synced.
- `~/scratch/kbd_firmware/src/vial-kb/vial-qmk/modules/getreuer` — clone of
  https://github.com/getreuer/qmk-modules
- `~/scratch/qmk-venv` — python venv with the `qmk` CLI (+ vial-qmk
  `requirements.txt`)
- `~/scratch/arm-gnu-toolchain-14.2.rel1-darwin-arm64-arm-none-eabi` — ARM's
  official GCC 14.2 toolchain (the brew `qmk` formula and `gcc-arm-embedded`
  cask both hit obstacles: untrusted-tap chain / sudo installer; the
  homebrew-core `arm-none-eabi-gcc` lacks newlib)

The keymap lives at
`~/scratch/kbd_firmware/keyboards/crkbd/vial-kb/vial-qmk/keymaps/vial_superleader/`
— a copy of the stock `vial` keymap plus `keymap.json` (enables the module)
and `super_leader.def` (the sequences). Copies of both files are kept here.

To rebuild (e.g. after editing `super_leader.def`):

```sh
cd ~/scratch/kbd_firmware
kb=crkbd make vial-qmk-init   # only needed if keyboards/tmp was cleaned
cd src/vial-kb/vial-qmk
PATH="$HOME/scratch/arm-gnu-toolchain-14.2.rel1-darwin-arm64-arm-none-eabi/bin:$HOME/scratch/qmk-venv/bin:$PATH" \
  qmk compile -kb tmp/crkbd/rev4_1/standard -km vial_superleader
# output: .build/tmp_crkbd_rev4_1_standard_vial_superleader.uf2
```

Remember to edit the keymap under `kbd_firmware/keyboards/...` (the real
files); `keyboards/tmp/crkbd/keymaps` inside vial-qmk is a symlink to them.
