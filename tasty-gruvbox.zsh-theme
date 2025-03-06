# Put your custom themes in this folder.
# See: https://github.com/ohmyzsh/ohmyzsh/wiki/Customization#overriding-and-adding-themes

# Uncomment for development
#. ~/.oh-my-zsh/lib/git.zsh > /dev/null

# Colors
# Based on: https://github.com/morhetz/gruvbox
COL_FG1="#a89984"
COL_FG2="#ebdbb2"
COL_FG3="#bdae93"
COL_BG1="#3c3836"
COL_BG2="#2b2829"
COL_GREEN1="#98971a"
COL_GREEN2="#b8bb26"
COL_YELLOW1="#d79921"
COL_YELLOW2="#fabd2f"
COL_BLUE1="#458588"
COL_BLUE2="#83a598"
COL_PURPLE1="#b16286"
COL_PURPLE2="#d3869b"
COL_AQUA1="#689d6a"
COL_AQUA2="#8ec97c"
COL_ORANGE1="#d65d0e"
COL_ORANGE2="#fe8019"

# ICONS
SEGMENT_SEPARATOR="\ue0b0"

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts
CURRENT_BG="NONE"

case ${SOLARIZED_THEME:-dark} in
    light)
      CURRENT_FG="white"
      CURRENT_DEFAULT_FG="white"
      ;;
    *)
      CURRENT_FG="black"
      CURRENT_DEFAULT_FG="default"
      ;;
esac

# Begin a segment
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ "$CURRENT_BG" != "NONE" && $1 != "$CURRENT_BG" ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n "$3"
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=""
}

prompt_icon() {
  OS_LOGO="\ue712" # 
  echo -n "%{$OS_LOGO%}"
}

prompt_user() {
  echo -n "%n"
}

prompt_machine() {
  echo -n "%m"
}

prompt_context() {
  prompt_segment $COL_FG3 $COL_BG1 "%B"
  prompt_icon
  echo -n "%b"
}

prompt_location() {
  prompt_segment $COL_BG1 $COL_FG2
  echo -n "%~"
}

prompt_git() {
  (( $+commands[git] )) || return
  BRANCH_ICON="\ue0a0" # 

  if [[ "$(command git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]]; then
    DIRTY=$(parse_git_dirty)
    if [[ -n "$DIRTY" ]]; then
      prompt_segment "$COL_YELLOW2" "$COL_BG1"
    else
      prompt_segment "$COL_AQUA2" "$COL_BG1"
    fi

    local ahead behind
    ahead=$(command git log --oneline @{upstream}.. 2> /dev/null)
    behind=$(command git log --oneline @{upstream}.. 2> /dev/null)
    if [[ -n "$ahead" ]] && [[ -n "$behind" ]]; then
      BRANCH_ICON="\u21c5"
    elif [[ -n "$ahead" ]]; then
      BRANCH_ICON="\u21b1"
    elif [[ -n "$behind" ]]; then
      BRANCH_ICON="\u21b0"
    fi

    REPO_PATH=$(command git rev-parse --git-dir 2> /dev/null)
    if [[ -e "${REPO_PATH}/BISECT_LOG" ]]; then
      MODE=" <B>"
    elif [[ -e "${REPO_PATH}/MERGE_HEAD" ]]; then
      MODE=" >M<"
    elif [[ \
      -e "${REPO_PATH}/rebase" || \
      -e "${REPO_PATH}/rebase-apply" || \
      -e "${REPO_PATH}/../.dotest" \
    ]]; then
      MODe=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info
    zstyle ":vcs_info:*" enable git
    zstyle ":vcs_info:*" get-revision true
    zstyle ":vcs_info:*" check-for-changes true
    zstyle ":vcs_info:*" stagedstr "+"
    zstyle ":vcs_info:*" unstagedstr "±"
    zstyle ":vcs_info:*" formats "%b%u%c"
    vcs_info
    echo -n "%B${BRANCH_ICON} ${vcs_info_msg_0_}${MODE}%b"
  fi
}

build_prompt() {
  prompt_context
  prompt_location
  prompt_git
  prompt_end
}

PROMPT='$(build_prompt) '
