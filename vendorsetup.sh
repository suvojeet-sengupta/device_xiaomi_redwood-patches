#
# SPDX-License-Identifier: Apache-2.0
#

# Apply the source patches redwood needs on PixelOS. Fixes live in common/,
# features in features/<name>/ and are applied after the fixes, in name
# order. Patches that are already applied are skipped, so this is safe to
# run on every envsetup.

redwood_apply_patches() {
    local top="${T:-$(gettop)}"
    local repo="$top/device/xiaomi/redwood-patches"
    local patches patch dir subject

    echo "redwood: applying the PixelOS patches" >&2

    for patches in "$repo/common" "$repo"/features/*/; do
        patches="${patches%/}"
        [ -d "$patches" ] || continue

        for patch in $(cd "$patches" && find . -name "*.patch" | sort); do
            patch="${patch#./}"
            dir="$top/$(dirname "$patch")"
            [ -d "$dir" ] || continue

            # Already applied. A later patch can change the same lines, so
            # also look for the commit itself, not just for its changes.
            if git -C "$dir" apply --check --reverse "$patches/$patch" &>/dev/null; then
                continue
            fi
            subject="$(git mailinfo /dev/null /dev/null < "$patches/$patch" | sed -n "s/^Subject: //p")"
            if [ -n "$subject" ] && git -C "$dir" log -n 500 --format=%s | grep -Fxq -- "$subject"; then
                continue
            fi

            if git -C "$dir" -c user.name=suvojeet-sengupta -c user.email=suvojitsengupta21@gmail.com \
                    am -q --3way "$patches/$patch" &>/dev/null; then
                echo "redwood: applied ${patches#"$repo/"}/$patch" >&2
            else
                git -C "$dir" am --abort &>/dev/null
                echo "redwood: failed to apply ${patches#"$repo/"}/$patch" >&2
            fi
        done
    done
}

redwood_apply_patches
unset -f redwood_apply_patches
