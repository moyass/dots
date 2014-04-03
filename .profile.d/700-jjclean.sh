clean() {
  cleanies=`ls \#* *~ .*~ *.bak .*.bak *.tmp .*.tmp core a.out .DS_Store *.toc *.aux *.log *.cp *.fn *.tp *.vr *.pg *.ky`;
  echo "Will delete $(echo $cleanies | wc -l | tr -d ' ') files."
  echo -n "Really clean this directory? ";
  read yorn;
  if test "$yorn" = "y"; then
    rm -vf $cleanies;
    echo "Cleaned.";
  else
    echo "Not cleaned.";
  fi
}
