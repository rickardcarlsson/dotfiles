# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Applications/environment variables
[[ -f $HOME/.config/zsh/exports ]] && . $HOME/.config/zsh/exports

# TMUX over SSH
 
#if [[ -z "$TMUX" ]] && [ -n "$SSH_CONNECTION" ]; then
  ##tmux attach-session -t ssh_tmux || tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf new-session -s ssh_tmux -d
  #tmux attach-session -t ssh_tmux || tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf new-session -s ssh_tmux
#  tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf new-session -s ssh_tmux -d
#fi

# Plugins
source /usr/share/zsh/share/antigen.zsh
antigen use oh-my-zsh             # Load the oh-my-zsh's library.

# antigen bundle zdharma/fast-syntax-highlighting 
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle marlonrichert/zsh-autocomplete # Find-as-you-type completion

antigen bundle command-not-found
antigen bundle extract
antigen bundle npm                # support for NodeJS package manager
antigen bundle pip                # support for Python Package Manager

antigen bundle chrissicool/zsh-256color # Enhance the terminal environment with 256 colors
antigen bundle RobSis/zsh-completion-generator # Generate completions with: gencomp program
antigen bundle rickardcarlsson/colorize # Colorize the output of various programs (including man), requires grc
antigen bundle djui/alias-tips # Help remembering shell aliases

antigen theme romkatv/powerlevel10k  

antigen apply

bindkey -v                       # vim keymap

# Import secrets if they exist
[[ -s $DOCS/.secrets ]] && . $DOCS/.secrets 

# Activate fuzzy finder
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Load aliases and shortcuts if existent.
[ -f $ZDOTDIR/aliasrc ] && . $ZDOTDIR/aliasrc
[ -f $ZDOTDIR/shortcutrc ] && . $ZDOTDIR/shortcutrc


# Command history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE

# Conda
__conda_setup="$('/opt/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup

setopt extended_history        # record timestamp of command in HISTFILE
setopt hist_expire_dups_first  # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups        # ignore duplicated commands history list
setopt hist_ignore_space       # ignore commands that start with space
setopt hist_verify             # show command with history expansion to user before running it
setopt inc_append_history_time # add commands to HISTFILE in order of execution
setopt share_history           # share command history data

setopt globdots                # Allow matching of dotfiles
setopt complete_in_word        # Complete from both ends of a word.
setopt always_to_end           # Move cursor to the end of a completed word.
setopt path_dirs               # Perform path search even on command names with slashes.
setopt auto_param_slash        # If completed parameter is a directory, add a trailing slash.


# https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh

# zstyle
[ -f $ZDOTDIR/styles ] && . $ZDOTDIR/styles

# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.
autoload -Uz compinit
_comp_path="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump"
# #q expands globs in conditional expressions
if [[ $_comp_path(#qNmh-20) ]]; then
    # -C (skip function check) implies -i (skip security check).
    compinit -C -d "$_comp_path"
else
    mkdir -p "$_comp_path:h"
    compinit -i -d "$_comp_path"
fi
unset _comp_path

# zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5' 

# Kitty specific settings
[[ $TERM == "xterm-kitty" ]] && [ -f $ZDOTDIR/kitty ] && . $ZDOTDIR/kitty

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

