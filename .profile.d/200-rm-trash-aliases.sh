if [[ "$OSTYPE" =~ linux* && $(which trash) =~ /trash/ ]]; then
  alias trash = "trash-put" 
fi
