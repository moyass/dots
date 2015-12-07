#{{{1 Non-interactive shells
[[ ! $- =~ i ]] && return

#{{{1 OS-Dependent
case "$OSTYPE" in
  #{{{2 OSX
  # ============================
  darwin*)
    # pidof for poor, poor osxie
    pidof () { ps -Acw | egrep -i $@ | awk '{print $1}'; }

    # cd into whatever is the forefront Finder window
    cdf() {  # short for cdfinder
      cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
    }

    # who is using the laptop's iSight camera?
    camerausedby() {
      echo "Checking to see who is using the iSight camera… 📷"
      usedby=$(lsof | grep -w "AppleCamera\|USBVDC\|iSight" | awk '{printf $2"\n"}' | xargs ps)
      echo -e "Recent camera uses:\n$usedby"
    }

    # Lock current session
    alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

    # Sniff network info
    alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"

    # Show current Finder directory
    finder () {
      osascript 2>/dev/null <<EOL
      tell application "Finder"
      return POSIX path of (target of window 1 as alias)
      end tell
EOL
    }
  ;;
  #{{{2 Linux
  # ============================
  linux*)
    if [[ $(which trash) =~ /trash/ ]]; then
      alias trash = "trash-put"
    fi

    # pgrep: Process grep output full paths to binaries
    alias pgrep='pgrep -fl'

    #{{{2 systemd aliases
    # inspired by https://github.com/daoo/dotfiles/blob/master/zsh/zshrc#L83
    alias ctl='systemctl'
    alias jctl='sudo journalctl'
    alias sctl='sudo systemctl'
    alias uctl='systemctl --user'
    #}}}
    ;;
esac

#{{{1 history, dirs, vim, ls
alias h='history'
alias j="jobs -l"

alias d='dirs -v'
alias dirs='dirs -v'
alias mkd='mkdir -p'

alias c="LANG='c'"

alias bim="vim"
alias cim="vim"
alias vom="vim"
alias vi='vim'
alias vimj="vim **/*.java"

if ls --group-directories-first > /dev/null 2>&1; then
  alias l='ls -hF --group-directories-first' # no --group-dir.. on BSD ls
else
  alias l='ls -hF'
fi
alias ll='l -lh'
alias la='l -A'
alias lal='l -lA'
alias lla='lal'

alias bts='bts --mutt'

#{{{1 SSH and TMUX
# =============================
keys () {
  eval `keychain --eval --quiet --agents ssh,gpg --inherit any-once --attempts 3 --timeout 15 id_rsa`
  keychain --systemd --stop others --quiet
}
alias k=keys

reagent () {
  for agent in /tmp/ssh-*/agent.*; do
    export SSH_AUTH_SOCK=$agent

    if ssh-add -l 2>&1 >/dev/null; then
      echo "Found working SSH Agent..."
      ssh-add -l
    else
      echo "Cannot find ssh agent"
    fi
  done
} 
sshux () { ssh "$1" -t 'tmux a -d || tmux'; }
ssho  () { ssh -t "$*" -- 'exec ~/bin/onemux'; }
sshk  () { ssh -A "$*"; }
sshok () { ssh -tA "$*" -- 'exec ~/bin/onemux'; }
tmuxa () { [[ -z "$TMUX" ]] && { tmux attach -d || tmux; } }
#{{{1 Encryption
alias rot13='tr a-zA-Z n-za-mN-ZA-M <<<'
aes_encypt () {
  openssl enc -aes-256-cbc -e -in $1 -out "$1.aes"
}
aes_decrypt () {
  openssl enc -aes-256-cbc -d -in $1 -out "${1%.*}"
} #}}}
#{{{1 Extract
extract() {
  # TODO: remove this or improve it
  if [ -f $1 ]; then
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
#{{{1 GNU Find
set_finder() {
  FIND="find"
  if [[ "$OSTYPE" =~ darwin* ]]; then
    if command -v gfind 2>&1 >/dev/null; then
      FIND="gfind"
    else
      echo "You need GNU find.\n$ brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt"
      exit 2
    fi
  fi
}
cleanout() { 
  set_finder
  op="$FIND . -type f -regextype posix-extended -regex '((.*\.(pyc|pyo|bak|tmp|toc|aux|log|cp|fn|tp|vr|pg|ky))|(.*\~))'"
  if [ $# -eq 1  ]; then
    case "$1" in
      "-f")
        eval $op -delete 
        ;;
      "-i")
        eval "$op -exec rm -i {} \;"
        ;;
    esac
  else
    eval $op | column
  fi
}
findregex () {
  set_finder
  if [ $# -lt 2 ]; then
    searchpath='.'
    search="${1}"
  else
    searchpath="${1}"
    search="${2}"
  fi
  $FIND "$searchpath" -regextype posix-extended -type f -regex "$search"
}
unset set_finder
