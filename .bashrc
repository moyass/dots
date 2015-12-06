[ -f ${HOME}/.profile ] && . ~/.profile
${HOME}/.profile.d/bash/*.bash
for file in ${files}; do
  . ${file}
done


