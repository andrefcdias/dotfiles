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

alias sc="source $HOME/.zshrc"


## GH CLI

alias gcl="gh codespace list"

### Get Codespace name by displayName
gcg() {
  if [ "$1" = "" ]; then
    echo "\033[0;31mNo displayName passed as an argument.\033[0m" 1>&2
    return 1
  fi

  codespaces=$(gh codespace list)
  codespace_name=$(echo "$codespaces" | awk '{print $1, $2}' | grep $1 | awk '{print $1}')

  echo $codespace_name
}

### Edit Codespace by displayName
gce() {
  codespace_name=$(gcg $1)
  if [ "$codespace_name" = "" ]; then
    echo "\033[0;31mCodespace with display name '$1' not found. Codespaces available:\n\033[0m"
    echo $codespaces
    return
  fi

  echo "Opening codespace $1 ($codespace_name)..."
  gh codespace edit -c $codespace_name -d $2
}

### Open Codespace by displayName
gcc() {
  codespace_name=$(gcg $1)
  if [ "$codespace_name" = "" ]; then
    echo "\033[0;31mCodespace with display name '$1' not found. Codespaces available:\n\033[0m"
    echo $codespaces
    return
  fi
  
  echo "Opening codespace $1 ($codespace_name)..."
  gh codespace code -c "$codespace_name"
}

### Delete Codespace by displayName
gcr() {
  codespace_name=$(gcg $1)
  if [ "$codespace_name" = "" ]; then
    echo "\033[0;31mCodespace with display name '$1' not found. Codespaces available:\n\033[0m"
    echo $codespaces
    return
  fi

  echo "Opening codespace $1 ($codespace_name)..."
  gh codespace delete -c $codespace_name
}


## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
