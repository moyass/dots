
#  Hostname file loader.
# ============================

# WARN: Echoing feedback causes ssh cloud apps to fail. Sad.

if [ -f ~/.profile.d/hostnames/`hostname`.sh ]; then
   source ~/.profile.d/hostnames/`hostname`.sh
fi

if [ -f ~/.profile.d/hostnames/`hostname`.private.sh ]; then
   source ~/.profile.d/hostnames/`hostname`.private.sh
fi
