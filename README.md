# New MacOS setup #
These instructions are specific to macOS (or macOS Big Sur 11.1 at the time of last updating this README)

## Google Chrome
Use Safari to download and install [Google Chrome](https://www.google.com/chrome/). Sign in to Chrome (you will need password from 1Password) and this will sync your bookmarks and extensions, including **1Password X** which you will need for a lot of services and accounts that you will need to login to. It also helps to have the usual look and feel when searching for things online.

## Homebrew
Open the builtin `terminal` app and install Homebrew so the rest of the installations can be done using it.
```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Or check latest installation instructions at [brew.sh](https://brew.sh)

## iTerm2
```zsh
brew install iterm2
```
Now you can close *Terminal* and start using *iTerm2* instead


## Zsh
Since the built-in version of Zsh on OS X is frequently out of date, install the latest version using Homebrew so that it can be easily kept upto date.
```zsh
brew install zsh zsh-completions
```
Now you have two versions of *zsh*, the builtin `/bin/zsh` and the newer `/usr/local/bin/zsh`. 

To ensure you're using the new version and not the older one, enable the use of the new shell by adding the path `/usr/local/bin/zsh` to `/etc/shells` file
```bash
sudo vim /etc/shells
```
Then make this new shell your default shell for your current user
```bash
chsh -s /usr/local/bin/zsh
```

## Git
Prefer Homebrew version over built-in MacOS version.
```zsh
brew install git
```

## Configure .gitconfig basics
```zsh
# Setup the core user variables
git config --global user.name "Magnus Oberg"
git config --global user.email "youremail@gmail.com"

# Add some basic aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

# Make the pager leave content on screen after exit
git config --global core.pager "less -F -X"
```

## GitHub CLI
```zsh
brew install gh
```
Running it for the first time will ask to authenticate to GitHub. 
As password-based authentication for GitHub is deprecated it will ask 
for your password (and any 2FA/MFA token required) and then auto-install a
Personal Access Token (PAT) which is stored in `~/.config/gh/hosts.yml`.

It also seems that the git credential.helper osxkeychain will auto-cache this 
PAT as a general access token for all regular git command line actions using HTTPS 
protocol for all `github.com` URLs, which means that you should not be prompted for user 
credentials when pulling / fetching / pushing.

```zsh
# Enter multiline entry.. including extra blank line at end to signify end of input.
$ git credential-osxkeychain get
host=github.com
protocol=https

password=xxxxxxxxxxxxxxxxxxxxxxxxxx
username=magnusoberg

# Or just use gh to show you your status and token.
$ gh auth status --show-token
github.com
  ✓ Logged in to github.com as magnusoberg (~/.config/gh/hosts.yml)
  ✓ Git operations for github.com configured to use https protocol.
  ✓ Token: xxxxxxxxxxxxxxxxxxxxxxxxxx
```
In order to get gh command completion, add the following to your .zshrc or just run it when needed.
```zsh
eval "$(gh completion -s zsh)"
```

> **NOTE**: You can view, and revoke if necessary, the access token under `Settings -> Applications -> Authorized OAuth Apps`. 
> This is NOT under `Developer Settings -> OAuth Apps` or `Personal access tokens`.

## Clone dotfiles
```zsh
cd ~
gh repo clone magnusoberg/dotfiles
ln -s dotfiles/zshrc .zshrc
ln -s dotfiles/vimrc .vimrc
ln -s dotfiles/tmux.conf .tmux.conf
```

## tmux
```zsh
brew install tmux
```

## fzf - fuzzy finder
```zsh
# fd used by my custom profiles as a replacement for find
brew install fzf fd

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
```

## Lua
Lua is required for z.lua to run, so we need to install it first.
```zsh
brew install lua
```

## z.lua
```zsh
mkdir -p ~/repos/src && cd ~/repos/src
gh repo clone skywind3000/z.lua
```
Then make sure to `eval "$(lua ~/repos/src/z.lua/z.lua --init zsh enhanced fzf)"` in .zshrc

## Vim
```zsh
brew install vim
```
**NOTE**: before running vim the first time, make sure to install vim-plug so that the plugins section of your `.vimrc` can load and install the Plugin required
```zsh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
This will also auto-create the `~/.vim` directory, where all the plugins will be stored. It will also be used by default for Vim's user configuration files as defined in `.vimrc`.

To install the plugins, start by ensuring that you have symlinked your config file to your home directory.
```zsh
ln -s dotfiles/vimrc ~/.vimrc
```
Then start Vim, and enter `:PlugInstall`. This will install all the plugins that have been mentioned by Vim through the config.

## Karabiner-Elements
```zsh
brew install --cask karabiner-elements
```
* Configure Capslock to become Esc if pressed alone, or Ctrl if pressed together with another key
  * Go to `Complex modifications` and select *Add rule*
  * Import rule from internet
  * Search for and select `Change caps_lock key (rev 4)`
  * Import. You may need to grant permissions for Karabiner first time.
* Configure Ctrl-O to double as Enter
  * Download and install `Save pinky fingers (rev 2)` and add the rule `Change Control + o to Enter`

## Ukelele
```zsh
brew install --cask ukelele
```
Ukelele allows use of custom keymaps to control keyboard. I've setup a custom Swedish keymap that allows me to use grave accent (`) and tilde (~) which otherwise are very difficult to attain as these keys are used primarily in combination with other keys in Swedish to provide umlauts. Apps like gmail do not seem to accept key combinations instead of a single keycode.

I could get close to this behaviour with Karabiner-Elements, but the change would be universal and not dependent on input source. Therefore I would lose the other key input as they would effectively now be the same. With Ukelele I can have different mappings per input source, which is much more convenient.

### Ukelele setup
Copy `SwedishCustom.bundle` file to `~/Library/Keyboard Layouts` and select it as input source in keyboard preferences.


## Nerd Fonts
```zsh
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```
Then to use Nerd Fonts in iTerm, go to *Preferences -> Text* and select Nerd Font from list of available fonts. Select font size.

## Visual Studio Code
```
brew install --cask visual-studio-code
```

## SSH Host Key Fingerprints
* [Gitlab](https://docs.gitlab.com/ee/user/gitlab_com/#ssh-host-keys-fingerprints)
* [GitHub Testing SSH connections](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/testing-your-ssh-connection)
  * [GitHub](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/githubs-ssh-key-fingerprints)

## Zsh startup
zsh expects directories to only be writeable by owner (magnus) or root. In MacOS the user is set to admin and not root. Since Homebrew installs zsh without need for admin/root privileges, we can simply disable admin write access.
```
$ compaudit
There are insecure directories:
/usr/local/share/zsh/site-functions
/usr/local/share/zsh
/usr/local/share

$ ll -ld /usr/local/share
drwxrwxr-x  18 magnus  admin   576B Jan  7 22:21 /usr/local/share/

$ compaudit | xargs g-w
```
This should fix the problem and running `compaudit` again should report no insecure directories.

## Mac App Store CLI
```zsh
brew install mas
```
`mas` does not work well under tmux as it suffers from same issues that used to affect older versions of tmux. In order to run it under `tmux` you would need to install `reattach-to-user-namespace`

Alternatively, simply run `mas` outside of `tmux`.


## Install Brave Browswer - all the goodness of Chrome, without the tracking
```zsh
brew install --cask brave-browser
```

## Others
```zsh
brew install --cask daisydisk
brew install --cask firefox
brew install --cask expressvpn
brew install --cask skitch
brew install --cask spotify

brew install bat


```







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

# ncurses based directory usage tools
brew install ncdu
#brew install mc     # Midnight commander

# Install youtube downloader and vlc for background videos
brew install youtube-dl
brew cask install vlc

# Install faster search tools than grep and Ack
brew install ag            # Silver searcher   - better than Ack
brew install pt            # platinum searcher - better than ag
brew install rg            # ripgrep           - better than pt
brew install fd            # user-friendlier and faster 'find' - now my default command for FZF_*
brew install bench         # command line benchmarking tool
brew install exa           # modern version of ls - better than colorls
brew install tldr          # takes a while to update the local database on first run
brew install ranger        # vim like file manager

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

# This will enable the 'brew bundle' command and allow the use of a Brewfile
brew tap Homebrew/bundle

brew tap caskroom/cask
brew cask install iterm2
brew cask install telegram
brew cask install docker
brew cask install visual-studio-code
brew cask install slack
brew cask install gdrive
brew cask install 1password
brew cask install dropbox

# Might need to install virtualbox twice. First time will fail because it needs
# some kernel extensions enabled. Once enabled - reinstall and it shoud work.
brew cask install virtualbox    # Required by minikube to run k8 clusters locally
brew cask install minikube      # k8 dev-cluster on a single host using virtualbox

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


# Install colorls
# gem install colorls   # prefer to use exa instead

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

## Change Git protocol to use SSH instead of HTTPS
One you've setup your SSH key in GitHub and GitLab you can change the protocol used by the repo for your push/pull actions.
```zsh
# list current protocol used
$ git remote -v
origin  https://github.com/magnusoberg/dotfiles.git (fetch)
origin  https://github.com/magnusoberg/dotfiles.git (push)

# Change it to use SSH by default instead of HTTPS
$ git remote set-url origin git@github.com:magnusoberg/dotfiles.git
$ git remote -v
origin  git@github.com:magnusoberg/dotfiles.git (fetch)
origin  git@github.com:magnusoberg/dotfiles.git (push)
```

### Enable italics in tmux ###

As of tmux 2.1, you can enable italics support by setting the default terminal
to `tmux*` instead of the usual `screen*`. See [tmux
changelog](https://github.com/tmux/tmux/blob/2.1/FAQ#L355-L383) for more
details. However, that link adds some strange tips, like adding standout mode controls (smso & rmso) that 
have nothing to do with italics, and a termcap entry called 'Ms@' which I can find nothing about and that doesn't
even look like a termcap entry.

Also, it seems my terminfo does not contain the `xterm+tmux` or the `xterm+256setaf` terminfo entries.

I simply replaced those with the below and it works.

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

## A better alternative
MacOS comes with an old version of `ncurses` Big Sur ships with versions 5.7 by default. Latest `ncurses` at time of this writing was 6.2.20200212.

The builtin Mac version terminfo database does not contain an entry for tmux-256color, but the Homebrew version does. The problem is that the Homebrew version is `keg-only` and not symlinked so as not to break other Mac apps. Therefore we have to use Homebrew version of `infocmp` to output tmux-256color terminfo entry to a temporary file, and then use the builtin Mac version of `tic` to install this entry into `~/.terminfo`

```zsh
# Generate terminfo into text file
/usr/local/opt/ncurses/bin/infocmp tmux-256color > ~/tmux-256color.terminfo

# use builtin 'tic' to compile terminfo into ~/.terminfo
tic -x ~/tmux-256color.terminfo

# remove temporary file as it is no longer needed.
rm ~/tmux-256color.terminfo

# or, because we're running zsh, do it all in one step without any temp files
tic -x =(/usr/local/opt/ncurses/bin/infocmp tmux-256color)

# check to see that it worked
$ exa --tree ~/.terminfo
/Users/magnus/.terminfo
└── 74
   └── tmux-256color

# check to see that the tmux-256color entry is now live and contains the relevant 
$ infocmp tmux-256color|rg "ritm|sitm|rmso|smso"
        ri=\EM, ritm=\E[23m, rmacs=^O, rmcup=\E[?1049l, rmir=\E[4l,
        rmkx=\E[?1l\E>, rmso=\E[27m, rmul=\E[24m,
        sgr0=\E[m\017, sitm=\E[3m, smacs=^N, smcup=\E[?1049h,
        smir=\E[4h, smkx=\E[?1h\E=, smso=\E[7m, smul=\E[4m,

```
