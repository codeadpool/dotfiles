# =============================================================================
# KEY BINDINGS
# =============================================================================

bindkey -e

# ---- FZF Bindings ----
bindkey '^R' fzf-history-widget      # Ctrl+R: History search
bindkey '^T' fzf-file-widget         # Ctrl+T: File search
bindkey '^F' fzf-cd-widget           # Ctrl+F: Directory search
bindkey '^G' fzf-git-branch          # Ctrl+G: Git branch
bindkey '^K' fzf-kill                # Ctrl+K: Kill process

# ---- Edit Command Line ----
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line     # Ctrl+X Ctrl+E: Edit in $EDITOR

# ---- Navigation ----
bindkey '^[[A' history-substring-search-up      # Up arrow
bindkey '^[[B' history-substring-search-down    # Down arrow
bindkey '^[[H' beginning-of-line                # Home
bindkey '^[[F' end-of-line                      # End
bindkey '^[[3~' delete-char                     # Delete

# ---- Word Movement (Alt+Left/Right) ----
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

# ---- Clear Screen ----
bindkey '^L' clear-screen
