#!/bin/sh

. ./lib/dracut-lib.sh

info "VOIDLIVEROOT!!1"

mkdir -m 0755 -p /run/initramfs/void-bootstrap-live
mount -t tmpfs -o size=512m ext4 /run/initramfs/void-bootstrap-live

echo "base-system" > /tmp/voidbootstrap

ls -lsa /sbin/void-bootstrap
# exec /sbin/void-bootstrap "$root"
