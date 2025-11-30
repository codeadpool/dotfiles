# =============================================================================
# FZF CONFIGURATION
# =============================================================================

if ! (( $+commands[fzf] )); then
  return
fi

# ---- FZF Options ----
export FZF_DEFAULT_OPTS="
  --height=50%
  --border=rounded
  --margin=1
  --padding=1
  --prompt='❯ '
  --pointer='▶'
  --marker='✓'
  --color=fg:#c8d3f5,bg:#222436,hl:#ff966c
  --color=fg+:#c8d3f5,bg+:#2f334d,hl+:#ff966c
  --color=info:#82aaff,prompt:#86e1fc,pointer:#86e1fc
  --color=marker:#c3e88d,spinner:#c3e88d,header:#c3e88d
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-u:preview-half-page-up'
  --bind='ctrl-d:preview-half-page-down'
"

# Use fd if available
if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# ---- FZF History Widget ----
fzf-history-widget() {
  local selected cmd
  selected=$(
    fc -l 1 |
      fzf --prompt="History ❯ " \
          --height=50% \
          --border=rounded \
          --tiebreak=index \
          --preview 'echo {} | sed "s/^[[:space:]]*[0-9]\+[[:space:]]*//"' \
          --preview-window=up:3:wrap \
          --query="$LBUFFER"
  ) || return

  cmd=$(echo "$selected" | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//')
  LBUFFER="$cmd"
  zle reset-prompt
}
zle -N fzf-history-widget

# ---- FZF File Widget ----
fzf-file-widget() {
  local selected
  selected=$(
    fzf --prompt="Files ❯ " \
        --preview='bat --color=always --style=numbers --line-range=:500 {}' \
        --preview-window='right:60%:wrap'
  ) || return

  LBUFFER="${LBUFFER}${selected}"
  zle reset-prompt
}
zle -N fzf-file-widget

# ---- FZF Directory Widget ----
fzf-cd-widget() {
  local selected
  selected=$(
    fd --type d --hidden --follow --exclude .git |
      fzf --prompt="Directories ❯ " \
          --preview='exa --tree --level=2 --icons {}' \
          --preview-window='right:60%:wrap'
  ) || return

  cd "$selected"
  zle reset-prompt
}
zle -N fzf-cd-widget

# ---- FZF Git Branch Widget ----
fzf-git-branch() {
  local branches branch
  branches=$(git branch -a | grep -v HEAD) || return
  branch=$(echo "$branches" | fzf --prompt="Branch ❯ " | sed "s/.* //") || return
  git checkout "$branch"
  zle reset-prompt
}
zle -N fzf-git-branch

# ---- FZF Kill Process ----
fzf-kill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf --prompt="Kill ❯ " -m | awk '{print $2}') || return
  if [[ -n $pid ]]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
  zle reset-prompt
}
zle -N fzf-kill

# ---- FZF Pacman Package Search ----
fzf-pacman() {
  pacman -Slq | fzf --prompt="Packages ❯ " \
    --multi \
    --preview 'pacman -Si {1}' \
    --preview-window=right:60%:wrap |
    xargs -ro sudo pacman -S
}

# ---- FZF Environment Variables ----
fzf-env() {
  env | fzf --prompt="Env ❯ " --preview 'echo {}' --preview-window=up:3:wrap
}
