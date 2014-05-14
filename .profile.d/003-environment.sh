
# ============================

if [[ "$OSTYPE" =~ darwin* ]]; then
  # Use the open command on OSX
  export BROWSER='open'

elif [[ "$OSTYPE" =~ linux* ]]; then

	[[ -n "$XDG_CACHE_HOME" ]] || export XDG_CACHE_HOME="$HOME/.cache"
	[[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME="$HOME/.config"
	[[ -n "$XDG_DATA_HOME" ]] || export XDG_DATA_HOME="$HOME/.local/share"
	
  if [[ $(lsb_release -is) =~ Debian ]]; then
    export BROWSER='iceweasel'
  else
    export BROWSER='firefox'
  fi

fi

export CDPATH="$CDPATH:$HOME/Projects"

export VISUAL="vim"
export EDITOR=$VISUAL

export ARCHFLAGS="-arch x86_64"

export GREP_COLOR="1;33"
alias grep='grep --color=auto'

#VLESS=$(find /usr/share/vim -name 'less.sh')
#if [ ! -z $VLESS ]; then
  #alias vless=$vless
  #alias vls=$VLESS
  #export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
        #vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
        #-c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
        #-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
  #export SYSTEMD_PAGER=$PAGER
#else
  export PAGER="/usr/bin/less"
	export SYSTEMD_PAGER="/usr/bin/less -R"


  # coloured man pages
  export LESS_TERMCAP_mb=$'\E[01;31m'
  export LESS_TERMCAP_md=$'\E[01;34m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_so=$'\E[01;30;03;36m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[01;35m'

#fi

# Set the default Less options.
# Mouse-wheel scroll can be disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable mouse-wheel scroll.
export LESS='-g -i -M -R -w -z-4'
