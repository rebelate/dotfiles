# .zsh_profile
# Get the aliases and functions
if [ -f ~/.zshrc ]; then
	. ~/.zshrc
fi
# startup
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
# User specific environment and startup programs
