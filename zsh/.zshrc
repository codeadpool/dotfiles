# ------------------------------------------------------------------------------
# --- [[ 1. AESTHETICS ]] ---
# ------------------------------------------------------------------------------

# if [ -f "$HOME/.config/dircolors" ]; then
#     eval "$(dircolors "$HOME/.config/dircolors")"
# fi
# [[ -f "$HOME/dotfiles/zsh/vivid-tokyo-night.zsh" ]] && source "$HOME/dotfiles/zsh/vivid-tokyo-night.zsh"
source ~/dotfiles/zsh/.vivid-one-dark.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

if (( $+commands[exa] )); then
    alias ls='exa --icons --git'
    alias l='exa --icons --git -l'
    alias la='exa --icons --git -la'
    alias ltree='exa --icons --git --tree --level=3'
fi


# ------------------------------------------------------------------------------
# --- [[ 2. CYBERPUNK PROMPT ]] ---
# ------------------------------------------------------------------------------

# Allow functions and substitutions in the prompt
setopt PROMPT_SUBST

# Git branch info function
git_prompt_info() {
  local ref
  if ref=$(git symbolic-ref --quiet HEAD 2>/dev/null) || \
     ref=$(git rev-parse --short HEAD 2>/dev/null); then
    echo "${ref#refs/heads/}"
  fi
}

# Git dirty status function (shows ⚡ if not clean)
git_dirty() {
  local gs
  if gs=$(git status --porcelain 2>/dev/null) && [[ -n $gs ]]; then
    echo " %F{red}!!%f"
  fi
}

# Exit code function (shows ✗ if last command failed)
exit_code_prompt() {
  (( $? != 0 )) && echo "%F{red}x %f"
}

# The Prompt
PROMPT='%F{magenta}┌─[%f%F{cyan}%~%f%F{magenta}]%f $(exit_code_prompt)%F{blue}$(git_prompt_info)%f$(git_dirty)
%F{magenta}└─%f %F{green}>%f '

# ------------------------------------------------------------------------------
# --- [[ 3. HISTORY SETTINGS ]] ---
# ------------------------------------------------------------------------------

HISTFILE=~/.zsh_history
HISTSIZE=200000
SAVEHIST=200000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST

fzf-history-widget() {
  local selected cmd
  selected=$(
    fc -l 1 |
      fzf --prompt="History> " \
          --height=50% --border \
          --tiebreak=index \
          --preview 'echo {} | sed "s/^[[:space:]]*[0-9]\+[[:space:]]*//"' \
          --preview-window=up:3:wrap \
          --query="$LBUFFER"
  ) || return

  # Strip the number
  cmd=$(echo "$selected" | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//')

  LBUFFER="$cmd"
  zle reset-prompt
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget


export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# ------------------------------------------------------------------------------
# --- [[ 4. COMPLETION SYSTEM ]] ---
# ------------------------------------------------------------------------------

autoload -Uz compinit
compinit
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select

# ------------------------------------------------------------------------------
# --- [[ 5. ALIASES ]] ---
# ------------------------------------------------------------------------------

# General utilities
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto'
alias mv='mv -i'

# Arch pacman aliases
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias pacsearch='pacman -Ss'
alias pacinfo='pacman -Si'
alias paccc='yes | sudo pacman -Scc'

# ------------------------------------------------------------------------------
# --- [[ 6. SHELL UTILITIES ]] ---
# ------------------------------------------------------------------------------

# Set terminal title to current directory
precmd () { print -Pn "\e]2;%-3~\a"; }

if [[ -x /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
elif [[ -x /usr/lib/command-not-found ]]; then
  function command_not_found_handler {
    /usr/lib/command-not-found -- "$1"
  }
fi

eval "$(zoxide init --cmd cd zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/shadow-monarch/.lmstudio/bin"
# End of LM Studio CLI section

# === Pyenv Configuration ===
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"

# === Global Model Cache ===
export HF_HOME="$HOME/.cache/huggingface"
export TRANSFORMERS_CACHE="$HF_HOME/transformers"

# Created by `pipx` on 2025-11-16 15:40:57
export PATH="$PATH:/home/shadow-monarch/.local/bin"
export PATH="$HOME/git-files/llama.cpp:$PATH"
