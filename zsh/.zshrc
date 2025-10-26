setopt PROMPT_SUBST
git_prompt_info() {
  local ref
  if ref=$(git symbolic-ref --quiet HEAD 2>/dev/null) || \
     ref=$(git rev-parse --short HEAD 2>/dev/null); then
    echo "${ref#refs/heads/}"
  fi
}

git_dirty() {
  local gs
  if gs=$(git status --porcelain 2>/dev/null) && [[ -n $gs ]]; then
    echo " %F{red}⚡%f"
  fi
}

# Show red ✗ only if last command failed
exit_code_prompt() {
  (( $? != 0 )) && echo "%F{red}✗ %f"
}

PROMPT='%F{magenta}┌─[%f%F{cyan}%~%f%F{magenta}]%f $(exit_code_prompt)%F{blue}$(git_prompt_info)%f$(git_dirty)
%F{magenta}└─%f %F{green}>%f '

# PS1=$'%F{magenta}┌─[%F{cyan}%~%f]─[%F{yellow}%T%f]$(git_branch)\n%F{magenta}└─%F{green}➤ %f'
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
alias mv='mv -i'

# Arch pacman aliases
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrm='sudo pacman -Rns'
alias pacsearch='pacman -Ss'
alias pacinfo='pacman -Si'
alias paccc='yes | sudo pacman -Scc'

precmd () { print -Pn "\e]2;%-3~\a"; }

if [[ -x /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
elif [[ -x /usr/lib/command-not-found ]]; then
  function command_not_found_handler {
    /usr/lib/command-not-found -- "$1"
  }
fi
eval "$(zoxide init --cmd cd zsh)"
