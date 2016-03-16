#{{{1 Source Hostname file
source_if_exists () {
  if [ -f $1 ]; then
    source $1
  fi
}

SHORTHOSTNAME=`hostname -s`

source_if_exists ~/.profile.d/hostnames/${SHORTHOSTNAME}.sh
source_if_exists ~/.profile.d/hostnames/${SHORTHOSTNAME}.private.sh

unset HOSTNAME
unset source_if_exists
