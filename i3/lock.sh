lockscreen="/tmp/lockscreen.jpg"

ss(){
  scrot -o $lockscreen -e 'betterlockscreen -u $f -l blur'			
}

lock(){
  if [[ -f $lockscreen ]]; then
	lastModificationSeconds=$(($(date +%s) - $(date +%s -r $lockscreen)))
	condition=$(( $lastModificationSeconds <= 900 ? 1 : 0))

	if [[ -f /usr/local/bin/betterlockscreen && $condition == 1 ]]; then
				betterlockscreen -l blur
			  else
				ss
			fi
	else
	  ss
  fi
}

