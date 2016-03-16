[ -f ~/.profile ] && . ~/.profile
for file ($HOME/.profile.d/zsh/*.zsh); do
  . $file
done
hostnamefile="${HOME}/.profile.d/hostnames/`hostname -s`.zsh"
[ -e $hostnamefile ] && . $hostnamefile
unset hostnamefile

