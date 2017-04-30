# New machine setup #

## For Mac ##

~~~
# Install Homebrew
xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask

#Install everything
brew install tmux keychain
brew cask install iterm2

# Get fonts and colorschemes
cd ~/Downloads
git clone https://github.com/powerline/fonts.git
git clone https://github.com/mbadolato/iTerm2-Color-Schemes
cd fonts
./install.sh
cd ..
rm -rf fonts/

# Edit $home_systme in .zshrc to equal $HOST
vim .zshrc

#
~~~

### Configure iTerm2
- start iTerm2
- create new profile
- make new profile the default and drag it first in the order to avoid accidentally changing the default in future.
- close Preferences, and open the new default profile section by pressing Command-I.
- import one or more color schemes from the Download/iTerm2-Color-Schemes/schemes folder by selecting them from Profiles/Colors/Color presets.
- Once imported, select them from the same dropdown list.
- I chose 'Afterglow'
- Also in the Profile section, select a new Powerline font.
- I chose 12pt Meslo LG M Regular

### Setup ssh
~~~
# Create a new private/public key
cd ~
mkdir -p .ssh
cd ~/.ssh
ssh-keygen -t rsa -b 4096
# Remember to store the password somewhere safe like LastPass
# Add key to ssh-agent
ssh-add

# Setup git
git config --global user.email magnus2.oberg@gmail.com
git config --global user.name "Magnus Oberg"

# Login to GitHub account and select settings/SSH keys
# Add new SSH key
pbcopy < ~/.ssh/id_rsa.pub
# Paste key into new SSH key setup in GitHub
# Test that it works
ssh -T git@github.com

# Verify that it matches 
~~~
[Test SSH connection to GitHub](https://help.github.com/articles/testing-your-ssh-connection/)
