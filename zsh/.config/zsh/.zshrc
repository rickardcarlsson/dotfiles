# Plugins
source /usr/share/zsh/share/antigen.zsh
antigen theme geometry-zsh/geometry

antigen bundle RobSis/zsh-completion-generator # Generate completions with: gencomp program
antigen bundle chrissicool/zsh-256color # Enhance the terminal environment with 256 colors
antigen bundle rickardcarlsson/colorize # Colorize the output of various programs (including man), requires grc

antigen bundle command-not-found
antigen bundle extract
antigen bundle npm                # support for NodeJS package manager
antigen bundle pip                # support for Python Package Manager

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

# Exports
export BROWSER=/usr/bin/chromium
export EDITOR=/usr/bin/code
export PATH="/opt/anaconda/bin:$PATH" # Python path
export TMPDIR=/tmp

# Lines configured by zsh-newuser-install
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
bindkey -e                     # emacs keymap

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

setopt extended_history        # record timestamp of command in HISTFILE
setopt hist_expire_dups_first  # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups        # ignore duplicated commands history list
setopt hist_ignore_space       # ignore commands that start with space
setopt hist_verify             # show command with history expansion to user before running it
setopt inc_append_history_time # add commands to HISTFILE in order of execution
setopt share_history           # share command history data
setopt globdots

# Activate fuzzy finder
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Load aliases and shortcuts if existent.
[ -f "$ZDOTDIR/aliasrc" ] && source "$ZDOTDIR/aliasrc"
[ -f "$ZDOTDIR/shortcutrc" ] && source "$ZDOTDIR/shortcutrc"

# Import secrets if they exist
# [ -s ~/.secrets ] && source "~/.secrets"

