
[[ -f ~/.profile ]] && source ~/.profile

for file ($HOME/.profile.d/zsh/*.sh); do
  source $file
done



