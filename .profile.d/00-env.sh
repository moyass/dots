#{{{1 Environment Variables
#{{{2 Path
# A function to protect you from yourself
# ========================================
adjunct_path_with () {
  adjunctor="$1"    # the directory  ## WARN: DO NOT USE TRAILING SLASH OR THE WORLD ENDS!
  override="$2"    # if $2 is true: $1 is prefixed to PATH; else $1 is appended to PATH

  if [ -d "$adjunctor" ]; then
    if [ "$override" != "false" ]; then
      PATH="$1:$PATH"
    else
      PATH="$PATH:$1"
    fi
  fi
}

# Add composer user bin
# ===================
adjunct_path_with "${HOME}/.composer/vendor/bin" true

# Npm
# ===================
adjunct_path_with "${HOME}/.npm-packages/bin" true
adjunct_path_with "${HOME}/.npm-local/bin" true

# Gems
# ============================
# http://guides.rubygems.org/faqs/#user-install
if command -v ruby 2>&1 >/dev/null && command -v gem 2>&1 >/dev/null; then
  adjunct_path_with "$(ruby -rubygems -e 'puts Gem.user_dir')/bin" true
fi

# Add local bin
# ===================
adjunct_path_with "/usr/local/bin" true

# User's bin
# ===================
adjunct_path_with "${HOME}/bin"  true

# OSX
# ===================
if [[ "$OSTYPE" =~ darwin* ]]; then
  # Add localbins  to path, esp for homebrew
  adjunct_path_with "/usr/local/sbin" true

# Linux
# ===================
elif [[ "$OSTYPE" =~ linux* ]]; then
  adjunct_path_with "/usr/games" false
fi

# sbins
# ===================
adjunct_path_with "/sbin" true
adjunct_path_with "/usr/sbin" true


# Cleanup
# ===================
unset -f adjunct_path_with
export PATH

#}}}
#{{{2 Editor, Browser, Pager

if [[ "$OSTYPE" =~ darwin* ]]; then
  # Use the open command on OSX
  export BROWSER='open'

elif [[ "$OSTYPE" =~ linux* ]]; then
  stty -ixon # Disable flow control

  [[ -n "$XDG_CACHE_HOME" ]] || export XDG_CACHE_HOME="$HOME/.cache"
  [[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME="$HOME/.config"
  [[ -n "$XDG_DATA_HOME" ]] || export XDG_DATA_HOME="$HOME/.local/share"

  if [[ $(lsb_release -is) =~ Debian ]]; then
    export BROWSER='iceweasel'
  else
    export BROWSER='firefox'
  fi

fi

export GPG_TTY=`tty`


export VISUAL="vim"
export EDITOR=$VISUAL

export PAGER='/usr/bin/less'
export SYSTEMD_PAGER='/usr/bin/less'

# Mouse-wheel scroll can be disabled by -X (disable screen clearing)
# Remove -X and -F (exit if the content fits on one screen) to enable mouse-wheel scroll
LESSOPTS="--no-init --quit-if-one-screen --force --dumb --ignore-case --no-lessopen --long-prompt --RAW-CONTROL-CHARS --chop-long-lines --tilde --shift 8"
export LESS="${LESSOPTS}"
export SYSTEMD_LESS="${LESSOPTS}"
export LESSSECURE='1'
export LESSHISTFILE='-'
export LESSCHARSET="utf-8"
unset LESSOPTS

export DEBFULLNAME='Guy Hughes'
export DEBEMAIL="g"$'\u0040'"gxg.me"

export CDPATH="$HOME/Projects"
export STOW_DIR=/usr/local/stow
#}}}

#{{{1 Non-interactive shells
[[ ! $- =~ i ]] && return

#{{{1 TMOUT
if [ "$(id -u)" -eq 0 ]; then
  export TMOUT=300
elif tty | grep tty >/dev/null; then
  export TMOUT=600
else
  export TMOUT=0
fi

#{{{1 Colours
export GREP_COLOR="1;33"
alias grep='grep --color=auto'

# coloured man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;30;03;36m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;35m'

if [ -n "$TMUX" ] || [ "$TERM" = 'screen' ]; then
    if [ -e '/usr/share/terminfo/s/screen-256color-s' ]; then
      export TERM='screen-256color-s'
    elif [[ -e /usr/share/terminfo/s/screen-256color || "$OSTYPE" =~ darwin* ]]; then
        export TERM='screen-256color'
    fi
fi

# Colours for ls
if [[ "$OSTYPE" =~ darwin* ]]; then
  export CLICOLOR=1
  export LSCOLORS=ExFxCxDxBxegedabagacad
else
  eval $(dircolors -b $HOME/.config/dircolors/solarized/dircolors.256dark)
  alias ls='ls --color=auto'
fi
alias tree='tree -C' # colour

#{{{1 RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

