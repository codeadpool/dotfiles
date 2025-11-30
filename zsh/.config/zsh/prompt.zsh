# =============================================================================
# PROMPT CONFIGURATION
# =============================================================================

setopt PROMPT_SUBST

# ---- Git Information ----
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
    echo " %F{red}!!%f"
  fi
}

# ---- Exit Code ----
exit_code_prompt() {
  (( $? != 0 )) && echo "%F{red}x %f"
}

# ---- Execution Time (for long-running commands) ----
preexec() {
  timer=$(($(date +%s%N)/1000000))
}

precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%N)/1000000))
    elapsed=$(($now-$timer))
    if (( elapsed > 1000 )); then
      export RPROMPT="%F{yellow}${elapsed}ms%f"
    else
      export RPROMPT=""
    fi
    unset timer
  fi
  # Set terminal title to current directory
  print -Pn "\e]2;%~\a"
}

# ---- Main Prompt ----
PROMPT='%F{magenta}┌─[%f%F{cyan}%~%f%F{magenta}]%f $(exit_code_prompt)%F{blue}$(git_prompt_info)%f$(git_dirty)
%F{magenta}└─%f %F{magenta}❯%f '

# ---- Right Prompt (shows execution time) ----
# RPROMPT is set dynamically in precmd
