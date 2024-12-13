alias ga='git add'
alias gap='git add -p'
alias gb='git branch'
alias gba='git branch -a'
alias gbav='git branch -avv'
alias gbd='git branch -d'
alias gbv='git branch -vv'
alias gc='git commit -m'
alias gca='git commit --amend -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdcw='git diff --cached -w'
alias gdn='git diff --name-only'
alias gdnw='git diff --name-only -w'
alias gds='git diff --name-status'
alias gdsw='git diff --name-status -w'
alias gdt='git difftool'
alias ge='git rebase'
alias gei='git rebase --interactive'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gfap='git fetch --all --prune'
alias gfp='git fetch --prune'
alias gft='git fetch --tags'
alias gg='git grep'
alias gha='git stash apply'
alias ghl='git stash list'
alias gho='git stash pop'
alias ghp='git stash'
alias ghw='git stash show -p'
alias ghwn='git stash show'
alias ghu='git stash -u'
alias gi='git init'
alias gk='git checkout'
alias gkb='git checkout -b'
alias gl='git log --decorate --oneline --graph --color'
alias glp='git log --decorate --oneline --graph --color -p'
alias glpf='git log --decorate --oneline --graph --color -p --follow --'
alias gld='git log --decorate --oneline --graph --color --boundary'
alias gldl='git log --decorate --graph --color --boundary'
alias gll='git log --decorate --graph --color'
alias gllp='git log --decorate --graph --color -p'
alias gllpf='git log --decorate --graph --color -p --follow --'
alias glr='git log --decorate --color -G'
alias gls='git log --decorate --color -S'
alias glt='git ls-tree --name-only -r'
alias gmg='git merge'
alias gmt='git mergetool'
alias go='git remote -v'
alias goa='git remote add'
alias gp='git push'
alias gpt='git push --tags'
alias gpu='git push -u'
alias gq='git cherry-pick'
alias gr='git reset'
alias gs='git status'
alias gt='git tag'
alias gu='git pull'
alias gv='git mv'
alias gw='git show'
alias gwu='git for-each-ref --format='\''%(refname:short) <- %(upstream:short)'\'' refs/heads'

__git_complete ga _git_add
__git_complete gap _git_add
__git_complete gb _git_branch
__git_complete gba _git_branch
__git_complete gbav _git_branch
__git_complete gbd _git_branch
__git_complete gbv _git_branch
__git_complete gc _git_commit
__git_complete gca _git_commit
__git_complete gd _git_diff
__git_complete gdc _git_diff
__git_complete gdcw _git_diff
__git_complete gdn _git_diff
__git_complete gdnw _git_diff
__git_complete gds _git_diff
__git_complete gdsw _git_diff
__git_complete gdt _git_difftool
__git_complete ge _git_rebase
__git_complete gei _git_rebase
__git_complete gf _git_fetch
__git_complete gfa _git_fetch
__git_complete gfap _git_fetch
__git_complete gfp _git_fetch
__git_complete gft _git_fetch
__git_complete gg _git_grep
__git_complete gha _git_stash
__git_complete ghl _git_stash
__git_complete gho _git_stash
__git_complete ghp _git_stash
__git_complete ghw _git_stash
__git_complete ghwn _git_stash
__git_complete ghu _git_stash
__git_complete gi _git_init
__git_complete gk _git_checkout
__git_complete gkb _git_checkout
__git_complete gl _git_log
__git_complete gld _git_log
__git_complete gldl _git_log
__git_complete gll _git_log
__git_complete gllp _git_log
__git_complete_index_file gllpf
__git_complete glp _git_log
__git_complete_index_file glpf
__git_complete glr _git_log
__git_complete gls _git_log
__git_complete glt _git_ls_tree
__git_complete gmg _git_merge
__git_complete_index_file gmt
__git_complete go _git_remote
__git_complete goa _git_remote
__git_complete gp _git_push
__git_complete gpt _git_push
__git_complete gpu _git_push
__git_complete gq _git_cherry_pick
__git_complete gr _git_reset
__git_complete gs _git_status
__git_complete gt _git_tag
__git_complete gu _git_pull
__git_complete gv _git_mv
__git_complete gw _git_show
