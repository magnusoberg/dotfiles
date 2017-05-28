# New machine setup #

## For Mac ##

```
# Install Homebrew
xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#Install everything else needed
brew install tmux
brew install keychain
brew install git
brew install jq
brew install ag
brew install python
brew install httpie
brew install zplug
brew install vim
brew install hub
brew install reattach-to-user-namespace
brew install parallel
brew install watch

# Use newer version of OpenSSL that supports SNI:
#   SNI (Server Name Indication) extension in the ClientHello message.
# may need to put /usr/local/opt/openssl/bin path first in $PATH
brew install --force openssl

brew install weechat

brew tap caskroom/cask
brew cask install iterm2

# Remap UK keyboard tilde and/or Capslock to L_Control
brew cask install karabiner-elements

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
git clone https://github.com/magnusoberg/dotfiles
mkdir .vim/
ln -s ~/dotfiles/.vimrc .vim/vimrc
git clone git@gitlab.com:magobe/private.git


# Edit $home_system in .zshrc to equal $HOST
vim .zshrc
```

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
- Should load settings file from dotfiles.
- Profiles / Keys: set left and right option key to +Esc to allow better navigation at CLI.
- you can also add Command-f and Command-b by clicking '+' and selecting 'Send Escape Sequence' followed by key.

### Setup ssh for GitHub
```
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
```
Once SSH keys are added and configured in GitHub, you can change the protocol
to use SSH keys and the git protocol for your repo instead of HTTPS which will
always require authentication
```
cd dotfiles
git remote set-url origin git@github.com:magnusoberg/dotfiles
```

### Verify SSH fingerprints against GitHub published keys
[Test SSH connection to GitHub](https://help.github.com/articles/testing-your-ssh-connection/)
```
# Test that it works
ssh -T git@github.com
```
You will not be able to login as you are not allowed to assign a TTY by GitHub.
This is why we disable the pseudo-terminal allocation above with the `-T`
option to ssh. You should receive a greeting welcoming you with your username
you if you were successful.

### Enable italics in tmux
As of tmux 2.1, you can enable italics support by setting the default terminal
to `tmux*` instead of the usual `screen*`. See [tmux
changelog](https://github.com/tmux/tmux/blob/2.1/FAQ#L355-L383) for more
details. However, it seems my Mac does not support the `xterm+tmux` or the
`xterm+256setaf` terminfo. I simply replaced those with the below and it works.
```
tmux|tmux terminal multiplexer,
  ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m,
  use=xterm, use=screen,

tmux-256color|tmux with 256 colors,
    use=xterm-256color, use=tmux,
```
I stored the two entries above in `~/terminfo/` and then run the commands below
to compile them into `~/.terminfo`
```
tic -x tmux.terminfo
tic -x tmux-256color.terminfo
```

