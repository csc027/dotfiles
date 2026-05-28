function_exists() {
	declare -f -F $1 > /dev/null
	return $?
}

for al in `git --list-cmds=alias`; do
	alias g$al="git $al"
	complete_func=_git_$(__git_aliased_command $al)
	function_exists $complete_func && __git_complete g$al $complete_func
done

alias ta="tmux attach-session"
alias tls="tmux list-sessions"
alias tn="tmux new-session -s"
function fns {
	INITIAL_QUERY="${*:-}";
	fzf \
		--bind 'ctrl-e:become(nvim {+})' \
		--color 'input-border:#ea6c73,input-label:#ea6c73' \
		--color 'list-border:#91b362,list-label:#91b362' \
		--color 'preview-border:#d2a6ff,preview-label:#d2a6ff' \
		--height=70% \
		--input-label ' Input ' \
		--layout=reverse \
		--list-label ' Search ' \
		--multi \
		--preview 'cat {}' \
		--preview-label ' Preview ' \
		--query "$INITIAL_QUERY" \
		--style full
}
function rfs {
	# Clear the contents of the temp files
	rm -f /tmp/rg-fzf-*

	INITIAL_QUERY="${*:-}";
	RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --hidden -e";
	fzf \
		--ansi \
		--bind "start:reload:$RG_PREFIX {q}" \
		--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
		--bind 'ctrl-g:transform:[[ ! $FZF_PROMPT =~ "Rip Grep" ]] && echo "rebind(change)+change-prompt(Rip Grep❯ )+disable-search+transform-query:echo \{q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r" || echo "unbind(change)+change-prompt(Fzf❯ )+enable-search+transform-query:echo \{q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f"' \
		--bind 'enter:become(nvim {+1} +{2})' \
		--delimiter ':' \
		--disabled \
		--header 'Ctrl-G: Switch between RipGrep and Fzf' \
		--multi \
		--preview 'cat {1} '\
		--preview-window 'up,60%,border-bottom,+{2}' \
		--prompt 'Rip Grep❯ ' \
		--query "$INITIAL_QUERY"
}
