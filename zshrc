# .zshrc file
# Author: Magnus Oberg

# Zsh start up sequence: {{{
#  1) /etc/zshenv   -> Always run for every zsh.   (login + interactive + other)
#  2)   ~/.zshenv   -> Usually run for every zsh.  (login + interactive + other)
#  3) /etc/zprofile -> Run for login shells.       (login)
#  4)   ~/.zprofile -> Run for login shells.       (login)
#  5) /etc/zshrc    -> Run for interactive shells. (login + interactive)
#  6)   ~/.zshrc    -> Run for interactive shells. (login + interactive)
#  7) /etc/zlogin   -> Run for login shells.       (login)
#  8)   ~/.zlogin   -> Run for login shells.       (login)
# }}}
# zmodload zsh/zprof

export HISTFILE=~/.histfile
export HISTSIZE=100000        # 100K history lines should be enough
export SAVEHIST=$HISTSIZE

# Remove annoying Beer mug from Homebrew
export HOMEBREW_NO_EMOJI=1

# Don't know why these were explicitly set. Leaving them unset until I can figure out why
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Try to make use of new centralized config directory as much as possible by specifically
# telling new programs about the .config directory.
export XDG_CONFIG_HOME=~/.config

# Emacs style
bindkey -e

# Make forward/back movements with paths respect WORDCHARS
# for some reason it needs to be near the top of the .zshrc file.
autoload -U select-word-style
select-word-style bash

# zaw allows Ctrl-X + ; to bring up Zaw menu -- pretty cool, but slow
#source ~/src/zaw/zaw.zsh

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey '^u' backward-kill-line

# {{{ Set options
# Only set non-default options to avoid clutter

setopt autocd                # Allow typing plain directory names on the commandline
setopt nobeep                # Don't beep on error
setopt extendedglob          # Treat ~, # and ^ as filename globs
setopt extendedhistory       # Write the history file in the ":start:elapsed;command" format
setopt histexpiredupsfirst   # Expire duplicate entries first when trimming history
setopt histfindnodups        # Do not display a line previously found.
setopt histignorealldups     # Delete old recorded entry if new entry is a duplicate.
setopt histignoredups        # Dont record an entry that was just recorded again.
setopt histignorespace       # Dont record an entry starting with a space.
setopt histreduceblanks      # Remove superfluous blanks before recording entry.
setopt histsavenodups        # Dont write duplicate entries in the history file.
setopt histverify            # Dont execute immediately upon history expansion.
setopt incappendhistory      # Write to the history file immediately, not when the shell exits.
setopt interactivecomments   # Allow comments at the end of command lines
setopt nonotify              # Notify background jobs only just before PROMPT and not immediately
setopt promptsubst           # Allow substitutions in the command prompt
setopt sharehistory          # Share history between all sessions.

# }}}

export PS1='%m %~ %# '

# Added by compinstall {{{

# Seems I need to run this here in order to get completion running properly.
# Used to rely on zplug, but this was not sufficient, as I couldn't get word completion for FASD working without this.
# autoload -Uz compinit && compinit

# Don't know what this does actually - was added by compinstall somehow
zstyle :compinstall filename ~/.zshrc

# enable menu selection for completion system
zstyle ':completion:*' menu select

# End of compinstall }}}

# Only run this on my 'local' machine - no remote machines.
if [[ $HOST == 'magnus-mbp.local' ]]; then
    echo "Starting local keychain daemon"
    # eval $(keychain --eval --agents ssh --inherit any id_rsa --quiet)
    eval $(keychain --eval id_rsa )
fi

# Source my files
# make sure to secure your ~/.zsh directory so only you can write there!
local files=(~/.zsh/*.zsh) 2>/dev/null
for f in $files; do
    source ${f}
done

# Source fzf shell settings if file exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add ~/bin to the path if it exists
[[ -d ~/bin ]] && path=(~/bin $path)

# File paths
# Some paths are already set: checkout /etc/zprofile, /etc/paths, /etc/paths.d etc.
#   also /usr/libexec/path_helper -s uses some of the above to pre-generate paths
export GOPATH=${HOME}/go
export PATH
export EDITOR=vim

path=(
  $path                                  # Don't overwrite existing paths
  /usr/local/opt/go/libexec/bin          # Go installation path - needed by Go
  ${GOPATH}/bin                          # Go executables
  /Users/magnus/Library/Python/2.7/bin   # Python 2.7
  /Users/magnus/Library/Python/3.7/bin   # Python3
  /usr/local/sbin                        # Some extra Homebrew locations
  # /usr/local/lib/ruby/gems/2.6.0/bin     # Default location for ruby gems
  ~/.gem/ruby/2.3.0/bin                  # where --user-installed gems go
)

# Function paths
fpath=(
  $fpath
  /usr/local/share/zsh-completions       # Recommended by `brew install zsh-completions`
  ~/.zsh/funcs                           # My personal functions
  ~/.zsh/completion                      # Completion scripts
  ~/.zsh/autoload
)

# Needed for GNU PGP to be able to prompt for password somehow..
export GPG_TTY=$(tty)

# Setup run-help to work for internal commands, and not alias for 'man'
export HELPDIR=/usr/local/share/zsh/help
unalias run-help 2>/dev/null    # stderr redirection needed in case you re-source your .zshrc file
autoload run-help
alias help='run-help'

# Powerlevel9k variables {{{1
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰─ $ "

# enable the vcs changeset commit id
POWERLEVEL9K_SHOW_CHANGESET=true
# just show the 6 first characters of changeset
POWERLEVEL9K_CHANGESET_HASH_LENGTH=7

# Source the Powerlevel9k theme -- make sure to specify the custom env variables before this!
# source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme
# export ZSH_THEME="powerlevel9k/powerlevel9k"

# Setup zplug {{{1
if [[ -d /usr/local/opt/zplug ]]; then
    # installed via Homebrew.
    export ZPLUG_HOME="/usr/local/opt/zplug"
else
    # installed manually in root
    export ZPLUG_HOME="$HOME/.zplug"
fi
source "$ZPLUG_HOME/init.zsh"

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Powerlevel10k is MUCH faster than 9k - so I use that instead.
# It is a drop-in replacement for 9k, so I don't need to change any of the variables
zplug romkatv/powerlevel10k, use:powerlevel10k.zsh-theme

# Allow zplug to manage itself, for updates etc.
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug check || zplug install

# 'zplug load' calls compinit automatically - and only once!
zplug load
# }}}
# Source tmuxinator completion if it exists {{{
# [[ -f ~/.zsh/completions/tmuxinator.zsh ]] && source ~/.zsh/completions/tmuxinator.zsh
# local files=(~/.zsh/completions/*.zsh-completion)
# for f in $files; do
#     source ${f}
# done
# }}}
# AWS Cli tools... {{{
# [[ -d ~/Library/Python/2.7/bin ]] && path=($path ~/Library/Python/2.7/bin)
# [[ -f ~/Library/Python/2.7/bin/aws_zsh_completer.sh ]] && source ~/Library/Python/2.7/bin/aws_zsh_completer.sh
# }}}
# gcloud CLI tools {{{
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
# }}}

# Source iTerm integration files if they exist
# I should review these fucntions in more detail at some time
# [[ -e "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"

#End of file
