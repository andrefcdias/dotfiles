# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TZ="Europe/Prague"
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    zsh-z
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Amiralp - theme overrides
# if [[ -z $ZSH_THEME_CLOUD_PREFIX ]]; then
#     ZSH_THEME_CLOUD_PREFIX="✿"
# fi
# CURRENT_USER_="%{$FG[171]%}%n%{$reset_color%}"
# PROMPT='%{$fg[yellow]%}[%D{%H:%M:%S}] %{$FG[220]%}☆｡･:*:･ﾟ⭑ $CURRENT_USER_ %{$FG[069]%}$ZSH_THEME_CLOUD_PREFIX %{$FG[217]%}%c %{$FG[147]%}$(git_prompt_info)%{$FG[147]%}%{$FG[220]%}⭑ %{$reset_color%} '
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[076]%}[%{$FG[159]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[076]%}] %{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[076]%}] "
#

# Aliases

## Git

### Delete local and remote branch
gdb() {
    git branch -d $1
    git push origin --delete $1
}

### Add all and ammend last commit
alias gfix="git add --all && git commit --amend --no-edit"

alias gl="git log"
alias ga="git add ."
alias gum="git checkout master && git pull && git checkout -"
alias gummy="gum && git merge master"
### Get TODOs you authored - https://twitter.com/almonk/status/1576294814831718400
alias todo='git grep -l TODO | xargs -n1 git blame -f -n -w | grep "$(git config user.name)" | grep TODO | sed "s/.\{9\}//" | sed "s/(.*)[[:space:]]*//"'

alias sc="source $HOME/.zshrc"


## GH CLI

alias cl='gh cs list'

### Watch for codespace changes
clw() {
  timeout=5

  if [ "$1" != "" ]; then
    timeout=$1
  fi

  while :
  do
    echo "⏳"
    output=$(gh cs list)
    clear
    echo $output
    sleep $timeout
  done
}

### Get Codespace name by displayName
cg() {
  if [ "$1" = "" ]; then
    echo "\033[0;31mNo displayName passed as an argument.\033[0m" 1>&2
    return 1
  fi

  codespaces=$(gh codespace list)
  codespace_name=$(echo "$codespaces" | awk '{print $1, $2}' | grep $1 | awk '{print $1}')

  echo $codespace_name
}

### Edit Codespace by displayName
ce() {
  codespace_name=$(cg $1)
  if [ "$codespace_name" = "" ]; then
    echo "\033[0;31mCodespace with display name '$1' not found. Codespaces available:\n\033[0m"
    cl
    return
  fi

  echo "Opening codespace $1 ($codespace_name)..."
  gh codespace edit -c $codespace_name -d $2
}

### Stop Codespace by displayName
cs() {
  codespace_name=$(cg $1)
  if [ "$codespace_name" = "" ]; then
    echo "\033[0;31mCodespace with display name '$1' not found. Codespaces available:\n\033[0m"
    cl
    return
  fi

  echo "Opening codespace $1 ($codespace_name)..."
  gh codespace stop -c $codespace_name
}

### Open Codespace by displayName
cc() {
  codespace_name=$(cg $1)
  if [ "$codespace_name" = "" ]; then
    echo "\033[0;31mCodespace with display name '$1' not found. Codespaces available:\n\033[0m"
    cl
    return
  fi
  
  echo "Opening codespace $1 ($codespace_name)..."
  gh codespace code -c "$codespace_name"
}

### Delete Codespace by displayName
cr() {
  codespace_name=$(cg $1)
  if [ "$codespace_name" = "" ]; then
    echo "\033[0;31mCodespace with display name '$1' not found. Codespaces available:\n\033[0m"
    cl
    return
  fi

  echo "Deleting codespace $1 ($codespace_name)..."
  gh codespace delete -c $codespace_name
}


## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
