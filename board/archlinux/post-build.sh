#!/bin/bash

set -e

sed -e "s,^root:x:,root::," -i "$TARGET_DIR/etc/passwd"

mkdir -p "$TARGET_DIR/etc/systemd/system/"{multi-user.target.wants,sockets.target.wants,network-online.target.wants,multi-user.target.wants}
ln -sf /usr/lib/systemd/system/systemd-networkd.service "$TARGET_DIR/etc/systemd/system/dbus-org.freedesktop.network1.service"
ln -sf /usr/lib/systemd/system/systemd-networkd.service "$TARGET_DIR/etc/systemd/system/multi-user.target.wants/systemd-networkd.service"
ln -sf /usr/lib/systemd/system/systemd-networkd.service "$TARGET_DIR/etc/systemd/system/sockets.target.wants/systemd-networkd.socket"
ln -sf /usr/lib/systemd/system/systemd-networkd.service "$TARGET_DIR/etc/systemd/system/network-online.target.wants/systemd-networkd-wait-online.service"
ln -sf /usr/lib/systemd/system/systemd-resolved.service "$TARGET_DIR/etc/systemd/system/dbus-org.freedesktop.resolve1.service"
ln -sf /usr/lib/systemd/system/systemd-resolved.service "$TARGET_DIR/etc/systemd/system/multi-user.target.wants/systemd-resolved.service"
