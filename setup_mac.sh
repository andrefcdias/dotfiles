
./setup_fonts.sh

brew install --cask maccy iterm2 visual-studio-code rectangle

# From https://macos-defaults.com/
# Remove recent apps from dock
defaults write com.apple.dock "show-recents" -bool false # && killall Dock

# Disable natural scrolling for mouse
defaults write -g com.apple.swipescrolldirection -bool false

# Remove scroll inertia
# defaults write .GlobalPreferences com.apple.scrollwheel.scaling -1 # Is this working?

# Disable smooth scrolling
defaults write -g NSScrollAnimationEnabled -bool false

# Copy iterm2 profiles and set default
cp ./profiles/iterm2.json "~/Library/Application Support/iTerm2/DynamicProfiles/profiles.json"
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "00000000-0000-0000-0000-000000000001"

# Copy Rectange profile
cp ./profiles/rectangle.json "~/Library/Application Support/Rectangle/RectangleConfig.json"