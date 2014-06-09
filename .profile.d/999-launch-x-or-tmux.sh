
# startx if on TTY1 and tmux on TTY2
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec xinit -- vt1 &>/dev/null
    logout
  elif [[ -z "$TMUX" ]]; then
    exec $HOME/bin/onemux
  # I don't know why this ugly garbage is here. 20140607T2049Z
  #elif [[ $(tty) = /dev/tty2 ]]; then
  #  tmux -f $HOME/.tmux/conf new-session -t `hostname` 
fi

