
./setup_fonts.sh

sudo xcode-select --install

brew install gh
echo "Your GitHub emails:"
gh auth login -s user -s codespace
gh api --method GET /user/emails --jq ".[].email"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install zsh
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zshrc

./install.sh

brew install --cask maccy
open -a Maccy

brew install --cask rectangle
# Copy Rectange profile
RECT_PATH="$HOME/Library/Application Support/Rectangle"
mkdir -p $RECT_PATH
cp ./configs/rectangle.json "$RECT_PATH/RectangleConfig.json"
open -a Rectangle

brew install --cask iterm2
# Copy iterm2 profiles and set default
ITERM_PATH="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
mkdir -p $ITERM_PATH
cp ./configs/iterm2.json "$ITERM_PATH/profiles.json"
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "00000000-0000-0000-0000-000000000001"

# A11y queens
brew install --cask keycastr colour-contrast-analyser pika

brew install --cask postman

# Mac customization configs (https://macos-defaults.com/)
## Remove recent apps from dock
defaults write com.apple.dock "show-recents" -bool false

## Disable natural scrolling for mouse
defaults write -g com.apple.swipescrolldirection -bool false

## Remove scroll inertia
### defaults write .GlobalPreferences com.apple.scrollwheel.scaling -1 # Is this working?

## Disable smooth scrolling
defaults write -g NSScrollAnimationEnabled -bool false

## Restart dock
killall Dock