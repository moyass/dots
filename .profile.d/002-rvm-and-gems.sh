#  Load RVM into a shell session, but only if running interactively.
# ============================
# https://github.com/icco/dotFiles/blob/ec264f5c311a3d0bfbd861c2d648b04d3d89c126/link/bashrc
if [ -z "$PS1" ]; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
  return
fi

#  Pull user gems into path.
# ============================
# http://guides.rubygems.org/faqs/#user-install
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
