#!/bin/bash

# called by dracut
check() {
    #
    [[ $hostonly ]] && return 1
    return 255
}

# called by dracut
depends() {
    echo void-bootstrap rootfs-block
    return 0
}

# called by dracut
installkernel() {
    instmods squashfs loop
}

# called by dracut
install() {
    inst_hook cmdline 30 "$moddir/parse-void-bootstrap-live.sh"
    # inst_hook pre-udev 30 "$moddir/void-bootstrap-live.sh"
    inst_script "$moddir/voidliveroot.sh" "/sbin/voidliveroot"
}
