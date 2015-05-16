if [ -f ${HOME}/.profile ]; then
    source ~/.profile
fi

files=${HOME}/.profile.d/bash/*.bash
for file in ${files}; do
  source ${file}
done


