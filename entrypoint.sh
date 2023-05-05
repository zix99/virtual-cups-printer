#!/bin/bash
set -ex
/usr/sbin/avahi-daemon --daemonize
exec /usr/sbin/cupsd -f