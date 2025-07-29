export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
	--multi
	--preview 'cat {}'
	--bind 'ctrl-e:become(nvim {})'
	--style full
	--list-label ' Search '
	--input-label ' Input '
	--preview-label ' Preview '
	--color 'preview-border:#d26aff,preview-label:#d26aff'
	--color 'list-border:#91b362,list-label:#91b362'
	--color 'input-border:#ea6373,input-label:#ea6373'
"
