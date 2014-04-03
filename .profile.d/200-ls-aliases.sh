
# Colours for ls.
# =========================================
if [[ "$IS_OSX" = true ]]; then
  # Use colours in OSX ls
  export CLICOLOR=1
  export LSCOLORS=ExFxCxDxBxegedabagacad
else
  # Use color in ls
  alias ls='ls --color=auto'
fi

# Most beautiful set of LS aliases ever.
# =========================================

alias l='ls -FAh'
alias ll='l -l'
alias la='l -A'
alias lal='l -lA'
alias lla='lal'

