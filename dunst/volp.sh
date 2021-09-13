#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

sink=$(pactl list short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
def_sink=$(pactl list short|grep alsa_output.pci-0000_00_1f.3.analog-stereo|head -n 1|awk '{print $1}')
cur_sink=$([ -n "$sink" ] && echo "$sink" || echo "$def_sink")
function get_volume {
  pactl list sinks | grep -A 15 -E "^Sink #$cur_sink\$" | grep 'Volume:' | grep -E -v 'Base Volume:' | awk -F : '{print $3; exit}' | grep -o -P '.{0,3}%' | sed 's/.$//' | tr -d ' '
}
volume=`get_volume`
volume_step=6
volume_limit=$((100 - $volume_step))

function is_mute {
    amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
	volume=`get_volume`
    DIR=`dirname "$0"`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
#bar=$(seq -s "─" $(($volume/5)) | sed 's/[0-9]//g')
if [ "$volume" = "0" ]; then
        icon_name="/usr/share/icons/Adwaita/16x16/status/audio-volume-muted-symbolic.symbolic.png"
dunstify "$volume""  " -i "$icon_name" -t 2000 -h int:value:"$volume" -h string:synchronous:"─" --replace=555
    else
	if [  "$volume" -lt "10" ]; then
	     icon_name="/usr/share/icons/Adwaita/16x16/status/audio-volume-low-symbolic.symbolic.png"
dunstify "$volume""  " -i "$icon_name" --replace=555 -t 2000
    else
        if [ "$volume" -lt "30" ]; then
            icon_name="/usr/share/icons/Adwaita/16x16/status/audio-volume-low-symbolic.symbolic.png"
        else
            if [ "$volume" -lt "70" ]; then
                icon_name="/usr/share/icons/Adwaita/16x16/status/audio-volume-medium-symbolic.symbolic.png"
            else
                icon_name="/usr/share/icons/Adwaita/16x16/status/audio-volume-medium-symbolic.symbolic.png"
            fi
        fi
    fi
fi
bar=$(seq -s "─" $(($volume/5)) | sed 's/[0-9]//g')
# Send the notification
dunstify "$volume%""  " -i "$icon_name" -t 2000 -h string:synchronous:"$bar" --replace=555

}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer set Master on > /dev/null
	# Up the volume (+ 5%)
	echo "$volume"
	if [ "$volume" -le "100" ] && [ "$volume" -ge "$volume_limit" ]; then
	  pactl set-sink-volume "$cur_sink" "100%"
    elif [ "$volume" -lt $volume_limit ]; then
        pactl set-sink-volume "$cur_sink" "+$volume_step%"
    fi

	send_notification
	;;
    down)
	amixer set Master on > /dev/null
	pactl set-sink-volume "$cur_sink" "-$volume_step%"
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer set Master 1+ toggle > /dev/null
	if is_mute ; then
    DIR=`dirname "$0"`
    dunstify -i "/usr/share/icons/Adwaita/16x16/status/audio-volume-muted-symbolic.symbolic.png" --replace=555 -u normal "Mute" -t 2000
	else
	    send_notification
	fi
	;;
esac
