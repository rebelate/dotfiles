#!/usr/bin/env bash

dir="$HOME/.config/rofi/powermenu"
rofi_command="rofi -theme $dir/five.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# # Confirmation
# confirm_exit() {
# 	rofi -dmenu\
# 		-i\
# 		-no-fixed-num-lines\
# 		-p "Are You Sure? : "\
# 		-theme $dir/confirm.rasi
# }

# # Message
# msg() {
# 	rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
# }

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"
lockscreen="/tmp/lockscreen.jpg"
lastModificationSeconds=$(($(date +%s) - $(date +%s -r $lockscreen)))
condition=$(( $lastModificationSeconds <= 900 ? 1 : 0))
chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"

lock(){
if [[ -f /usr/local/bin/betterlockscreen && $condition == 1 ]]; then
			betterlockscreen -u /tmp/lockscreen.jpg -l blur
		  else
			scrot -o /tmp/lockscreen.jpg -e 'betterlockscreen -u $f -l blur'			
		fi
}

case $chosen in
    $shutdown)
		# ans=$(confirm_exit &)
		ans="yes"
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl poweroff
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $reboot)
		# ans=$(confirm_exit &)
		ans="yes"
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl reboot
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $lock)
		lock
		;;
    $suspend)
		# ans=$(confirm_exit &)
		ans="yes"
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
		    # mpc -q pause
			# amixer set Master mute
			lock
			systemctl suspend
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $logout)
		# ans=$(confirm_exit &)
		ans="yes"
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
				i3-msg exit
			fi
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        else
			msg
        fi
        ;;
esac
