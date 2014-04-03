#!/bin/bash

# Bash OSTYPE detection.
# ===================
# inspired by http://f00bar.com/blog/2011/07/09/simple-robust-os-detection-in-bash-using-ostype/

case "$OSTYPE" in
solaris*) export IS_SOLARIS=true ;;
darwin*) export IS_OSX=true ;;
linux*) export IS_LINX=true ;;
bsd*) export IS_BSD=true ;;
#*) export WTF_KERNEL_ARE_YOU_RUNNING=true ;;
esac
