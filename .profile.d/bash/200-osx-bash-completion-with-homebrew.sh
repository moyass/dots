# For OSX
# ============================

if   [[ "$IS_OSX" = true ]]; then
  # bash completion in osx, thanks to homebrew
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi

fi
