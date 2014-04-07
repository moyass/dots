
# ============================

if [[ "$IS_OSX" = true ]]; then
  # Use the open command on OSX
  export BROWSER='open'

elif [[ "$IS_LINUX" = true ]]; then

	[[ -n "$XDG_CACHE_HOME" ]] || export XDG_CACHE_HOME="$HOME/.cache"
	[[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME="$HOME/.config"
	[[ -n "$XDG_DATA_HOME" ]] || export XDG_DATA_HOME="$HOME/.local/share"
	export BROWSER='iceweasel'
	export SYSTEMD_PAGER="/usr/bin/less -R"

fi

export CDPATH="$CDPATH:$HOME/Projects"

export VISUAL="vim"
export EDITOR="vim"

export ARCHFLAGS="-arch x86_64"

export GREP_COLOR="1;33"
alias grep='grep --color=auto'


export PAGER="less"
# output colors in less

# Set the default Less options.
# Mouse-wheel scroll can be disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable mouse-wheel scroll.
export LESS='-g -i -M -R -S -w -z-4'
