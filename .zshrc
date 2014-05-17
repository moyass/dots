[[ -f ~/.profile ]] && source ~/.profile

for file ($HOME/.profile.d/zsh/*.zsh); do
  source $file
done




PERL_MB_OPT="--install_base \"/home/hugg/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/hugg/perl5"; export PERL_MM_OPT;
