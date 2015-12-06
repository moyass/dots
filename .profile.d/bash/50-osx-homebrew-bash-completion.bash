# For OSX
# ============================

if   [[ "$OSTYPE" =~ darwin* ]]; then
	# http://sigpipe.macromates.com/2012/08/10/path-completion-bash
	FIGNORE=".o:~:Application Scripts"

  # bash completion in osx, thanks to homebrew
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi
