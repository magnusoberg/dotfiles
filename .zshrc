# .zshrc file
# Author: Magnus Oberg

# Define $home_system variable to conditionally run certain items only on the home system
local home_system='Magnus.local'

export HISTFILE=~/.histfile
export HISTSIZE=100000        # 100K history lines should be enough
export SAVEHIST=$HISTSIZE

# Set options {{{
setopt APPEND_HISTORY
setopt AUTO_CD
setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_GLOB
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_VERIFY            # Don't execute immediately upon history expansion.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt NO_BEEP
setopt NO_MATCH
setopt NO_NOTIFY
setopt SHARE_HISTORY          # Share history between all sessions.

bindkey -e
export PS1='%m %~ %# '

# Added by compinstall {{{
zstyle :compinstall filename ~/.zshrc
# Used to also include calls to compinit - removed due to zplug calling this
# End of compinstall }}}

if [[ $HOST == $home_system ]]; then
    eval $(keychain --eval --agents ssh --inherit any id_rsa)
fi

# Source my files
# make sure to secure your ~/.zsh directory so only you can write there!
local files=(~/.zsh/*.zsh) 2>/dev/null
for f in $files; do
    source ${f}
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -d ~/bin ]] && path=(~/bin $path)
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
export ZPLUG_HOME="${HOME}/.zplug"
source "${ZPLUG_HOME}/init.zsh"

# setopt prompt_subst

# zplug "zsh-users/zsh-autosuggestions"
# zplug "zsh-users/zsh-syntax-highlighting", defer:2
# zplug "akinjide/chi", as:theme
# zplug "aaronjamesyoung/aaron-zsh-theme", as:theme, from:oh-my-zsh
# zplug "modules/prompt", from:prezto
# zplug 'themes/sorin', from:oh-my-zsh
# zplug 'themes/robbyrussell', from:oh-my-zsh

# zplug check || zplug install
# zplug load


# Source tmuxinator completion if it exists
[[ -f ~/.zsh/completions/tmuxinator.zsh ]] && source ~/.zsh/completions/tmuxinator.zsh
local files=(~/.zsh/completions/*.zsh-completion) 2>/dev/null
for f in $files; do
    source ${f}
done

# Source iTerm integration files if they exist
# I should review these fucntions in more detail at some time
[[ -e "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"

alias ll='ls -lah'
alias ls='ls -GF'
if [[ ! $(uname -s) == "Darwin" ]]; then
    alias ls='ls --color=auto'
fi

#End of file
