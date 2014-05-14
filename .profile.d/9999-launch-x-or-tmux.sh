
# startx if on TTY1 and tmux on TTY2
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec xinit -- vt1 &>/dev/null
    logout
  elif [[ $(tty) = /dev/tty2 ]]; then
    tmux -f $HOME/.tmux/conf new-session -t `hostname` 
fi

#if not inside a tmux session, and if no session is started, start a new session
test -z "$TMUX" && (tmux new-session -t 0)
#test -z "$TMUX" && (tmux new-session -t 0 || tmux new-session -s 0)
