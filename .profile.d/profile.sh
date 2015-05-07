
###########################################
# PATH  {{{

# A function to protect you from yourself.
# ========================================
adjunct_path_with () {
  adjunctor="$1"    # the directory  ## WARN: DO NOT USE TRAILING SLASH OR THE WORLD ENDS!
  override="$2"    # if $2 is true: $1 is prefixed to PATH; else $1 is appended to PATH

  if [[ -d "$adjunctor" ]]; then
    if [[ "$override" != false ]]; then
      PATH="$1:$PATH"
    else
      PATH="$PATH:$1"
    fi
  fi
}

# Add local bin
# ===================
adjunct_path_with "/usr/local/bin" true

# Add composer user bin
# ===================
adjunct_path_with "${HOME}/.composer/vendor/bin" true


# Npm!
# ===================
adjunct_path_with "${HOME}/.npm/bin" true

# OSX.
# ===================
if [[ "$OSTYPE" =~ darwin* ]]; then
  # Add localbins  to path, esp for homebrew
  adjunct_path_with "/usr/local/sbin" true

elif [[ "$OSTYPE" =~ linux* ]]; then
  # so i can play pacman 
  adjunct_path_with "/usr/games" true

fi

# sbins.
# ===================
adjunct_path_with "/sbin" true
adjunct_path_with "/usr/sbin" true

# User's bin.
# ===================
adjunct_path_with "${HOME}/bin"  true

# Cleanup.
# ===================
unset -f adjunct_path_with
export PATH

#}}}

###########################################
# RVM & Gems#{{{

#  Load RVM into a shell session, but only if running interactively.
# ============================
# https://github.com/icco/dotFiles/blob/ec264f5c311a3d0bfbd861c2d648b04d3d89c126/link/bashrc
if [ -z "$PS1" ]; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
  return
fi

#  Pull user gems into path.
# ============================
# http://guides.rubygems.org/faqs/#user-install
if which ruby >/dev/null && which gem >/dev/null; then
  PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi #}}}

###########################################
# Environment Variables #{{{

if [[ "$OSTYPE" =~ darwin* ]]; then
  # Use the open command on OSX
  export BROWSER='open'

elif [[ "$OSTYPE" =~ linux* ]]; then
  stty -ixon
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

#export ARCHFLAGS="-arch x86_64"

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
#}}}

###########################################
# TMOUT#{{{

#export TMOUT=300
#}}}

###########################################
# ls colours#{{{

# Colours for ls.
# =========================================
if [[ "$OSTYPE" =~ darwin* ]]; then
  # Use colours in OSX ls
  export CLICOLOR=1
  export LSCOLORS=ExFxCxDxBxegedabagacad
else
  eval $(dircolors -b $HOME/.config/dircolors/solarized/dircolors.256dark)
  # Use color in ls
  alias ls='ls --color=auto'
fi
#}}}

###########################################
# 200-keychain-aliases.sh

alias keys=". ~/.keychain/`hostname`-sh; ssh-add -l" 

###########################################
# ls aliases#{{{


alias l='ls -AhF'
alias ll='l -lh'
alias la='l -A'
alias lal='l -lA'
alias lla='lal'
#}}}

###########################################
# other aliases#{{{

# OSX
# ============================

if  [[ "$OSTYPE" =~ darwin* ]]; then

  # pidof for poor, poor osxie
  pidof () { ps -Acw | egrep -i $@ | awk '{print $1}'; }

  # rm with trash (`brew install trash`).
  if [ -f `brew --prefix`/bin/trash ]; then
    alias rm='trash'
  fi

  # Lock current session.
  alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

  # Sniff network info.
  alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"

  # Show current Finder directory.
  finder () {
    osascript 2>/dev/null <<EOL
    tell application "Finder"
    return POSIX path of (target of window 1 as alias)
    end tell
EOL
  }

  # NON-OS X
  # ============================
else

  # pgrep: Process grep output full paths to binaries.
  alias pgrep='pgrep -fl'

fi

# General
# ============================
alias h='history'
alias j="jobs -l"
alias p="cd ~/Projects/"

alias d='dirs -v'
alias dirs='dirs -v'

alias bim="vim"
alias cim="vim"
alias vom="vim"
alias vi='vim'

alias sue='/usr/bin/sudo -sE'

# aes-enc file.zip
function aes-enc() {
openssl enc -aes-256-cbc -e -in $1 -out "$1.aes"
}

# aes-dec file.zip.aes
function aes-dec() {
openssl enc -aes-256-cbc -d -in $1 -out "${1%.*}"
}

# Execute commands for each file in current directory.
function each() {
for dir in *; do
  echo "${dir}:"
  cd $dir
  $@
  cd ..
done
}

# Find files and exec commands at them.
# $ find-exec .coffee cat | wc -l
# # => 9762
function find-exec() {
find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}


if [[ "$OSTYPE" =~ linux* && $(which trash) =~ /trash/ ]]; then
  alias trash = "trash-put" 
fi
#}}}


###########################################
# systemd aliases#{{{

#https://github.com/daoo/dotfiles/blob/master/zsh/zshrc#L83
alias ctl='systemctl'
alias uctl='systemctl --user'
#}}}


###########################################
# tmux aliases#{{{

alias tmux="tmux -f ~/.config/tmux/conf"
mux() { [[ -z "$TMUX" ]] && { tmux attach -d || tmux ;} }
shux() { ssh "$1" -t tmux a -d;}
smux() { ssh $* -t 'exec ~/bin/onemux';}
#}}}

###########################################
# i3wm aliases#{{{

alias move-workspace-right="i3-msg move workspace to output right"
alias move-workspace-left="i3-msg move workspace to output left"
#}}}

###########################################
# extract#{{{

extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.xz)    tar xvJf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *.xz)        unxz $1        ;;
      *.exe)       cabextract $1  ;;
      *)           echo "\`$1': unrecognized file compression" ;;
    esac
  else
    echo "\`$1' is not a valid file"
  fi
}
#}}}

###########################################
# jjclean#{{{

jjclean() {
  cleanies=`ls \#* *~ .*~ *.bak .*.bak *.tmp .*.tmp core a.out .DS_Store *.toc *.aux *.log *.cp *.fn *.tp *.vr *.pg *.ky`;
  echo "Will delete $(echo $cleanies | wc -l | tr -d ' ') files."
  echo -n "Really clean this directory? ";
  read yorn;
  if test "$yorn" = "y"; then
    rm -vf $cleanies;
    echo "Cleaned.";
  else
    echo "Not cleaned.";
  fi
}
#}}}

###########################################
#  jjfind#{{{

## For finding stuff in a directory.
jjfind () {
  if [ $# -lt 2 ]; then
    files="*";
    search="${1}";
  else
    files="${1}";
    search="${2}";
  fi;
  find . -name "$files" -a ! -wholename '*/.*' -exec grep -Hin ${3} "$search" {} \; ;
}
#}}}

###########################################
# Hostname file#{{{

# WARN: Echoing feedback causes ssh cloud apps to fail. Sad.

source_if_exists () {
  if [ -f $1 ]; then
    source $1
  fi

}

THEHOSTNAME=`hostname`
THESHORTHOSTNAME=`hostname -s`

# Sometimes `hostname` is fqdn, sometimes not. 
# This is anonying.
# So just check for both.

if [ $THEHOSTNAME != $THESHORTHOSTNAME   ]; then
  source_if_exists ~/.profile.d/hostnames/${THESHORTHOSTNAME}.sh
  source_if_exists ~/.profile.d/hostnames/${THESHORTHOSTNAME}.private.sh
fi

source_if_exists ~/.profile.d/hostnames/${THEHOSTNAME}.sh
source_if_exists ~/.profile.d/hostnames/${THEHOSTNAME}.private.sh

unset THEHOSTNAME
unset THESHORTHOSTNAMEt
unset source_if_exists
#}}}

###########################################
# xinit#{{{


# startx if on TTY1 and tmux on TTY2
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec xinit -- vt1 &>/dev/null
  logout
  A
fi
#}}}
