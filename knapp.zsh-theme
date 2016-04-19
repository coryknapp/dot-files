function get_pwd() {
  echo "${PWD/$HOME/~}"
}

function show_vim_session() {
	find_vsess=$(find Session.vim -maxdepth 0 2>/dev/null)
	if [ "${find_vsess}" = "Session.vim" ] ; then
		echo "📓 "
	fi
}

local ret_status="%(?:🍹 :💩 %s)"
PROMPT='%{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}$(show_vim_session)${ret_status}%'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}💔 %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
