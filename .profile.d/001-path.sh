# A function to protect you from yourself.
# ========================================
adjunct_path_with () {
  adjunctor="$1"    # the directory  ## WARN: DO NOT USE TRAILING SLASH OR THE WORLD ENDS!
  override="$2"    # if $2 is true: $1 is prefixed to PATH; else $1 is appended to PATH

  if [[ -d "$adjunctor" ]]; then
    if [[ "$override" != false ]]; then
      PATH="$1:$PATH"
    else
      PATH="$PATH:$1"
    fi
  fi
}


# OSX.
# ===================
if [[ "$IS_OSX" = true ]]; then
  # Add localbins  to path, esp for homebrew
  adjunct_path_with "/usr/local/bin" true
  adjunct_path_with "/usr/local/sbin" true

fi

# sbins.
# ===================
adjunct_path_with "/sbin" true
adjunct_path_with "/usr/sbin" true

# Npm!
# ===================
adjunct_path_with "${HOME}/.npm/bin" true

# User's bin.
# ===================
adjunct_path_with "${HOME}/bin"  true

# Cleanup.
# ===================
unset -f adjunct_path_with
export PATH
