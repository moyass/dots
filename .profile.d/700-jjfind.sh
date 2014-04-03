## For finding stuff in a directory.
jjfind () {
   if [ $# -lt 2 ]; then
      files="*";
      search="${1}";
   else
      files="${1}";
      search="${2}";
   fi;
   find . -name "$files" -a ! -wholename '*/.*' -exec grep -Hin ${3} "$search" {} \; ;
}
