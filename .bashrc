[ -f ${HOME}/.profile ] && . ~/.profile
files="${HOME}/.profile.d/bash/*.bash"
for file in ${files}; do
  . ${file}
done
hostnamefile="${HOME}/.profile.d/hostnames/`hostname -s`.bash"
[ -e $hostnamefile ] && . $hostnamefile
unset files
unset hostnamefile
