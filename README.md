# Source patches for redwood

Patches for the POCO X5 Pro 5G (redwood) on Paranoid Android and PenguinOS,
kept out of [the device tree](https://github.com/suvojeet-sengupta/device_xiaomi_redwood)
so that it only holds device files.

The redwood local manifest syncs this repo to `device/xiaomi/redwood-patches`.
`envsetup.sh` then runs `vendorsetup.sh`, which applies the patches. There's
nothing to apply by hand, and patches already applied are skipped.

- `common/` applies to both ROMs
- `aospa/` and `penguinos/` apply to that ROM only
- `features/<name>/` holds one feature, split into the same `common/`, `aospa/`
  and `penguinos/`, applied after the fixes in name order

Under each of those, a patch sits at the path of the project it applies to, for
example `common/frameworks/base/0001-*.patch`.

The ROM is found from the repo manifest. Set `REDWOOD_ROM=aospa` or
`REDWOOD_ROM=penguinos` to pick it by hand.
