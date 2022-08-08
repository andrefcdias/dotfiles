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

# Delete local and remote branch
gdb() {
    git branch -d $1
    git push origin --delete $1
}

# Add all and ammend last commit
alias gfix="git add --all && git commit --amend --no-edit"

alias gl="git log"
alias ga="git add ."
alias gc="git cz"

alias sc="source $HOME/.zshrc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
