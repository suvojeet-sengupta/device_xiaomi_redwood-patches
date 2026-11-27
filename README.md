# Source patches for redwood on PixelOS

Patches for the POCO X5 Pro 5G (redwood) on PixelOS 17, kept out of
[the device tree](https://github.com/suvojeet-sengupta/device_xiaomi_redwood)
so that it only holds device files. The `clo-6.12` branch has the Paranoid
Android and PenguinOS patches.

The redwood local manifest syncs this branch to `device/xiaomi/redwood-patches`.
`envsetup.sh` then runs `vendorsetup.sh`, which applies the patches. There is
nothing to apply by hand, and patches already applied are skipped.

- `common/` holds fixes
- `features/<name>/` holds one feature, applied after the fixes in name order

A patch sits at the path of the project it applies to, for example
`features/HideImeSpace/packages/apps/Settings/0001-*.patch`.

## Features

- `HideImeSpace`: a switch in Settings > System > Gestures > Navigation mode >
  gesture settings that removes the back and keyboard switch bar below the
  keyboard. From crDroid.
- `LowPowerStandby`: a Low power standby switch in Settings > Battery. It
  stops background apps from holding wakelocks or using the network while
  the phone is idle; Play services push still gets through. The device tree
  marks the feature supported and leaves it off by default.
