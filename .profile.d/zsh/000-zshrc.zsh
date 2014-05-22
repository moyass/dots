#
# .zshrc
#

# Benefitting from other's efforts:
# Marks H. Nichols: http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/
# Jason W. Ryan: https://bitbucket.org/jasonwryan/shiv/t 
# Jorge Israel Peña: https://github.com/blaenk/dots/tree/master/zsh/zsh

### MODULES {{{1
autoload -U colors promptinit bashcompinit edit-command-line zmv
autoload -Uz compinit vcs_info
colors && compinit -i && promptinit && bashcompinit
zmodload zsh/complist
zle -N edit-command-line

#}}}1


### OPTIONS {{{1
ZDOTDIR="$HOME/.profile.d/zsh/"
# ===== Basics {{{2
setopt no_beep              # don't beep on error
setopt interactive_comments # Allow comments even in interactive shells (especially for Muness)

# ===== Changing Directories  {{{2

setopt auto_cd # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt cdablevarS # if argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory
setopt pushd_ignore_dups # don't push multiple copies of the same directory onto the directory stack

# ===== Expansion and Globbing  {{{2
setopt extended_glob # treat #, ~, and ^ as part of patterns for filename generation

# ===== History  {{{2
setopt append_history         # Allow multiple terminal sessions to all append to one zsh command history
setopt extended_history       # save timestamp of command and duration
setopt inc_append_history     # Add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups       # Do not write events to history that are duplicates of previous events
setopt hist_ignore_space      # remove command line from history list when first character on the line is a space
setopt hist_find_no_dups      # When searching history don't display results already cycled through twice
setopt hist_reduce_blanks     # Remove extra blanks from each command line being added to history
setopt hist_verify            # don't execute, just expand history
setopt share_history          # imports new commands and appends typed commands to history
                              # history options
export HISTFILE="$ZDOTDIR/histfile"
export HISTSIZE=10000
export SAVEHIST=$((HISTSIZE/2))
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY



# ===== Completion   {{{2

setopt always_to_end    # When completing from the middle of a word, move the cursor to the end of the word
setopt auto_menu        # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs   # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word # Allow completion from within a word/phrase
setopt autocd extendedglob nomatch completealiases

# ===== Correction    {{{2

setopt correct         # spelling correction for commands
setopt no_correctall   # …only for commands, not filenames or parameters
unsetopt menu_complete # do not autoselect the first completion entry


# ===== Prompt    {{{2

setopt prompt_subst      # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt transient_rprompt # only show the rprompt on the current prompt

# ===== Scripts and Functions    {{{2

setopt multios          # perform implicit tees or cats when multiple redirections are attempted

#}}}1

### COMPLETION {{{1

# man zshcontrib
# zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
# zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
# zstyle ':vcs_info:*' enable git #svn cvs 

zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' completer _expand_alias _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort name
zstyle ':completion:*' ignore-parents pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Fallback to built in ls colors
#zstyle ':completion:*' list-colors ''

# Make the list prompt friendly
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# Make the selection prompt friendly when there are a lot of choices
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path $ZDOTDIR/cache/$HOST

# Add simple colors to kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

#}}}

### KEYBINDS     {{{1
bindkey -v
KEYTIMEOUT=1

# fix for cursor position
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "\ep" insert-last-word
bindkey "\eq" quote-line
bindkey "\ek" backward-kill-line

# === Menu {{{2
# # use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history  

bindkey -M menuselect "^M" .accept-line # enter command by default
bindkey -M menuselect "^G" accept-line # accept completion, don't enter
bindkey -M menuselect "+" accept-and-menu-complete # accept completion, stay in menu
bindkey -M menuselect "^[[Z" reverse-menu-complete

bindkey -M menuselect "^P" reverse-menu-complete
bindkey -M menuselect "^N" menu-complete

# === vi command mode {{{2
bindkey ' ' magic-space
bindkey -M vicmd "gg" beginning-of-history
bindkey -M vicmd "G" end-of-history
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M vicmd "u" undo
bindkey -M vicmd v edit-command-line
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

# === vi insert {{{2
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins "^L" clear-screen
bindkey -M viins "^P" up-line-or-history
bindkey -M viins "^N" down-line-or-history
bindkey -M viins "^R" history-incremental-search-backward
bindkey -M viins "^W" backward-kill-word
bindkey -M viins "^A" beginning-of-line
bindkey -M viins "^E" end-of-line
bindkey -M viins "^H" backward-delete-char # vi-backward-delete-char
bindkey -M viins "^U" backward-kill-line # vi-kill-line
bindkey -M viins "^?" backward-delete-char # vi-backward-delete-char

# === search {{{2
# allow interactive incr search, ^G or ^C to exit
bindkey -M isearch "^P" history-incremental-search-backward
bindkey -M isearch "^N" history-incremental-search-forward



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



# prompt with vimode
function canihasprompt()
{
  local line=""
  local subshell=""
  vcs_info
  if [[ "$SHLVL" != 1 ]]; then
    subshell+="%{$fg[black] [$SHLVL]$reset_color%}"
    if [[ -n $RANGER_LEVEL ]]; then
      subshell+=" %{$fg[black]%}ranger%{$reset_color%}"
    fi
    line+=$'\n'"%{$fg[black]%B%}(%{%b$reset_color$subshell%} %{%B$fg[black]%})%{%b$reset_color%}"
  fi
  if [[ -n $vcs_info_msg_0_ ]]; then
    line+="$vcs_info_msg_0_"
  fi
  echo $line
}

[[ -n "$SSH_CONNECTION" ]] && sshinfo='%{%n@%m%}'
function zle-line-init zle-keymap-select
{
  if [[ $UID == 0 ]]; then
    PS1="$(canihasprompt)%{$fg[red]%B%}#%{%b$reset_color%} "
  else
    PROMPT=$'$(canihasprompt)\n❯ '
  fi

  RPS1="%{$fg[yellow]%}${${KEYMAP/vicmd/[%B Command Mode %b$fg[yellow]]}/(main|viins)/} %{$fg[black]%}$sshinfo%{%f%}"
  RPS2=$RPS1
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#}}}1
