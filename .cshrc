echo "================================================================================" 
echo "        WARNING! You are in ${SHELL} and your life is miserable!"
printf '%40s %s\n' 'User' `id -un`
printf '%40s %s\n' 'Hostname' `hostname `
printf '%40s %s\n' 'Domain' `hostname --domain`
printf '%40s %s\n' 'IP' `hostname --all-ip-addresses`
echo "================================================================================" 
echo ''
alias q exit
alias vim vi
alias l ls -hF --group-directories-first
alias la ls -hF --group-directories-first -A
alias lal ls -hF --group-directories-first -A -l
alias lla ls -hF --group-directories-first -A -l
alias rmi rm -i

alias ssh1 ssh -t -A vmicron01 /bin/zsh
alias ssh1 ssh -t -A vmicron01 /bin/zsh
alias ssh2 ssh -t -A vmicron02 /bin/zsh
alias ssh3 ssh -t -A vmicron03 /bin/zsh
alias ssh4 ssh -t -A vmicron04 /bin/zsh
alias ssh5 ssh -t -A vmicron05 /bin/zsh
alias ssh6 ssh -t -A vmicron06 /bin/zsh
alias ssh7 ssh -t -A vmicron07 /bin/zsh
alias ssh8 ssh -t -A vmicron08 /bin/zsh
alias ssh9 ssh -t -A vmicron09 /bin/zsh
