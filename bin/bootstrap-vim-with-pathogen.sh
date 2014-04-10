#!/usr/bin/env bash


# aptitude install vim-gtk 
# vim-nox is missing clipboard cflag

mkdir -p ~/.vim/autoload ~/.vim/bundle

# get pathogen
# https://github.com/tpope/vim-pathogen
curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim


