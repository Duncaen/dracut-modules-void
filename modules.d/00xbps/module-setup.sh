#!/bin/bash

# called by dracut
check() {
    require_binaries xbps-query || return 1
    return 255
}

# called by dracut
depends() {
    return 0
}

# called by dracut
install() {
    inst_multiple /var/db/xbps/keys/*.plist \
        $(xbps-query -f xbps | awk -F' -> ' '{print $1}') \
        $(xbps-query -f xbps-triggers | awk -F' -> ' '{print $1}')

    inst_hook cmdline 30 "$moddir/parse-xbps.sh"
}
