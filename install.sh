#!/bin/bash
exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

echo "Start install dotfiles as $USERNAME"
CURR_DIR=$(pwd)

echo "Download zsh plugins"
# install zsh plugins
git clone --depth=1 https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k ${ZSH_CUSTOM:-~/.oh-my-zsh}/themes/powerlevel10k

cp -f $CURR_DIR/.zshrc $HOME/.zshrc
cp -f $CURR_DIR/.p10k.zsh $HOME/.p10k.zsh

sudo chsh -s /bin/zsh
