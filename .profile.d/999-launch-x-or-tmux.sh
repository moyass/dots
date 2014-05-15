
# startx if on TTY1 and tmux on TTY2
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec xinit -- vt1 &>/dev/null
    logout
  elif [[ $(tty) = /dev/tty2 ]]; then
    tmux -f $HOME/.tmux/conf new-session -t `hostname` 
fi

if [[ -n "$SSH_CLIENT" ]]; then
  #ssh
  # if not inside a tmux session, reattach!, or if no session is started, start a new session
  #for headless
  test -z "$TMUX" && (tmux -q has-session && exec tmux attach-session -d || exec tmux -f ~/.config/tmux/conf new-session -s1 )
else
  #locally
  # join the session group started by systemd --user
  test -z "$TMUX" && (exec tmux new-session -t 1)
fi
