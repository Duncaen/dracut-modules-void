#!/bin/sh

[ -e "/tmp/voidbootstrap" ] || return 0

mkdir -p "$1/var/db/xbps/keys/"
cp /var/db/xbps/keys/*.plist "$1/var/db/xbps/keys/"

info "Installing $pkgs"

read pkgs < /tmp/voidbootstrap

xbps-install -C /etc/xbps.d -r "$1" -My "$pkgs" || {
    warn "failed to install packages!"
    warn "packages: $pkgs"
    return 1
}

mv /tmp/voidbootstrap{,.done}
