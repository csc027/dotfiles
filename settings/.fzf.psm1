$env:FZF_DEFAULT_OPTS = "
	--multi
	--preview 'type {}'
	--bind 'ctrl-e:become(nvim {})'
	--style full
	--list-label ' Search '
	--input-label ' Input '
	--preview-label ' Preview '
	--color=fg:#cbccc6,bg:#1f2430,hl:#707a8c
	--color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66
	--color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
	--color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff
"
