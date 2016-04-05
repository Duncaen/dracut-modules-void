#!/bin/bash

# called by dracut
check() {
    #
    return 255
}

# called by dracut
depends() {
    echo xbps mkfs network
    return 0
}

# called by dracut
install() {
    # inst_script "$moddir/void-bootstrap.sh" /sbin/void-bootstrap
    inst_hook initqueue/online 95 "$moddir/void-bootstrap.sh"
    dracut_need_initqueue
}
