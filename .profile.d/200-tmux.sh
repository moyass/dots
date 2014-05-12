export TERMINAL="urxvtc"


alias tmux="tmux -f ~/.tmux/conf"
mux() { [[ -z "$TMUX" ]] && { tmux attach -d || tmux -f $HOME/.tmux/conf new -s secured ;} }
shux() { ssh "$1" -t tmux a -d ;}

# startx if on TTY1 and tmux on TTY2
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec xinit -- vt1 &>/dev/null
    logout
  elif [[ $(tty) = /dev/tty2 ]]; then
    tmux -f $HOME/.tmux/conf new -s secured
fi

#if not inside a tmux session, and if no session is started, start a new session
test -z "$TMUX" && (tmux attach || tmux new-session)

tsess=$(tmux ls)

