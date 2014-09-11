
#  Hostname file loader.
# ============================

# WARN: Echoing feedback causes ssh cloud apps to fail. Sad.

source_if_exists {
  if [ -f $1 ]; then
    source $1
  fi

}

THEHOSTNAME=`hostname`
THESHORTHOSTNAME=`hostname -s`

# Sometimes `hostname` is fqdn, sometimes not. 
# This is anonying.
# So just check for both.

if [ $THEHOSTNAME != $THESHORTHOSTNAME   ]; then
  source_if_exists ~/.profile.d/hostnames/${THESHORTHOSTNAME}.sh
  source_if_exists ~/.profile.d/hostnames/${THESHORTHOSTNAME}.private.sh
fi

source_if_exists ~/.profile.d/hostnames/${THEHOSTNAME}.sh
source_if_exists ~/.profile.d/hostnames/${THEHOSTNAME}.private.sh

