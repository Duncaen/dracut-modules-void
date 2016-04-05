#!/bin/sh

info "parse voidbootstrap"

[ -z "$root" ] && root="$(getarg root=)"
case "$root" in
    voidlive|livevoid) printf 'base-system\n' ;;
    voidlive:*|livevoid:*) printf '%s\n' "${root##*:}" ;;
    *) return ;;
esac >> /tmp/voidbootstrap

# make sure we get network
echo > /tmp/net.ifaces

# quiet complaints from init
root="voidlive"
rootok=1

wait_for_dev -n /dev/root
