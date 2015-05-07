[[ -f ~/.profile ]] && source ~/.profile

for file ($HOME/.profile.d/zsh/*.zsh); do
  source $file
done

