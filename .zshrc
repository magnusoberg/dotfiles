# .zshrc file
# Author: Magnus Oberg

export HISTFILE=~/.histfile
export HISTSIZE=100000        # 100K history lines should be enough
export SAVEHIST=$HISTSIZE

setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY            # Don't execute immediately upon history expansion.

setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify

bindkey -e
export PS1='%~ %# '

# The following lines were added by compinstall {{{1
zstyle :compinstall filename '/Users/moberg/.zshrc'

# Commented out the below two lines due to zplug running compinit on it's own.
# autoload -Uz compinit
# compinit
# End of lines added by compinstall }}}1

eval $(keychain --eval --agents ssh --inherit any id_rsa)

alias ls='ls -FG'
alias ll='ls -la'
alias es='ssh es'
alias ic='ssh ic'

# Source my files
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/magic-abbrev.zsh
source ~/.zsh/marks.zsh
source ~/.zsh/variables.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

path=('/Users/moberg/bin' $path)
export PATH
export EDITOR=vim

# Setup run-help to work for internal commands, and not alias for 'man'
export HELPDIR=/usr/local/share/zsh/help
unalias run-help 2>/dev/null	# stderr redirection needed in case you re-source your .zshrc file
autoload run-help
alias help='run-help'

# Override FZF defaults
FZF_CTRL_T_COMMAND="command find -L . -mindepth 1 \\( -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"

# Setup zplug
export ZPLUG_HOME="/usr/local/opt/zplug"
source "${ZPLUG_HOME}/init.zsh"

# setopt prompt_subst

zplug "zsh-users/zsh-syntax-highlighting", defer:2
# zplug "akinjide/chi", as:theme
# zplug "aaronjamesyoung/aaron-zsh-theme", as:theme, from:oh-my-zsh
# zplug "modules/prompt", from:prezto
# zplug 'themes/sorin', from:oh-my-zsh
# zplug 'themes/robbyrussell', from:oh-my-zsh

zplug check || zplug install
zplug load


# I should review these fucntions in more detail at some time.
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
