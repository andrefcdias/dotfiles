#!/bin/bash

password=""
echo "Please provide your Git commit info"
read -p "Full name: " fullName
read -p "Email: " email
read -p "Key password: " -s password
echo ""

echo "Setting up global Git identity"

git config --global user.name $fullName
git config --global user.email $email

echo "Setting up SSH key"

key_name="github_ed25519"
ssh-keygen -t ed25519 -C $email -f ~/.ssh/$key_name -N $password

# Add to .zshrc (required?)
# TODO: Remove this requirement
# echo "# ssh" >> ~/.zshrc
# echo 'eval "$(ssh-agent -s)"' >> ~/.zshrc
# echo "ssh-add ~/.ssh/$key_name" >> ~/.zshrc
# echo "" >> ~/.zshrc
# echo "> SSH key will be added on ZSH session start. Dont forget to run 'source ~/.zsrhc' after the script finishes."

# Copy .pub and open GitHub
ssh_key=$(cat ~/.ssh/$key_name.pub)
# WSL
echo $ssh_key | clip.exe 2>/dev/null
# Mac
echo $ssh_key | pbcoby 2>/dev/null

echo "SSH key copied. Please paste it to your GitHub account's SSH keys"
# WSL
explorer.exe https://github.com/settings/ssh/new 2>/dev/null
# Mac
open https://github.com/settings/ssh/new 2>/dev/null

read -p "Press any key to resume..." 

echo "Setting up GPG key"

export GPG_TTY=$(tty)

# Generate GPG key
keyComment="Github key for $email"
cat >keyConfig <<EOF
    Key-Type: default
    Key-Length: 4096
    Subkey-Type: default
    Subkey-Length: 4096
    Name-Real: $fullName
    Name-Comment: $keyComment
    Name-Email: $email
    Expire-Date: 0
    Protection: $password
    %commit
EOF
echo "Generating GPG key... (this might take a lot of time)"
gpg --batch --generate-key keyConfig
rm -rf keyConfig

# Get pub key id
keyId=$(gpg --list-secret-keys $keyComment | sed -n 2p | xargs)

# Set signing key on Git
git config --global user.signingkey $keyId
git config --global commit.gpgsign true

# Copy pub key and open GitHub
gpg_key=$(gpg --armor --export $keyId)
# WSL
echo $gpg_key | clip.exe 2>/dev/null
# Mac
echo $gpg_key | pbcoby 2>/dev/null

echo "GPG key copied. Please paste it to your GitHub account's GPG keys."
# WSL
explorer.exe https://github.com/settings/gpg/new 2>/dev/null
# Mac
open https://github.com/settings/gpg/new 2>/dev/null

read -p "Press any key to resume..."

# Create SSH config file
touch ~/.ssh/config
echo "Host *" >> ~/.ssh/config
echo "    IdentityFile ~/.ssh/$key_name" >> ~/.ssh/config

# Add SSH key to agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/$key_name