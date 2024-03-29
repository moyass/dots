
### PROMPT {{{1
VCS_PROMPT=" %F{cyan}→ %F{green}%b%F{magenta}%u%F{magenta}%c%f%m"
AVCS_PROMPT="$VCS_PROMPT %F{cyan}∷%f %F{magenta}%a%f"

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "+"
zstyle ':vcs_info:*' unstagedstr "#"
zstyle ':vcs_info:*' formats $VCS_PROMPT
zstyle ':vcs_info:*' actionformats $AVCS_PROMPT
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*+set-message:*' hooks git-aheadbehind git-untracked git-message

### git: Show +N/-N when your local branch is ahead-of or behind remote HEAD.
# Make sure you have added misc to your 'formats': %m
function +vi-git-aheadbehind()
{
  local ahead behind
  local -a gitstatus

  behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
  (( $behind )) && gitstatus+=( " -%F{red}${behind}%f" )

  ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
  (( $ahead )) && gitstatus+=( " +%F{blue}${ahead}%f" )

  hook_com[misc]+=${(j::)gitstatus}

  if [[ -n ${hook_com[misc]} ]]; then
    hook_com[misc]=" %F{cyan}∷%f${hook_com[misc]}"
  fi
}

### git: Show marker (T) if there are untracked files in repository
# Make sure you have added staged to your 'formats': %c
function +vi-git-untracked()
{
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep '??' &> /dev/null ; then
  # This will show the marker if there are any untracked files in repo.
  hook_com[branch]="%F{magenta}.%F{green}${hook_com[branch]}%f"
fi
}

# proper spacing
function +vi-git-message()
{
  if [[ -n ${hook_com[unstaged]} ]]; then
    if [[ -n ${hook_com[staged]} ]]; then
      hook_com[unstaged]="${hook_com[unstaged]} "
    else
      hook_com[unstaged]="${hook_com[unstaged]}"
    fi
  else
    if [[ -n ${hook_com[staged]} ]]; then
      hook_com[staged]=" ${hook_com[staged]}"
    fi
  fi
}


# use this to add custom segments or do other wacky stuff
precmd () {
  vcs_info
  disambiguate -k
  thepwd=$REPLY
}


line=
rline=
subshell=

line+=$'\n'

if [[ -n "$SSH_CONNECTION" ]] && [[ -z "$TMUX" ]] || [[ "`whoami`" != "gxg"  ]]; then
  line+='%n@%m'$'\n'
fi

[[ -n "$VCSH_REPO_NAME" ]] && line+='%{%b$fg[cyan]%}vcsh repo %{$VCSH_REPO_NAME$reset_color%B%}'$'\n'

# icanhazcolourforbadboyz
line+='%(?..%{$fg[red]%})'

line+='%(!.#.❯) '

# icanhazresetplzz
line+='%{%b$reset_color%}'

PS1="$line"

## HEY DUMBASS: USE STRING LITERALS

# icanhazvcs
rline+='${vcs_info_msg_0_}'

# icanhazpwd
rline+=' %{$fg[cyan]%}$thepwd%{%f%}'

# icanhazsubshell (these don't change after initalization, so its okay to use ifs)
# if [[ "$SHLVL" != 1 ]]; then 
  # subshell+=" %{%b$fg[black]%}[%{$fg[white]%}%L%{$fg[black]%}]%{$reset_color%}"
  # if [[ -n $RANGER_LEVEL ]]; then
    # subshell+=" %{$fg[black]%}ranger%{$reset_color%}"
  # fi
  # rline+=' %{$fg[black]%B%}(%{%b$reset_color%}$subshell %{%B$fg[black]%})%{%b$reset_color%}'
# fi


#"${${KEYMAP/vicmd/[%{ $fg[yellow]%B %} Command Mode %b$fg[yellow]] }/(main|viins)/}"

# icanhazexitstatforbadboyz
rline+='%(?..%{%b$fg[black]%} [%{%B$fg[red]%}%?%{%b$fg[black]%}]%{$reset_color%})'
# rline+="${${KEYMAP/vicmd/⚡}/(main|viins)/}"
export RPROMPT=$rline

#}}}1
