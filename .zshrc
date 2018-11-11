# .zshrc file
# Author: Magnus Oberg

# Define $home_system variable to conditionally run certain items only on the home system
local home_system='Magnus.local'

export HISTFILE=~/.histfile
export HISTSIZE=100000        # 100K history lines should be enough
export SAVEHIST=$HISTSIZE

export LC_ALL=en_US.UTF-8 && export LANG=en_US.UTF-8

# Emacs style
bindkey -e
# Make forward/back movements with paths respect WORDCHARS
# for some reason it needs to be near the top of the .zshrc file.
autoload -U select-word-style
select-word-style bash

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# Vi style:
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line

# Set options
# setopt appendhistory
setopt autocd
setopt nobeep
# Treat the '!' character specially during expansion
# setopt banghist
setopt extendedglob
# Write the history file in the ":start:elapsed;command" format
setopt extendedhistory
# Expire duplicate entries first when trimming history
setopt histexpiredupsfirst
# Do not display a line previously found.
setopt histfindnodups
# Delete old recorded entry if new entry is a duplicate.
setopt histignorealldups
# Dont record an entry that was just recorded again.
setopt histignoredups
# Dont record an entry starting with a space.
setopt histignorespace
# Remove superfluous blanks before recording entry.
setopt histreduceblanks
# Dont write duplicate entries in the history file.
setopt histsavenodups
# Dont execute immediately upon history expansion.
setopt histverify
# Write to the history file immediately, not when the shell exits.
setopt incappendhistory
# Interactive Comments - for some weird reason the long option 'interactivecomment' messes up the syntax highlighting
setopt -k
# setopt nomatch
setopt nonotify
setopt promptsubst
# Share history between all sessions.
setopt sharehistory

bindkey -e
export PS1='%m %~ %# '

# Added by compinstall {{{
zstyle :compinstall filename ~/.zshrc
# Used to also include calls to compinit - removed due to zplug calling this
# End of compinstall }}}

if [[ $HOST == $home_system ]]; then
    eval $(keychain --eval --agents ssh --inherit any id_rsa --quiet)
fi

# Source my files
# make sure to secure your ~/.zsh directory so only you can write there!
local files=(~/.zsh/*.zsh) 2>/dev/null
for f in $files; do
    source ${f}
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -d ~/bin ]] && path=(~/bin $path)

path=($path /usr/local/opt/go/libexec/bin /Users/magnus/Library/Python/2.7/bin ~/go/bin)
fpath=($fpath ~/.zsh/funcs)
export GOPATH=${HOME}/go
export PATH
export EDITOR=vim
export GPG_TTY=$(tty)

# Setup run-help to work for internal commands, and not alias for 'man'
export HELPDIR=/usr/local/share/zsh/help
unalias run-help 2>/dev/null    # stderr redirection needed in case you re-source your .zshrc file
autoload run-help
alias help='run-help'

# # Override FZF defaults
# export FZF_CTRL_T_COMMAND="command find -L . -mindepth 1 \\( -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
#     -o -type f -print \
#     -o -type d -print \
#     -o -type l -print 2> /dev/null | cut -b3-"
#
# Setup zplug
export ZPLUG_HOME="${HOME}/.zplug"
source "${ZPLUG_HOME}/init.zsh"

# setopt prompt_subst

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# zplug "akinjide/chi", as:theme
# zplug "aaronjamesyoung/aaron-zsh-theme", as:theme, from:oh-my-zsh
# zplug "modules/prompt", from:prezto
# zplug 'themes/sorin', from:oh-my-zsh
# zplug 'themes/robbyrussell', from:oh-my-zsh

zplug check || zplug install
zplug load


# Source tmuxinator completion if it exists
# [[ -f ~/.zsh/completions/tmuxinator.zsh ]] && source ~/.zsh/completions/tmuxinator.zsh
# local files=(~/.zsh/completions/*.zsh-completion)
# for f in $files; do
#     source ${f}
# done

# AWS Cli tools...
[[ -d ~/Library/Python/2.7/bin ]] && path=($path ~/Library/Python/2.7/bin)
[[ -f ~/Library/Python/2.7/bin/aws_zsh_completer.sh ]] && source ~/Library/Python/2.7/bin/aws_zsh_completer.sh

# Source iTerm integration files if they exist
# I should review these fucntions in more detail at some time
[[ -e "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"

alias ls='ls -GF'
alias ll='ls -lah'

if [[ ! $(uname -s) == "Darwin" ]]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Common aliases

# alias git to hub so that it can intercept new hub commands easily
# suggested used: 'eval $(hub alias -s)' or 'eval $(hub alias -s zsh)'
# but probably easier to just to it directly
alias git=hub

alias gst='git st'
alias hd='hexdump -C'
alias nl='nl -s ". " -w 3'

#End of file
