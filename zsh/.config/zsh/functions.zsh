# =============================================================================
# CUSTOM FUNCTIONS
# =============================================================================

# ---- Extract Archives ----
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"    ;;
      *.tar.gz)    tar xzf "$1"    ;;
      *.tar.xz)    tar xJf "$1"    ;;
      *.bz2)       bunzip2 "$1"    ;;
      *.rar)       unrar x "$1"    ;;
      *.gz)        gunzip "$1"     ;;
      *.tar)       tar xf "$1"     ;;
      *.tbz2)      tar xjf "$1"    ;;
      *.tgz)       tar xzf "$1"    ;;
      *.zip)       unzip "$1"      ;;
      *.Z)         uncompress "$1" ;;
      *.7z)        7z x "$1"       ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# ---- Make Directory and CD Into It ----
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ---- Backup File ----
backup() {
  cp "$1"{,.bak}
}

# ---- Find Process Using Port ----
port() {
  sudo lsof -i :"$1"
}

# ---- Quick Note Taking ----
note() {
  local note_file="${XDG_DATA_HOME:-$HOME/.local/share}/notes/$(date +%Y-%m-%d).md"
  mkdir -p "$(dirname "$note_file")"
  if [ $# -eq 0 ]; then
    $EDITOR "$note_file"
  else
    echo "$(date +%H:%M:%S) - $*" >> "$note_file"
  fi
}

# ---- Command Not Found Handler ----
if [[ -x /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
elif [[ -x /usr/lib/command-not-found ]]; then
  command_not_found_handler() {
    /usr/lib/command-not-found -- "$1"
  }
fi

# ---- Quick GitHub Clone ----
ghclone() {
  git clone "https://github.com/$1.git"
}

