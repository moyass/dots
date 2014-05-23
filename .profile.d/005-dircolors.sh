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
