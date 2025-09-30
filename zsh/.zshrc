PS1='%F{blue}%B%~%b%f %F{green}❯%f '

# History: Large, shared, no dups
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

autoload -Uz compinit
compinit
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select

# Aliases:
alias ls='ls --color=auto -hv'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c=auto'
alias l='ls'
alias ll='ls -l'
alias la='ls -lA'
alias mv='mv -i'  # Prompt on overwrite

# Arch pacman aliases
alias pacup='sudo pacman -Syu'        # Update system
alias pacin='sudo pacman -S'          # Install package
alias pacrm='sudo pacman -Rns'        # Remove with deps
alias pacsearch='pacman -Ss'          # Search packages
alias pacinfo='pacman -Si'            # Package info

# Terminal title: Show shortened current dir
precmd () { print -Pn "\e]2;%-3~\a"; }

# Optional: Command not found handler for Arch (suggests packages)
if [[ -x /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
elif [[ -x /usr/lib/command-not-found ]]; then
  function command_not_found_handler {
    /usr/lib/command-not-found -- "$1"
  }
fi
eval "$(zoxide init --cmd cd zsh)"
