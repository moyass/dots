if [ -d ~/.fzf ]; then
  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && . ~/.fzf/shell/completion.bash 2> /dev/null

  # Key bindings
  # ------------
  . ~/.fzf/shell/key-bindings.bash
fi
