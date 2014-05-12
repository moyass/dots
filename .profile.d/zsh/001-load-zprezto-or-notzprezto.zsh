#!/usr/bin/env zsh

# To ZPREZTO or NOTZPREZTO that is the question!
# ================================================

if ! autoload -Uz is-at-least || ! is-at-least '4.3.11'; then
  # ZSH is too old for zprezto, load znotzprezto :(
  echo "WARN: ZSH is too old for zprezto on this box. Try bash."
  for file (~/.profile.d/zsh/not-zprezto/*.zsh); do
     source ${file}
  done

else 
  # Load zprezto

  # If no zprezto, install from github, and chsh
  if [[ ! -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    
    # WARN: DANGER! DANGER! DANGER!
    # Bash's ubiquity has utimate usefulness.
    # The pain of switching shells is tedious.
    # Use bash everywhere now.
    # chsh -s /bin/zsh
  fi

  # load zprezto config
  for file (${ZDOTDIR:-$HOME}/.profile.d/zsh/zprezto/*.zsh); do
    source ${file}
  done

fi
