###################
# 100-bash-options.sh

set -o vi
set -o noclobber            # do not overwrite files
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
shopt -s checkwinsize       # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist            # save multi-line commands in history as single line
shopt -s histappend         # do not overwrite history
shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases     # expand aliases
shopt -s extglob            # enable extended pattern-matching features
shopt -s globstar           # recursive globbing…
shopt -s progcomp           # programmable completion
shopt -s hostcomplete       # attempt hostname expansion when @ is at the beginning of a word




###################
# 200-bash-completition.sh


# Bash Completion 
# ==================================
# Condition: 	Does nothing if ~/.inputrc exists
# Execution:	Appends options to ~/.inputrc
# Environment:	Includes /etc/inputrc if it exists at runtime

#if [ ! -a ~/.inputrc ]; then
#
#  [ ! -a /etc/inputrc ] && echo "\$include /etc/inputrc" >> ~/.inputrc;
#  cat << EEP >> ~/.inputrc
#set completion-ignore-case on
#set completion-map-case on
#set completion-query-items 200
#set visible-stats on
#set skip-completed-text on
#set input-meta on
#set output-meta on
#set convert-meta off
#set mark-symlinked-directories on
#set show-all-if-ambiguous on
#set match-hidden-files on
#set page-completions off
#"\e[B": history-search-forward
#"\e[A": history-search-backward
#"\e[3;3~": kill-word
#EEP
#fi


if [[ "$OSTYPE" =~ darwin* ]]; then

	# http://sigpipe.macromates.com/2012/08/10/path-completion-bash
	FIGNORE=".o:~:Application Scripts"
fi





###################
# 200-osx-bash-completion-with-homebrew.sh

# For OSX
# ============================

if   [[ "$OSTYPE" =~ darwin* ]]; then
  # bash completion in osx, thanks to homebrew
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi

fi



###################
# 999-prompt.sh

# upstream https://github.com/icco/dotFiles/blob/master/link/bash_PS1

bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=23
    # Indicate that there has been dir truncation
    local trunc_symbol="..."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

bash_prompt() {
    # regular colors
    local K="\[\033[0;30m\]" # black
    local R="\[\033[0;31m\]" # red
    local G="\[\033[0;32m\]" # green
    local Y="\[\033[0;33m\]" # yellow
    local B="\[\033[0;34m\]" # blue
    local M="\[\033[0;35m\]" # magenta
    local C="\[\033[0;36m\]" # cyan
    local W="\[\033[0;37m\]" # white
    local RST="\[\033[0m\]" # Text reset

    # empahsized (bolded) colors
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"

    # background colors
    local BGK="\[\033[40m\]"
    local BGR="\[\033[41m\]"
    local BGG="\[\033[42m\]"
    local BGY="\[\033[43m\]"
    local BGB="\[\033[44m\]"
    local BGM="\[\033[45m\]"
    local BGC="\[\033[46m\]"
    local BGW="\[\033[47m\]"

    local UC=$W # user's color
    [ $UID -eq "0" ] && UC=$R # root's color

    #PS1="${EMK}[${UC}\u${EMK}@${UC}\h ${EMB}\${NEW_PWD}${EMK}]${UC}\\$ ${NONE}"
    # without colors: PS1="[\u@\h \${NEW_PWD}]\\$ "
    # extra backslash in front of \$ to make bash colorize the prompt

    local GITBRANCH='`git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'

    # install prompt
    # PS1="${RST}\n[ ${B}\$(date -u +\"%Y%m%d${W}T${B}%H%M${W}Z\")${RST} ] $GITBRANCH $P4CLIENT \n${RST}[ ${UC}\u${RST}@${UC}\h ${EMB}\${NEW_PWD}${RST} ]${UC}\\$ ${RST}"
    PS1="${RST}\n${B}\$(date -u +\"%Y%m%d${W}T${B}%H%M${W}Z\")${RST} \u${W}@${RST}\H ${B}$GITBRANCH \n${M}\${NEW_PWD}${RST}\n${UC}\\$ ${RST}"
}

export PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt



