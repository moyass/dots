#  ______  _____  _    _  _____    _____
# |___  / / ____|| |  | ||  __ \  / ____|
#    / / | (___  | |__| || |__) || |
#   / /   \___ \ |  __  ||  _  / | |
#  / /__  ____) || |  | || | \ \ | |____
# /_____||_____/ |_|  |_||_|  \_\ \_____|
# https://github.com/guyhughes
#
# Inspired By:
#  Marks H. Nichols:  http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/
#           Valodim:  https://github.com/Valodim/zshrc
#     Jason W. Ryan:  https://bitbucket.org/jasonwryan/shiv/
# Jorge Israel Peña:  https://github.com/blaenk/dots/tree/master/zsh/zsh

###1 MODULES
autoload -U colors edit-command-line zmv promptinit
autoload -Uz vcs_info
autoload -Uz +X compinit bashcompinit
promptinit
colors && compinit -i && bashcompinit
zmodload -i zsh/complist
zmodload zsh/terminfo
zle -N edit-command-line

###1 OPTIONS
ZDOTDIR="$HOME/.profile.d/zsh/"

###2 Basics
setopt no_beep              #   don't beep on error
setopt interactive_comments #   Allow comments even in interactive shells

### 2 Changing Directories
setopt auto_cd              #   If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt cdablevars           #   if argument to cd is the name of a parameter whose value is a valid directory, it will become the current directory
setopt pushd_ignore_dups    #   don't push multiple copies of the same directory onto the directory stack
setopt autopushd pushdminus pushdsilent pushdtohome # http://zsh.sourceforge.net/Intro/intro_6.html

###2 Expansion and Globbing
setopt extended_glob          # treat #, ~, and ^ as part of patterns for filename generation
alias ng="noglob"

###2 History
export HISTFILE="$ZDOTDIR/histfile"
export HISTSIZE=10000
export SAVEHIST=$((HISTSIZE/2))
setopt APPEND_HISTORY         # Allow multiple terminal sessions to all append to one zsh command history
setopt EXTENDED_HISTORY       # save timestamp of command and duration
setopt SHARE_HISTORY          # imports new commands and appends typed commands to history
setopt HIST_EXPIRE_DUPS_FIRST # when trimming history, lose oldest duplicates first
setopt HIST_IGNORE_ALL_DUPS   # removed older version of dupes
setopt HIST_IGNORE_SPACE      # don't add commands that start with space
setopt HIST_FIND_NO_DUPS      # When searching history don't display results already cycled through twice
setopt HIST_REDUCE_BLANKS     # Remove extra blanks from each command line being added to history
setopt HIST_VERIFY            # don't execute, just expand history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS

###2 Completion
setopt ALWAYS_TO_END    # When completing from the middle of a word, move the cursor to the end of the word
setopt AUTO_MENU        # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt AUTO_NAME_DIRS   # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt COMPLETE_IN_WORD # Allow completion from within a word/phrase
setopt GLOB_COMPLETE
setopt COMPLETE_ALIASES
setopt NOMATCH

###2 Correction
setopt CORRECT       # spelling correction for commands
setopt NO_CORRECTALL # …only for commands, not filenames or parameters
setopt MENU_COMPLETE # autoselect the first completion entry

###2 Prompt
setopt prompt_subst      # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt prompt_percent

###2 Scripts and Functions
setopt multios          # perform implicit tees or cats when multiple redirections are attempted

# man zshcontrib
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' enable git svn cvs

###1 COMPLETION
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path $ZDOTDIR/cache

zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

###2 Completion Styles

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
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' '+l:|=*'

# use LS_COLORS for file coloring
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:' list-colors ${(s.:.)LS_COLORS}

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

# add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

zstyle ':completion:*' completer _complete _prefix _ignored _correct _approximate

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
# zstyle '*' single-ignored show

###1 KEYBINDS
bindkey -v
KEYTIMEOUT=1

# fix for cursor position
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# arrow keys
bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[OB" history-beginning-search-forward-end

# page up and page down
bindkey "[5~" history-beginning-search-backward-end
bindkey "[6~" history-beginning-search-forward-end
bindkey -M vicmd "[5~" history-beginning-search-backward-end
bindkey -M vicmd "[6~" history-beginning-search-forward-end

# filename completion
zle -C complete-files complete-word _generic
zstyle ':completion:complete-files:*' completer _files
bindkey '\t' complete-files

###2 Menu
# # use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey -M menuselect "^M" accept-line # accept completion, don't enter (use .accept-line for enter)
bindkey -M menuselect "^G" accept-line # accept completion, don't enter
bindkey -M menuselect "+" accept-and-menu-complete # accept completion, stay in menu
#bindkey -M menuselect "^[[Z" reverse-menu-complete

bindkey -M menuselect "^P" reverse-menu-complete
bindkey -M menuselect "^N" menu-complete

###2 vi command mode
bindkey ' ' magic-space
bindkey -M vicmd "gg" beginning-of-history
bindkey -M vicmd "G" end-of-history
bindkey -M vicmd "/" history-incremental-search-backward
bindkey -M vicmd "?" history-incremental-search-forward
bindkey -M vicmd "u" undo
bindkey -M vicmd v edit-command-line
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

###2 vi insert
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

###2 search
# allow interactive incr search, ^G or ^C to exit
bindkey -M isearch "^P" history-incremental-search-backward
bindkey -M isearch "^N" history-incremental-search-forward

###1 PLUGINS
# https://github.com/zsh-users/zsh-syntax-highlighting
if [ -e $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif command -v git > /dev/null 2>&1; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZDOTDIR/zsh-syntax-highlighting
fi
# vim: set ft=zsh tw=0 ts=2 sw=2 sts=2 fdm=marker fmr=###,### et:
