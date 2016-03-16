if [ -d ~/.fzf ]; then

  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && . ~/.fzf/shell/completion.zsh 2> /dev/null

  # Key bindings
  # ------------
  . ~/.fzf/shell/key-bindings.zsh
fi

