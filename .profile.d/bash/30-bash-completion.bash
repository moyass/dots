# Bash Completion 
# ==================================

if [ ! -f ~/.inputrc ]; then

 [ -f /etc/inputrc ] && echo "\$include /etc/inputrc" > ~/.inputrc;

 cat << EEP >> ~/.inputrc
set completion-ignore-case on
set completion-map-case on
set completion-query-items 200
set visible-stats on
set skip-completed-text on
set input-meta on
set output-meta on
set convert-meta off
set mark-symlinked-directories on
set show-all-if-ambiguous on
set match-hidden-files on
set page-completions off
"\e[B": history-search-forward
"\e[A": history-search-backward
"\e[3;3~": kill-word
EEP

fi


