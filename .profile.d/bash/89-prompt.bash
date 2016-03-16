# originally inspired by https://github.com/icco/dotFiles/blob/master/link/bash_PS1

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

    local UC=
    local PROMPT_CHAR_COLOR="${RST}"
    case "`id -un`" in
      guy|gxg)
        UC="$W"
        ;;
      guyhughes|dev)
        UC="$EMM"
        ;;
      vagrant|COMP2401)
        UC="$EMY"
        ;;
      root)
        UC="$EMR"
        PROMPT_CHAR_COLOR=$UC
        ;;
      *)
        UC="$EMY"
        ;;
    esac

    PS1="\n${RST}"
    [ -n "$VCSH_REPO_NAME" ] && PS1+="${RST}${EMB}vcsh repo ${VCSH_REPO_NAME}${RST}\n"
    if [ "`hostname`" != "dacht" ] || [ "`id -un`" != "gxg" ]; then
      PS1+="${RST}${UC}\u${W}@${RST}\H "
    fi
    PS1+="${RST}${B}\${NEW_PWD}${EMB}\$(__git_ps1)\n${RST}${PROMPT_CHAR_COLOR}\\$ ${RST}"
}

export PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt
