$env:FZF_DEFAULT_OPTS = "
	--multi
	--preview 'type {}'
	--bind 'ctrl-e:become(nvim {})'
	--style full
	--list-label ' Search '
	--input-label ' Input '
	--preview-label ' Preview '
	--color 'preview-border:#d2a6ff,preview-label:#d2a6ff'
	--color 'list-border:#91b362,list-label:#91b362'
	--color 'input-border:#ea6c73,input-label:#ea6c73'
"
