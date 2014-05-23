
# startx if on TTY1 and tmux on TTY2
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec xinit -- vt1 &>/dev/null
    logout
  elif [[ $(tty) = /dev/tty2 ]]; then
    tmux -f $HOME/.tmux/conf new-session -t `hostname` 
fi

test -z "$TMUX" && exec $HOME/bin/onemux
