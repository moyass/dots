#
# .zshrc
#

# Benefitting from other's efforts:
# Marks H. Nichols: http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/
# Valodim: https://github.com/Valodim/zshrc
# Jason W. Ryan: https://bitbucket.org/jasonwryan/shiv/ 
# Jorge Israel Peña: https://github.com/blaenk/dots/tree/master/zsh/zsh

### MODULES {{{1
autoload -U colors edit-command-line zmv
autoload -Uz vcs_info
autoload -Uz +X compinit bashcompinit 
colors && compinit -i && bashcompinit
zmodload -i zsh/complist
zmodload zsh/terminfo
zle -N edit-command-line

#}}}1

### OPTIONS {{{1
ZDOTDIR="$HOME/.profile.d/zsh/"

# ===== Basics {{{2
setopt no_beep              # don't beep on error
setopt interactive_comments # Allow comments even in interactive shells (especially for Muness)

# ===== Changing Directories  {{{2
setopt auto_cd           # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt cdablevars        # if argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory
setopt pushd_ignore_dups # don't push multiple copies of the same directory onto the directory stack
setopt autopushd pushdminus pushdsilent pushdtohome # http://zsh.sourceforge.net/Intro/intro_6.html

# ===== Expansion and Globbing  {{{2
setopt extended_glob          # treat #, ~, and ^ as part of patterns for filename generation

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
setopt menu_complete # autoselect the first completion entry


# ===== Prompt    {{{2

setopt prompt_subst      # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt prompt_percent
setopt transient_rprompt # only show the rprompt on the current prompt

autoload -U promptinit && promptinit

# ===== Scripts and Functions    {{{2

setopt multios          # perform implicit tees or cats when multiple redirections are attempted


# man zshcontrib
 zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
 zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
 zstyle ':vcs_info:*' enable git #svn cvs 

#}}}1
#
### COMPLETION {{{1


# completion stuff
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path $ZDOTDIR/cache

zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:*' max-errors 3
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
zstyle ':completion:*:descriptions' format $'%F{green}―――――― %d ――――――%b%f'
zstyle ':completion:*:messages' format $'%F{cyan}―――――― %d ――――――%f'
zstyle ':completion:*:warnings' format $'%F{red}%B―――――― No Matches Found ――――――%f'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' auto-description '%d'

# match uppercase from lowercase, and left-side substringss()
zstyle ':completion:*' matcmer-list 'm:{a-z}={A-Z}' '+l:|=*'

# command completion: highlight matching part of command, and
#zstyle -e ':completion:*:-command-:*:commands' list-colors 'reply=( '\''=(#b)('\''$words[CURRENT]'\''|)*-- #(*)=0=38;5;45=38;5;136'\'' '\''=(#b)('\''$words[CURRENT]'\''|)*=0=38;5;45'\'' )'

# This is needed to workaround a bug in _setup:12, causing almost 2 seconds delay for bigger LS_COLORS
# UPDATE: not sure if this is required anymore, with the -command- style above.. keeping it here just to be sure
#zstyle ':completion:*:*:-command-:*' list-colors ''

# use LS_COLORS for file coloring
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:' list-colors ${(s.:.)LS_COLORS}

# generic, highlight matched part
# WACKY behavior with zstyle precedence, not using this for now!
# zstyle -e ':completion:*' list-colors '[[ -z $words[CURRENT] ]] && return 1; reply=( '\''=(#b)('\''$words[CURRENT]'\'')*=0=38;5;45'\'' )'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# show command short descriptions, too
zstyle ':completion:*' extra-verbose yes
# make them a little less short, after all (mostly adds -l option to the whatis calll)
zstyle ':completion:*:command-descriptions' command '_call_whatis -l -s 1 -r .\*; _call_whatis -l -s 6 -r .\* 2>/dev/null'

# x11 colors
zstyle ":completion:*:colors" path '/etc/X11/rgb.txt'

# for sudo kill, show all processes except childs of kthreadd (ie, kernel
# threads), which is assumed to be PID 2. otherwise, show user processes only.
zstyle -e ':completion:*:*:kill:*:processes' command '[[ $BUFFER == sudo* ]] && reply=( "ps --forest -p 2 --ppid 2 --deselect -o pid,user,cmd" ) || reply=( ps x --forest -o pid,cmd )'
zstyle ':completion:*:processes-names' command 'ps axho command'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

zstyle ':completion:*' completer _complete _correct _approximate
# zstyle ':completion:*' expand prefix suffix
# zstyle ':completion:*' completer _expand_alias _complete _approximate
# zstyle ':completion:*' menu select
# zstyle ':completion:*' file-sort name
# zstyle ':completion:*' ignore-parents pwd
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# # Fallback to built in ls colors;
# #zstyle ':completion:*' list-colors ''

# # Make the list prompt friendly
# zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# # Make the selection prompt friendly when there are a lot of choices
# zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# # Enable completion caching, use rehash to clear
# zstyle ':completion::complete:*' use-cache on
# zstyle ':completion::complete:*' cache-path $ZDOTDIR/cache/$HOST

# # Add simple colors to kill
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# # list of completers to use
# zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# # match uppercase from lowercase
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# # offer indexes before parameters in subscripts
# zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# # formatting and messages



# # ignore completion functions (until the _ignored completer)
# zstyle ':completion:*:functions' ignored-patterns '_*'
# zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
# zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
# zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
# zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
# zstyle '*' single-ignored show

#}}}

### KEYBINDS     {{{1
bindkey -v
KEYTIMEOUT=1

# fix for cursor position
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[OB" history-beginning-search-forward-end
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
#2}}}
# 1}}}

### PLUGINS {{{1 {{{2
# https://github.com/zsh-users/zsh-syntax-highlighting {{{2
if [ -e $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif command -v git > /dev/null 2>&1; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZDOTDIR/zsh-syntax-highlighting
fi

# https://github.com/zsh-users/zaw {{{2
if [ -e $ZDOTDIR/zaw/zaw.zsh ]; then
  source $ZDOTDIR/zaw/zaw.zsh
  bindkey '^z' zaw-history
  bindkey '^x' zaw-git-files
elif command -v git > /dev/null 2>&1; then
  git clone https://github.com/zsh-users/zaw $ZDOTDIR/zaw
fi


# }}}1
