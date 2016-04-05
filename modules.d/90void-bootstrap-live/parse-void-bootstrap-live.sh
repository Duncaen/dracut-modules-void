#!/bin/sh

info "parse voidbootstraplive"

[ -z "$root" ] && root="$(getarg root=)"
case "$root" in
    voidlive|livevoid) printf 'base-system\n' ;;
    voidlive:*|livevoid:*) printf '%s\n' "${root##*:}" ;;
    *) return ;;
esac >> /tmp/voidbootstrap

# make sure we get network
echo > /tmp/net.ifaces
# echo '[ -e /tmp/voidbootstrap.done ]' > \
    # $hookdir/initqueue/finished/voidbootstrap.sh

# quiet complaints from init
netroot="voidlive"
root="voidlive"
rootok=1

wait_for_dev -n /dev/root
