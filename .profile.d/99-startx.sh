#{{{1 Non-interactive shells
[[ ! $- =~ i ]] && return
#{{{1 Start X
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]] && $(which xinit &>/dev/null); then
  exec xinit -- vt1
  logout
fi #}}}
