#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

#cur_sink=$( pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1 )
sink=$(pactl list short sinks | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
def_sink=$(pactl list short sinks |grep alsa_output.pci-0000_00_1f.3.analog-stereo|head -n 1|awk '{print $1}')
cur_sink=$([ -n "$sink" ] && echo "$sink" || echo "$def_sink")
function get_volume {
  pactl list sinks | grep -A 15 -E "^Sink #$cur_sink\$" | grep 'Volume:' | grep -E -v 'Base Volume:' | awk -F : '{print $3}' | grep -o -P '.{0,3}%' | sed 's/.$//' | tr -d ' '
}
#echo $cur_sink
volume=`get_volume`
volume_step=6
volume_limit=$((100 - $volume_step))

mic_source="easyeffects_source"

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer set Master on > /dev/null
	# Up the volume (+ 5%)
	if [ "$volume" -le "100" ] && [ "$volume" -ge "$volume_limit" ]; then
	  pactl set-sink-volume "$cur_sink" "100%"
    elif [ "$volume" -lt $volume_limit ]; then
        pactl set-sink-volume "$cur_sink" "+$volume_step%"
    fi
	;;
    down)
	amixer set Master on > /dev/null
	if [ "$volume" -ge "0" ] && [ "$volume" -le "$(( 100 - $volume_limit ))" ]; then
	  pactl set-sink-volume "$cur_sink" "0"
	elif [ "$volume" -gt "$(( 100 - $volume_limit ))" ]; then
        pactl set-sink-volume "$cur_sink" "-$volume_step%"
    fi
	;;
    mute)
	# Toggle mute
	amixer set Master 1+ toggle > /dev/null
	;;
  togglemic)
	pactl set-source-mute $mic_source toggle
	mic_state=$(pactl list | grep -m 1 -A 6 $mic_source | grep Mute | awk '{print $2}')
	[[ "$mic_state" == "yes" ]] && dunstify "Muted" -t 500 || dunstify "Unmuted" -t 500
	;;
esac
