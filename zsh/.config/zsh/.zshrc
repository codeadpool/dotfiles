# Performance profiling (uncomment to debug slow startup)
# zmodload zsh/zprof

# Source configuration modules in order
ZSH_CONFIG_DIR="${ZDOTDIR:-$HOME/.config/zsh}"

# Core configurations
source "$ZSH_CONFIG_DIR/opts.zsh"
source "$ZSH_CONFIG_DIR/history.zsh"
source "$ZSH_CONFIG_DIR/completion.zsh"
source "$ZSH_CONFIG_DIR/plugins.zsh"

# UI and interaction
source "$ZSH_CONFIG_DIR/prompt.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"
source "$ZSH_CONFIG_DIR/fzf.zsh"
source "$ZSH_CONFIG_DIR/keybinds.zsh"

# Performance profiling (uncomment to debug)
# zprof
