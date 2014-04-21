# OSX
# ============================

if  [[ "$IS_OSX" = true ]]; then

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

alias bim="vim"
alias cim="vim"
alias vom="vim"
alias vi='vim'

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

# Opens file in EDITOR.
function edit() {
  local dir=$1
  [[ -z "$dir" ]] && dir='.'
  $EDITOR $dir
}
alias e=edit

# Find files and exec commands at them.
# $ find-exec .coffee cat | wc -l
# # => 9762
function find-exec() {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}
