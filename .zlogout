# .zlogout: executed by zsh on login shell exit
# clear the console 
[ "$SHLVL" = 1 ] && [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
