if [ -f ${HOME}/.profile ]; then
    source ~/.profile
fi

files=${HOME}/.profile.d/bash/*.sh
for file in ${files}; do
  source ${file}
done


