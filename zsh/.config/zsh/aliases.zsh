# =============================================================================
# ALIASES
# =============================================================================

if (( $+commands[exa] )); then
    alias ls='exa --icons --git'
    alias l='exa --icons --git -l'
    alias la='exa --icons --git -la'
    alias ll='exa --icons --git -lah'
    alias ltree='exa --icons --git --tree --level=3'
    alias tree='exa --icons --git --tree'
elif (( $+commands[eza] )); then
    alias ls='eza --icons --git'
    alias l='eza --icons --git -l'
    alias la='eza --icons --git -la'
    alias ll='eza --icons --git -lah'
    alias ltree='eza --icons --git --tree --level=3'
    alias tree='eza --icons --git --tree'
fi

if (( $+commands[bat] )); then
    alias cat='bat --paging=never'
    alias catt='bat --paging=always'
fi

if (( $+commands[rg] )); then
    alias grep='rg'
fi

# ---- Core Utilities ----
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# ---- Quick Navigation ----
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ---- Arch Linux Package Management ----
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias pacsearch='pacman -Ss'
alias pacinfo='pacman -Si'
alias pacorphan='sudo pacman -Rns $(pacman -Qtdq)'

# ---- Tmux ----
alias t='tmux'
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux ls'
alias tk='tmux kill-session -t'
alias tka='tmux kill-server'

# ---- Docker ----
alias dc='docker-compose'
alias dcp='docker-compose ps'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcl='docker-compose logs'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'

# ---- Git Shortcuts ----
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate'

# ---- Configuration Editing ----
alias zedit='$EDITOR ~/dotfiles/zsh/.config/zsh/.zshrc && source ~/dotfiles/zsh/.config/zsh/.zshrc'
alias viedit='$EDITOR ~/dotfiles/nvim/.config/nvim/init.lua'
alias zreload='source ~/dotfiles/zsh/.config/zsh/.zshrc'

# ---- System Information ----
alias sysinfo='inxi -Fxz'
alias ports='netstat -tulanp'
alias myip='curl -s https://ipinfo.io/ip'

# ---- Quick Helpers ----
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowdate='date +"%Y-%m-%d"'
