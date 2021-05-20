# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Applications/environment variables
[[ -f $HOME/.config/zsh/exports ]] && . $HOME/.config/zsh/exports


# tmux-zsh-vim-titles plugin config
[[ -f $ZDOTDIR/tzvt.conf ]] && . $ZDOTDIR/tzvt.conf

# Plugins
[[ -f /usr/share/zsh/share/antigen.zsh ]] && . /usr/share/zsh/share/antigen.zsh
[[ -f $NIX_USER_PROFILE/share/antigen/antigen.zsh ]] && . $NIX_USER_PROFILE/share/antigen/antigen.zsh

antigen use oh-my-zsh             # Load the oh-my-zsh's library.

# antigen bundle zdharma/fast-syntax-highlighting 
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle marlonrichert/zsh-autocomplete # Find-as-you-type completion

# oh-my-zsh bundles
#antigen bundle command-not-found
antigen bundle extract
antigen bundle sudo
antigen bundle npm                # support for NodeJS package manager
antigen bundle pip                # support for Python Package Manager

antigen bundle chrissicool/zsh-256color # Enhance the terminal environment with 256 colors
antigen bundle RobSis/zsh-completion-generator # Generate completions with: gencomp program
antigen bundle rickardcarlsson/colorize # Colorize the output of various programs (including man), requires grc
antigen bundle djui/alias-tips # Help remembering shell aliases
#antigen bundle MichaelAquilina/zsh-auto-notify # Automatically sends out a notification when a long running task has completed.
antigen bundle MikeDacre/tmux-zsh-vim-titles # Intelligent terminal titles in tmux, zsh, and vim

antigen theme romkatv/powerlevel10k  

antigen apply

# The Fuck plugin
#[[ -f $ZDOTDIR/thefuck.plugin.zsh ]] && . $ZDOTDIR/thefuck.plugin.zsh 

# Ignore commands in zsh-auto-notify
#AUTO_NOTIFY_IGNORE+=("server" "desktop")

bindkey -v                       # vim keymap

# Import secrets
[[ -s $DOCS/.secrets ]] && . $DOCS/.secrets 

# Activate fuzzy finder
[ -f $ZDOTDIR/fzf-key-bindings.zsh ] && source $ZDOTDIR/fzf-key-bindings.zsh
[ -f $ZDOTDIR/fzf-completion.zsh ] && source $ZDOTDIR/fzf-completion.zsh
# fzf material darker theme
[ -f $ZDOTDIR/fzf-material-darker-theme.config ] && source $ZDOTDIR/fzf-material-darker-theme.config 

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

# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt EXTENDED_HISTORY        # record timestamp of command in HISTFILE
setopt HIST_EXPIRE_DUPS_FIRST  # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS        # ignore duplicated commands history list
setopt HIST_IGNORE_SPACE       # ignore commands that start with space
setopt HIST_VERIFY             # show command with history expansion to user before running it
setopt INC_APPEND_HISTORY_TIME # add commands to HISTFILE in order of execution
setopt SHARE_HISTORY           # share command history data
setopt GLOBDOTS                # Allow matching of dotfiles
setopt COMPLETE_IN_WORD        # Complete from both ends of a word.
setopt ALWAYS_TO_END           # Move cursor to the end of a completed word.
setopt PATH_DIRS               # Perform path search even on command names with slashes.
setopt AUTO_PARAM_SLASH        # If completed parameter is a directory, add a trailing slash.
setopt INTERACTIVE_COMMENTS    # Allow comments starting with `#` in the interactive shell.
setopt NO_CASE_GLOB            # Make globbing case insensitive.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
#setopt CORRECT             # Try to correct the spelling of commands. 
#setopt CORRECT_ALL         # Try to correct the spelling of all arguments in a line. 
unsetopt MENU_COMPLETE     # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

# https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh

# zstyle
[ -f $ZDOTDIR/styles ] && . $ZDOTDIR/styles

# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.
autoload -Uz compinit
_comp_path="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
# #q expands globs in conditional expressions
if [[ $_comp_path(#qNmh-20) ]]; then
    # -C (skip function check) implies -i (skip security check).
    compinit -C -d "$_comp_path"
else
    mkdir -p "$_comp_path:h"
    compinit -i -d "$_comp_path"
fi
unset _comp_path

zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

# Load aliases, functions and shortcuts
[ -f $ZDOTDIR/aliasrc ] && . $ZDOTDIR/aliasrc
[ -f $ZDOTDIR/shortcutrc ] && . $ZDOTDIR/shortcutrc
[ -f $ZDOTDIR/functionrc ] && . $ZDOTDIR/functionrc

# zsh-autosuggestions config
#zmodload zsh/zpty # Needed for competion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245' 
ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true
#ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=( "${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS[@]:#*forward-word}" )
# Tab completes with autosuggestion or cycles through menu items
zSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=( fzf-completion ) 

# Kitty specific settings
[[ -z $SSH_CONNECTION ]] && [[ $TERM == "xterm-kitty" ]] && [ -f $ZDOTDIR/kitty ] && . $ZDOTDIR/kitty

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

