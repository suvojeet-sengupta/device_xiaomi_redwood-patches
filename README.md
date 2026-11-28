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

- `AppLock`: turns on Android 17's own App Lock and adds an App lock page
  to Settings > Apps for choosing the locked apps, since Pixel Launcher has
  no lock option. A locked app asks for the fingerprint or screen lock when
  it opens, and its notifications, recents, shortcuts and widgets stay
  hidden.
- `BatteryInfo`: a Battery information section in Settings > Battery with
  the battery's health, charge cycles, full charge and design capacity,
  temperature and voltage.
- `HideImeSpace`: a switch in Settings > System > Gestures > Navigation mode >
  gesture settings that removes the back and keyboard switch bar below the
  keyboard. From crDroid.
- `NavGestures`: in Settings > System > Gestures > Navigation mode >
  gesture settings, switches that hide the navigation handle and the back
  gesture arrow, and back sensitivity sliders that use every level the
  device defines (redwood adds two more sensitive ones).
- `LowPowerStandby`: a Low power standby switch in Settings > Battery. It
  stops background apps from holding wakelocks or using the network while
  the phone is idle; Play services push still gets through. The device tree
  marks the feature supported and leaves it off by default.
- `SecureLockscreen`: a Secure lock screen controls switch below Ignore
  window secure flags in the security settings. While the phone is locked
  with a PIN, pattern or password, the power menu stays closed and the
  internet, Wi-Fi, mobile data, Bluetooth, airplane mode, hotspot, location
  and NFC tiles ask for an unlock first.
- `ShadeBlur`: a Disable blur switch in Settings > Display that turns off
  the blur behind the notification panel and quick settings, live.
- `SmartCharging`: Smart charging and Force fast charging switches in
  Settings > Battery. Smart charging is the charger firmware's own smart
  charging and is on by default; force fast charging drops the thermal
  current limits, so
  the phone charges at full speed but runs hotter. Turning one on turns the
  other off. The device tree writes them to the charger and restores them
  after a reboot.
- `SoundTile`: a Sound quick settings tile that moves the ringer from ring
  to vibrate to silent on each tap and opens the sound settings on a long
  press.
- `TouchModes`: makes High touch polling rate in Settings > Display read
  the Goodix driver's "480HZ" right, and adds a Touch game mode switch
  below it. The device tree applies both to the touch controller.
