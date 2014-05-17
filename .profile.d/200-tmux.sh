alias tmux="tmux -f ~/.config/tmux/conf"
mux() { [[ -z "$TMUX" ]] && { tmux attach -d || tmux ;} }
shux() { ssh "$1" -t tmux a -d;}
smux() { ssh $* -t 'tmux new-session -t1 || tmux -f ~/.config/tmux/conf new-session -s1';}

