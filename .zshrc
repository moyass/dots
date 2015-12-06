[ -f ~/.profile ] && . ~/.profile
for file ($HOME/.profile.d/zsh/*.zsh); do
  . $file
done

