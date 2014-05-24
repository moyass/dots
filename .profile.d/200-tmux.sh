alias tmux="tmux -f ~/.config/tmux/conf"
mux() { [[ -z "$TMUX" ]] && { tmux attach -d || tmux ;} }
shux() { ssh "$1" -t tmux a -d;}
smux() { ssh $* -t 'exec ~/bin/onemux';}


