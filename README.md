# New machine setup #

## For Mac ##

```zsh
# Install Homebrew
xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install everything else needed
brew install tmux

# funtoo keychain for ssh agent
brew install keychain

brew install git

# Git + Hub = GitHub cli!
# Don't forget to check if hub is properly aliased in .zshrc
brew install hub

# Awesome json query tool
brew install jq

# json incremental digger.. nice, but jiq below is even nicer!
brew install jid

# jiq uses jq syntax in filter
go get github.com/fiatjaf/jiq/cmd/jiq

# pup is similar to jq, but for HTML intead of JSON
brew install pup

brew install htop
brew install tig
brew install fasd

# Don't use the built-in zsh - get the latest and greatest!
brew install zsh zsh-completions

# ncurses based directory usage tool
brew install ncdu

# Install faster search tools than grep and Ack
brew install ag            # Silver searcher   - better than Ack
brew install pt            # platinum searcher - better than ag
brew install rg            # ripgrep           - better than pt

brew install python
brew install httpie
brew install zplug
brew install vim

# Not sure if this is needed anymore
#brew install reattach-to-user-namespace
brew install parallel
brew install watch
brew install lastpass-cli
brew install shuf
brew install unrar
brew install pv            # process viewer
brew install node          # Node.js
brew install nmap
brew install weechat

# Doesn't work well on Mac..
# brew install mtr
# brew install apg         # doesn't seem to exist anymore

# Install GNU utilities ('g' prefixed for Mac)
brew install grep
brew install gnu-sed
brew install gawk
brew install ossp-uuid autoconf automake pkg-config coreutils bash
brew install tree

brew install kubernetes-cli
#brew install vault
brew install cowsay
brew install mongodb
brew install osquery
#brew install pwgen

# xsv is a powerful CSV file viewer (and much more). Pipe to 'xsv table' for basic usage.
brew install xsv

# Install some nice Node.js npm packages
npm install -g gtop        # text-based system monitor
npm install -g html-cli    # format HTML text
npm install -g uglify-js   # beautify JavaScript (good for minified content)

# Install Go and then use it to install json2csv (after setting path)
brew install go
#export PATH=$PATH:~/go/bin
#path=($path ~/go/bin)
go get github.com/jehiah/json2csv
rehash

# Use newer version of OpenSSL that supports SNI:
#   SNI (Server Name Indication) extension in the ClientHello message.
# may need to put /usr/local/opt/openssl/bin path first in $PATH
brew install --force openssl

brew tap caskroom/cask
brew cask install iterm2
brew cask install telegram
brew cask install docker
brew cask install visual-studio-code
brew cask install slack
brew cask install gdrive
brew cask install 1password

# Needed this after a while since, brew stopped working without it.
brew cask install xcrun
brew cask install java

# Remap UK keyboard tilde and/or Capslock to L_Control
brew cask install karabiner-elements

#Install python related items
pip install virtualenv
pip install csvkit
pip install ansible
pip install http-prompt
pip install --user --upgrade awscli

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

### Configure iTerm2 ###

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

### Setup ssh for GitHub ###

```zsh
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

```zsh
cd dotfiles
git remote set-url origin git@github.com:magnusoberg/dotfiles
```

### Verify SSH fingerprints against GitHub published keys ###

[Test SSH connection to GitHub](https://help.github.com/articles/testing-your-ssh-connection/)

```zsh
# Test that it works
ssh -T git@github.com
```

You will not be able to login as you are not allowed to assign a TTY by GitHub.
This is why we disable the pseudo-terminal allocation above with the `-T`
option to ssh. You should receive a greeting welcoming you with your username
you if you were successful.

### Enable italics in tmux ###

As of tmux 2.1, you can enable italics support by setting the default terminal
to `tmux*` instead of the usual `screen*`. See [tmux
changelog](https://github.com/tmux/tmux/blob/2.1/FAQ#L355-L383) for more
details. However, it seems my Mac does not support the `xterm+tmux` or the
`xterm+256setaf` terminfo. I simply replaced those with the below and it works.

```zsh
tmux|tmux terminal multiplexer,
  ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m,
  use=xterm, use=screen,

tmux-256color|tmux with 256 colors,
    use=xterm-256color, use=tmux,
```

I stored the two entries above in `~/terminfo/` and then run the commands below
to compile them into `~/.terminfo`

```zsh
tic -x tmux.terminfo
tic -x tmux-256color.terminfo
```
