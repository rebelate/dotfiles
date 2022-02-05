#!/usr/bin/sh

# Mandatorily source xinitrc-common, which is common code shared between the
# Xsession and xinitrc scripts which has been factored out to avoid duplication
. /etc/X11/xinit/xinitrc-common

# Start GNOME Keyring
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

dunst &
exec i3
