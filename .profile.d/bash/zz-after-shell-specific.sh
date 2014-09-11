files=${HOME}/.profile.d/after-shell-specific/*.sh
for file in ${files}; do
  source ${file}
done


