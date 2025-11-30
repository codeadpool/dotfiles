# =============================================================================
# PLUGIN MANAGEMENT
# =============================================================================

# ---- Color Schemes ----
if [[ -f "$ZDOTDIR/.vivid-one-dark.zsh" ]]; then
    source "$ZDOTDIR/.vivid-one-dark.zsh"
fi

# ---- Zsh Autosuggestions ----
if [[ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

if [[ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if (( $+commands[zoxide] )); then
    eval "$(zoxide init --cmd cd zsh)"
fi

if [[ -d "$HOME/.pyenv" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# ---- Additional Path Mods. ----
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/git-files/llama.cpp:$PATH"
export PATH="$PATH:$HOME/.lmstudio/bin"

# ---- Model Cache ----
export HF_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/huggingface"
export TRANSFORMERS_CACHE="$HF_HOME/transformers"
