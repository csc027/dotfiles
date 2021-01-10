function Invoke-GitAdd { git add $args }
function Invoke-GitAddChunk { git add -p $args }
function Invoke-GitBranch { git branch $args }
function Invoke-GitBranchAll { git branch -a $args }
function Invoke-GitBranchAllVerbose { git branch -avv $args }
function Invoke-GitBranchDelete { git branch -d $args }
function Invoke-GitBranchVerbose { git branch -vv $args }
function Invoke-GitCheckout { git checkout $args }
function Invoke-GitCheckoutBranch { git checkout -b $args }
function Invoke-GitCherryPick { git cherry-pick $args }
function Invoke-GitCommit { git commit -m $args }
function Invoke-GitDiff { git diff $args }
function Invoke-GitDiffCached { git diff --cached $args }
function Invoke-GitDiffNameOnly { git diff --name-only $args }
function Invoke-GitDiffTool { git difftool $args }
function Invoke-GitFetch { git fetch $args }
function Invoke-GitFetchAll { git fetch --all $args }
function Invoke-GitFetchPrune { git fetch --prune $args }
function Invoke-GitFetchAllPrune { git fetch --all --prune $args }
function Invoke-GitGrep { git grep $args }
function Invoke-GitInit { git init $args }
function Invoke-GitLog { git log --decorate --oneline --graph --color $args }
function Invoke-GitLogDiff { git log --decorate --oneline --graph --color --boundary $args }
function Invoke-GitLogDiffLong { git log --decorate --graph --color --boundary $args }
function Invoke-GitLogLong { git log --decorate --graph --color $args }
function Invoke-GitListTree { git ls-tree --name-only -r $args }
function Invoke-GitMerge { git merge $args }
function Invoke-GitMv { git mv $args }
function Invoke-GitPull { git pull $args }
function Invoke-GitPush { git push $args }
function Invoke-GitPushSetUpstream { git push -u $args }
function Invoke-GitRebase { git rebase $args }
function Invoke-GitRebaseInteractive { git rebase --interactive $args }
function Invoke-GitRemote { git remote -v $args }
function Invoke-GitRemoteAdd { git remote add $args }
function Invoke-GitReset { git reset $args }
function Invoke-GitShow { git show $args }
function Invoke-GitStash { git stash $args }
function Invoke-GitStashApply { git stash apply $args }
function Invoke-GitStashList { git stash list $args }
function Invoke-GitStashPop { git stash pop $args }
function Invoke-GitStashShow { git stash show -p $args }
function Invoke-GitStashShowNameOnly { git stash show $args }
function Invoke-GitStatus { git status $args }
function Invoke-GitTag { git tag $args }

$Aliases = @{
	'ga' = 'Invoke-GitAdd';
	'gap' = 'Invoke-GitAddChunk';
	'gb' = 'Invoke-GitBranch';
	'gba' = 'Invoke-GitBranchAll';
	'gbav' = 'Invoke-GitBranchAllVerbose';
	'gbd' = 'Invoke-GitBranchDelete';
	'gbv' = 'Invoke-GitBranchVerbose';
	'gk' = 'Invoke-GitCheckout';
	'gkb' = 'Invoke-GitCheckoutBranch';
	'gq' = 'Invoke-GitCherryPick';
	'gc' = 'Invoke-GitCommit';
	'gd' = 'Invoke-GitDiff';
	'gdc' = 'Invoke-GitDiffCached';
	'gdn' = 'Invoke-GitDiffNameOnly';
	'gdt' = 'Invoke-GitDiffTool';
	'gf' = 'Invoke-GitFetch';
	'gfa' = 'Invoke-GitFetchAll';
	'gfp' = 'Invoke-GitFetchPrune';
	'gfap' = 'Invoke-GitFetchAllPrune';
	'gg' = 'Invoke-GitGrep';
	'gi' = 'Invoke-GitInit';
	'gl' = 'Invoke-GitLog';
	'gld' = 'Invoke-GitLogDiff';
	'gldl' = 'Invoke-GitLogDiffLong';
	'gll' = 'Invoke-GitLogLong';
	'gls' = 'Invoke-GitListTree';
	'gmg' = 'Invoke-GitMerge';
	'gv' = 'Invoke-GitMv';
	'gu' = 'Invoke-GitPull';
	'gp' = 'Invoke-GitPush';
	'gpu' = 'Invoke-GitPushSetUpstream';
	'ge' = 'Invoke-GitRebase';
	'gei' = 'Invoke-GitRebaseInteractive';
	'go' = 'Invoke-GitRemote';
	'goa' = 'Invoke-GitRemoteAdd';
	'gr' = 'Invoke-GitReset';
	'gw' = 'Invoke-GitShow';
	'gh' = 'Invoke-GitStash';
	'gha' = 'Invoke-GitStashApply';
	'ghl' = 'Invoke-GitStashList';
	'ghp' = 'Invoke-GitStashPop';
	'ghw' = 'Invoke-GitStashShow';
	'ghwn' = 'Invoke-GitStashShowNameOnly';
	'gs' = 'Invoke-GitStatus';
	'gt' = 'Invoke-GitTag';
};

foreach ($Key in $Aliases.Keys) {
	while (Test-Path -Path "Alias:\$Key") {
		Remove-Item -Path "Alias:\$Key" -Force;
	}
	Set-Alias -Name $Key -Value ($Aliases.$Key);
}

Export-ModuleMember -Function * -Alias *;
