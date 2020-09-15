#-- START ZCACHE GENERATED FILE
#-- GENERATED: sön 23 aug 2020 21:48:08 CEST
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
fpath+=(/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib /home/test/.antigen/bundles/zsh-users/zsh-completions /home/test/.antigen/bundles/zsh-users/zsh-syntax-highlighting /home/test/.antigen/bundles/zsh-users/zsh-autosuggestions /home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found /home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract /home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm /home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip /home/test/.antigen/bundles/marlonrichert/zsh-autocomplete /home/test/.antigen/bundles/chrissicool/zsh-256color /home/test/.antigen/bundles/RobSis/zsh-completion-generator /home/test/.antigen/bundles/rickardcarlsson/colorize /home/test/.antigen/bundles/djui/alias-tips /home/test/.antigen/bundles/geometry-zsh/geometry) path+=(/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib /home/test/.antigen/bundles/zsh-users/zsh-completions /home/test/.antigen/bundles/zsh-users/zsh-syntax-highlighting /home/test/.antigen/bundles/zsh-users/zsh-autosuggestions /home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found /home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract /home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm /home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip /home/test/.antigen/bundles/marlonrichert/zsh-autocomplete /home/test/.antigen/bundles/chrissicool/zsh-256color /home/test/.antigen/bundles/RobSis/zsh-completion-generator /home/test/.antigen/bundles/rickardcarlsson/colorize /home/test/.antigen/bundles/djui/alias-tips /home/test/.antigen/bundles/geometry-zsh/geometry)
_antigen_compinit () {
  autoload -Uz compinit; compinit -i -d "/home/test/.antigen/.zcompdump"; compdef _antigen antigen
  add-zsh-hook -D precmd _antigen_compinit
}
autoload -Uz add-zsh-hook; add-zsh-hook precmd _antigen_compinit
compdef () {}

if [[ -n "/home/test/.antigen/bundles/robbyrussell/oh-my-zsh" ]]; then
  ZSH="/home/test/.antigen/bundles/robbyrussell/oh-my-zsh"; ZSH_CACHE_DIR="/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/cache/"
fi
#--- BUNDLES BEGIN
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/bzr.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/clipboard.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/cli.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/compfix.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/completion.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/correction.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/diagnostics.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/directories.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/functions.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/git.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/grep.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/history.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/key-bindings.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/misc.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/nvm.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/prompt_info_functions.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/spectrum.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/termsupport.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/theme-and-appearance.zsh';
source '/home/test/.antigen/bundles/zsh-users/zsh-completions/zsh-completions.plugin.zsh';
source '/home/test/.antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh';
source '/home/test/.antigen/bundles/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract/extract.plugin.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm/npm.plugin.zsh';
source '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip/pip.plugin.zsh';
source '/home/test/.antigen/bundles/marlonrichert/zsh-autocomplete/zsh-autocomplete.plugin.zsh';
source '/home/test/.antigen/bundles/chrissicool/zsh-256color/zsh-256color.plugin.zsh';
source '/home/test/.antigen/bundles/RobSis/zsh-completion-generator/zsh-completion-generator.plugin.zsh';
source '/home/test/.antigen/bundles/rickardcarlsson/colorize/colorize.plugin.zsh';
source '/home/test/.antigen/bundles/djui/alias-tips/alias-tips.plugin.zsh';
source '/home/test/.antigen/bundles/geometry-zsh/geometry/geometry.zsh';

#--- BUNDLES END
typeset -gaU _ANTIGEN_BUNDLE_RECORD; _ANTIGEN_BUNDLE_RECORD=('https://github.com/robbyrussell/oh-my-zsh.git lib plugin true' 'https://github.com/zsh-users/zsh-completions.git / plugin true' 'https://github.com/zsh-users/zsh-syntax-highlighting.git / plugin true' 'https://github.com/zsh-users/zsh-autosuggestions.git / plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/command-not-found plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/extract plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/npm plugin true' 'https://github.com/robbyrussell/oh-my-zsh.git plugins/pip plugin true' 'https://github.com/marlonrichert/zsh-autocomplete.git / plugin true' 'https://github.com/chrissicool/zsh-256color.git / plugin true' 'https://github.com/RobSis/zsh-completion-generator.git / plugin true' 'https://github.com/rickardcarlsson/colorize.git / plugin true' 'https://github.com/djui/alias-tips.git / plugin true' 'https://github.com/geometry-zsh/geometry.git / theme true')
typeset -g _ANTIGEN_CACHE_LOADED; _ANTIGEN_CACHE_LOADED=true
typeset -ga _ZCACHE_BUNDLE_SOURCE; _ZCACHE_BUNDLE_SOURCE=('/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/bzr.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/clipboard.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/cli.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/compfix.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/completion.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/correction.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/diagnostics.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/directories.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/functions.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/git.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/grep.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/history.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/key-bindings.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/misc.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/nvm.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/prompt_info_functions.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/spectrum.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/termsupport.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/lib/theme-and-appearance.zsh' '/home/test/.antigen/bundles/zsh-users/zsh-completions//' '/home/test/.antigen/bundles/zsh-users/zsh-completions///zsh-completions.plugin.zsh' '/home/test/.antigen/bundles/zsh-users/zsh-syntax-highlighting//' '/home/test/.antigen/bundles/zsh-users/zsh-syntax-highlighting///zsh-syntax-highlighting.plugin.zsh' '/home/test/.antigen/bundles/zsh-users/zsh-autosuggestions//' '/home/test/.antigen/bundles/zsh-users/zsh-autosuggestions///zsh-autosuggestions.plugin.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/command-not-found/command-not-found.plugin.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/extract/extract.plugin.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/npm/npm.plugin.zsh' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip' '/home/test/.antigen/bundles/robbyrussell/oh-my-zsh/plugins/pip/pip.plugin.zsh' '/home/test/.antigen/bundles/marlonrichert/zsh-autocomplete//' '/home/test/.antigen/bundles/marlonrichert/zsh-autocomplete///zsh-autocomplete.plugin.zsh' '/home/test/.antigen/bundles/chrissicool/zsh-256color//' '/home/test/.antigen/bundles/chrissicool/zsh-256color///zsh-256color.plugin.zsh' '/home/test/.antigen/bundles/RobSis/zsh-completion-generator//' '/home/test/.antigen/bundles/RobSis/zsh-completion-generator///zsh-completion-generator.plugin.zsh' '/home/test/.antigen/bundles/rickardcarlsson/colorize//' '/home/test/.antigen/bundles/rickardcarlsson/colorize///colorize.plugin.zsh' '/home/test/.antigen/bundles/djui/alias-tips//' '/home/test/.antigen/bundles/djui/alias-tips///alias-tips.plugin.zsh' '/home/test/.antigen/bundles/geometry-zsh/geometry//' '/home/test/.antigen/bundles/geometry-zsh/geometry///geometry.zsh-theme')
typeset -g _ANTIGEN_CACHE_VERSION; _ANTIGEN_CACHE_VERSION='develop'

#-- END ZCACHE GENERATED FILE
