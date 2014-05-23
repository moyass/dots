alias tmux="tmux -f ~/.config/tmux/conf"
mux() { [[ -z "$TMUX" ]] && { tmux attach -d || tmux ;} }
shux() { ssh "$1" -t tmux a -d;}
smux() { ssh $* -t 'exec ~/bin/onemux';}


[[ -n "$SSH_CONNECTION" ]] && tmux set-option -g status-right '#[default]#(whoami)#[fg=black]@#[fg=colour166]#[bold]#{host}'
