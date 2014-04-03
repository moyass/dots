#!/usr/bin/env zsh

#  pure prompt for zsh
# ============================
# https://github.com/sindresorhus/pure

PURE_CMD_MAX_EXEC_TIME=10

#fpath=("$HOME/.profile.d/zsh/zprezto" $fpath)
fpath=("$HOME/.profile.d/zsh/zprezto" $fpath)
#prompt pure

 zstyle ':prezto:module:prompt' theme 'pure'

