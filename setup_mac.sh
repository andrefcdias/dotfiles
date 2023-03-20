
./setup_fonts.sh

sudo xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install zsh
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zshrc

./install.sh

brew install gh
gh auth login -s user

brew install --cask maccy rectangle
open -a Rectangle
open -a Maccy

brew install --cask iterm2 visual-studio-code keycastr

brew install n
n install latest

# From https://macos-defaults.com/
# Remove recent apps from dock
defaults write com.apple.dock "show-recents" -bool false

# Disable natural scrolling for mouse
defaults write -g com.apple.swipescrolldirection -bool false

# Remove scroll inertia
# defaults write .GlobalPreferences com.apple.scrollwheel.scaling -1 # Is this working?

# Disable smooth scrolling
defaults write -g NSScrollAnimationEnabled -bool false

# Restart dock
killall Dock

# Copy iterm2 profiles and set default
mkdir -p "~/Library/Application Support/iTerm2/DynamicProfiles"
cp ./configs/iterm2.json "~/Library/Application Support/iTerm2/DynamicProfiles/profiles.json"
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "00000000-0000-0000-0000-000000000001"

# Copy Rectange profile
mkdir -p "~/Library/Application Support/Rectangle"
cp ./configs/rectangle.json "~/Library/Application Support/Rectangle/RectangleConfig.json"