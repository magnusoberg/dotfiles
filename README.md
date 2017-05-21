# New machine setup #

## For Mac ##

~~~
# Install Homebrew
xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask

#Install everything else needed
brew install tmux keychain git jq ag python httpie
brew install zplug
brew install reattach-to-user-namespace
brew cask install iterm2

#Install python related items
pip install ansible
pip install http-prompt

# Get fonts and colorschemes
cd ~/Downloads
git clone https://github.com/powerline/fonts.git
git clone https://github.com/mbadolato/iTerm2-Color-Schemes

cd fonts
./install.sh
cd ..
rm -rf fonts/

# Setup personal environemt
cd ~

# Edit $home_systme in .zshrc to equal $HOST
vim .zshrc

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

### Setup ssh for GitHub
~~~
# Create a new private/public key and store the password somewhere safe
cd ~
mkdir -p .ssh
cd ~/.ssh
ssh-keygen -t rsa -b 4096

# Add key to ssh-agent unless you logout and let keychain take care of it for you
ssh-add

# Setup git
git config --global user.email "your.name@example.org"   # Should match one of your emails added in GitHub
git config --global user.name  "Your Name"

# Copy SSH key and paste it into GitHub
pbcopy < ~/.ssh/id_rsa.pub
~~~

### Verify SSH fingerprints against GitHub published keys
[Test SSH connection to GitHub](https://help.github.com/articles/testing-your-ssh-connection/)
~~~
# Test that it works
ssh -T git@github.com
~~~
You will not be able to login as you are not allowed to assign a TTY by GitHub. This is why we disable the
pseudo-terminal allocation above with the `-T` option to ssh. You should receive a greeting welcoming you with your
username welcoming you if you were successful.
