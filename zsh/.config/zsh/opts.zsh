# =============================================================================
# SHELL OPTIONS & BEHAVIORS
# =============================================================================

# ---- Directory Navigation ----
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt PUSHD_SILENT

# ---- Globbing & Expansion ----
setopt EXTENDED_GLOB
setopt NOMATCH
setopt GLOB_DOTS
setopt NUMERIC_GLOB_SORT

# ---- Job Control ----
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_CHECK_JOBS

# ---- Input/Output ----
setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt RC_QUOTES

# ---- Prompt ----
setopt PROMPT_SUBST
