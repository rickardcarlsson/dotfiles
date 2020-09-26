#-- START ZCACHE GENERATED FILE
#-- GENERATED: ons 23 sep 2020 15:03:32 CEST
#-- ANTIGEN develop
_antigen () {
	local -a _1st_arguments
	_1st_arguments=('apply:Load all bundle completions' 'bundle:Install and load the given plugin' 'bundles:Bulk define bundles' 'cleanup:Clean up the clones of repos which are not used by any bundles currently loaded' 'cache-gen:Generate cache' 'init:Load Antigen configuration from file' 'list:List out the currently loaded bundles' 'purge:Remove a cloned bundle from filesystem' 'reset:Clears cache' 'restore:Restore the bundles state as specified in the snapshot' 'revert:Revert the state of all bundles to how they were before the last antigen update' 'selfupdate:Update antigen itself' 'snapshot:Create a snapshot of all the active clones' 'theme:Switch the prompt theme' 'update:Update all bundles' 'use:Load any (supported) zsh pre-packaged framework') 
	_1st_arguments+=('help:Show this message' 'version:Display Antigen version') 
	__bundle () {
		_arguments '--loc[Path to the location <path-to/location>]' '--url[Path to the repository <github-account/repository>]' '--branch[Git branch name]' '--no-local-clone[Do not create a clone]'
	}
	__list () {
		_arguments '--simple[Show only bundle name]' '--short[Show only bundle name and branch]' '--long[Show bundle records]'
	}
	__cleanup () {
		_arguments '--force[Do not ask for confirmation]'
	}
	_arguments '*:: :->command'
	if (( CURRENT == 1 ))
	then
		_describe -t commands "antigen command" _1st_arguments
		return
	fi
	local -a _command_args
	case "$words[1]" in
		(bundle) __bundle ;;
		(use) compadd "$@" "oh-my-zsh" "prezto" ;;
		(cleanup) __cleanup ;;
		(update|purge) compadd $(type -f \-antigen-get-bundles &> /dev/null || antigen &> /dev/null; -antigen-get-bundles --simple 2> /dev/null) ;;
		(theme) compadd $(type -f \-antigen-get-themes &> /dev/null || antigen &> /dev/null; -antigen-get-themes 2> /dev/null) ;;
		(list) __list ;;
	esac
}
antigen () {
  local MATCH MBEGIN MEND
  [[ "$ZSH_EVAL_CONTEXT" =~ "toplevel:*" || "$ZSH_EVAL_CONTEXT" =~ "cmdarg:*" ]] && source "/usr/share/zsh/share/antigen.zsh" && eval antigen $@;
  return 0;
}
typeset -gaU fpath path
fpath+=(/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/zsh-users/zsh-autosuggestions /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/zsh-users/zsh-syntax-highlighting /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/marlonrichert/zsh-autocomplete /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/chrissicool/zsh-256color /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/RobSis/zsh-completion-generator /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/rickardcarlsson/colorize /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/djui/alias-tips /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/romkatv/powerlevel10k) path+=(/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/zsh-users/zsh-autosuggestions /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/zsh-users/zsh-syntax-highlighting /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/marlonrichert/zsh-autocomplete /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/chrissicool/zsh-256color /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/RobSis/zsh-completion-generator /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/rickardcarlsson/colorize /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/djui/alias-tips /home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/romkatv/powerlevel10k)
_antigen_compinit () {
  autoload -Uz compinit; compinit -i -d "/home/sickan/.config/zsh/.antigen/.zcompdump"; compdef _antigen antigen
  add-zsh-hook -D precmd _antigen_compinit
}
autoload -Uz add-zsh-hook; add-zsh-hook precmd _antigen_compinit
compdef () {}

if [[ -n "/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh" ]]; then
  ZSH="/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh"; ZSH_CACHE_DIR="/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/cache/"
fi
#--- BUNDLES BEGIN
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/bzr.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/clipboard.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/cli.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/compfix.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/completion.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/correction.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/diagnostics.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/directories.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/functions.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/git.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/grep.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/history.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/key-bindings.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/misc.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/nvm.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/prompt_info_functions.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/spectrum.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/termsupport.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/theme-and-appearance.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract/extract.plugin.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm/npm.plugin.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip/pip.plugin.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/chrissicool/zsh-256color/zsh-256color.plugin.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/RobSis/zsh-completion-generator/zsh-completion-generator.plugin.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/rickardcarlsson/colorize/colorize.plugin.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/djui/alias-tips/alias-tips.plugin.zsh';
source '/home/sickan/.dotfiles/zsh/.config/zsh/.antigen/bundles/romkatv/powerlevel10k/powerlevel10k.zsh-theme.antigen-compat';

#--- BUNDLES END
typeset -gaU _ANTIGEN_BUNDLE_RECORD; _ANTIGEN_BUNDLE_RECORD=('https://github.com/robbyrussell/oh-my-zsh.git lib plugin true' 'https://github.com/zsh-users/zsh-autosuggestions.git / plugin true' 'https://github.com/zsh-users/zsh-syntax-highlighting.git / plugin true' 'https://github.com/marlonrichert/zsh-autocomplete.git / plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/command-not-found plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/extract plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/npm plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/pip plugin true' 'https://github.com/chrissicool/zsh-256color.git / plugin true' 'https://github.com/RobSis/zsh-completion-generator.git / plugin true' 'https://github.com/rickardcarlsson/colorize.git / plugin true' 'https://github.com/djui/alias-tips.git / plugin true' 'https://github.com/romkatv/powerlevel10k.git / theme true')
typeset -g _ANTIGEN_CACHE_LOADED; _ANTIGEN_CACHE_LOADED=true
typeset -ga _ZCACHE_BUNDLE_SOURCE; _ZCACHE_BUNDLE_SOURCE=('/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/bzr.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/clipboard.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/cli.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/compfix.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/completion.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/correction.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/diagnostics.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/directories.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/functions.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/git.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/grep.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/history.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/key-bindings.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/misc.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/nvm.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/prompt_info_functions.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/spectrum.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/termsupport.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/lib/theme-and-appearance.zsh' '/home/sickan/.config/zsh/.antigen/bundles/zsh-users/zsh-autosuggestions//' '/home/sickan/.config/zsh/.antigen/bundles/zsh-users/zsh-autosuggestions///zsh-autosuggestions.plugin.zsh' '/home/sickan/.config/zsh/.antigen/bundles/zsh-users/zsh-syntax-highlighting//' '/home/sickan/.config/zsh/.antigen/bundles/zsh-users/zsh-syntax-highlighting///zsh-syntax-highlighting.plugin.zsh' '/home/sickan/.config/zsh/.antigen/bundles/marlonrichert/zsh-autocomplete//' '/home/sickan/.config/zsh/.antigen/bundles/marlonrichert/zsh-autocomplete///zsh-autocomplete.plugin.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract/extract.plugin.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm/npm.plugin.zsh' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip' '/home/sickan/.config/zsh/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip/pip.plugin.zsh' '/home/sickan/.config/zsh/.antigen/bundles/chrissicool/zsh-256color//' '/home/sickan/.config/zsh/.antigen/bundles/chrissicool/zsh-256color///zsh-256color.plugin.zsh' '/home/sickan/.config/zsh/.antigen/bundles/RobSis/zsh-completion-generator//' '/home/sickan/.config/zsh/.antigen/bundles/RobSis/zsh-completion-generator///zsh-completion-generator.plugin.zsh' '/home/sickan/.config/zsh/.antigen/bundles/rickardcarlsson/colorize//' '/home/sickan/.config/zsh/.antigen/bundles/rickardcarlsson/colorize///colorize.plugin.zsh' '/home/sickan/.config/zsh/.antigen/bundles/djui/alias-tips//' '/home/sickan/.config/zsh/.antigen/bundles/djui/alias-tips///alias-tips.plugin.zsh' '/home/sickan/.config/zsh/.antigen/bundles/romkatv/powerlevel10k//' '/home/sickan/.config/zsh/.antigen/bundles/romkatv/powerlevel10k///powerlevel10k.zsh-theme')
typeset -g _ANTIGEN_CACHE_VERSION; _ANTIGEN_CACHE_VERSION='develop'

#-- END ZCACHE GENERATED FILE
