if [[ -z $commands[thefuck] ]]; then
    echo 'thefuck is not installed, you should "pip install thefuck" or "brew install thefuck" first.'
    echo 'See https://github.com/nvbn/thefuck#installation'
    return 1
fi

# Register alias
eval "$(thefuck --alias)"
#eval $(thefuck --alias --enable-experimental-instant-mode)

command_not_found_handler () {
    TF_SHELL_ALIASES=$(alias);
    TF_CMD=$(
        export TF_SHELL_ALIASES;
        export TF_SHELL=zsh;
        export TF_ALIAS=fuck;
        export TF_HISTORY="$@";
        export PYTHONIOENCODING=utf-8;
        thefuck THEFUCK_ARGUMENT_PLACEHOLDER
    ) && eval $TF_CMD;
    test -n "$TF_CMD" && print -s $TF_CMD;
}

# fuck-command-line() {
#     local FUCK="$(THEFUCK_REQUIRE_CONFIRMATION=0 thefuck $(fc -ln -1 | tail -n 1) 2> /dev/null)"
#     [[ -z $FUCK ]] && echo -n -e "\a" && return
#     BUFFER=$FUCK
#     zle end-of-line
# }
# zle -N fuck-command-line
# Defined shortcut keys: [Esc] [Esc]
# bindkey -M emacs '\e\e' fuck-command-line
# bindkey -M vicmd '\e\e' fuck-command-line
# bindkey -M viins '\e\e' fuck-command-line
