[ -f ${HOME}/.profile ] && . ~/.profile
files=${HOME}/.profile.d/bash/*.bash
for file in ${files}; do
  . ${file}
done
