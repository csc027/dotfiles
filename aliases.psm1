function Invoke-GitAdd { git add $args }
function Invoke-GitAddChunk { git add -p $args }
function Invoke-GitBranch { git branch $args }
function Invoke-GitBranchAll { git branch -a $args }
function Invoke-GitBranchDelete { git branch -d $args }
function Invoke-GitCheckout { git checkout $args }
function Invoke-GitCheckoutBranch { git checkout -b $args }
function Invoke-GitCherryPick { git cherry-pick $args }
function Invoke-GitCommit { git commit -m $args }
function Invoke-GitDiff { git diff $args }
function Invoke-GitDiffCached { git diff --cached $args }
function Invoke-GitDiffNameOnly { git diff --name-only $args }
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
function Invoke-GitMerge { git merge $args }
function Invoke-GitMv { git mv $args }
function Invoke-GitPull { git pull $args }
function Invoke-GitPush { git push $args }
function Invoke-GitPushSetUpstream { git push -u $args }
function Invoke-GitRebase { git rebase $args }
function Invoke-GitRebaseInteractive { git rebase --interactive $args }
function Invoke-GitRemote { git remote -v $args }
function Invoke-GitReset { git reset $args }
function Invoke-GitShow { git show $args }
function Invoke-GitStash { git stash $args }
function Invoke-GitStashApply { git stash apply $args }
function Invoke-GitStashList { git stash list $args }
function Invoke-GitStashPop { git stash pop $args }
function Invoke-GitStatus { git status $args }
function Invoke-GitTag { git tag $args }

$Aliases = @{
	"ga"   = (Get-Command -Name "Invoke-GitAdd");
	"gap"  = (Get-Command -Name "Invoke-GitAddChunk");
	"gb"   = (Get-Command -Name "Invoke-GitBranch");
	"gba"  = (Get-Command -Name "Invoke-GitBranchAll");
	"gbd"  = (Get-Command -Name "Invoke-GitBranchDelete");
	"gk"   = (Get-Command -Name "Invoke-GitCheckout");
	"gkb"  = (Get-Command -Name "Invoke-GitCheckoutBranch");
	"gq"   = (Get-Command -Name "Invoke-GitCherryPick");
	"gc"   = (Get-Command -Name "Invoke-GitCommit");
	"gd"   = (Get-Command -Name "Invoke-GitDiff");
	"gdc"  = (Get-Command -Name "Invoke-GitDiffCached");
	"gdn"  = (Get-Command -Name "Invoke-GitDiffNameOnly");
	"gf"   = (Get-Command -Name "Invoke-GitFetch");
	"gfa"  = (Get-Command -Name "Invoke-GitFetchAll");
	"gfp"  = (Get-Command -Name "Invoke-GitFetchPrune");
	"gfap" = (Get-Command -Name "Invoke-GitFetchAllPrune");
	"gg"   = (Get-Command -Name "Invoke-GitGrep");
	"gi"   = (Get-Command -Name "Invoke-GitInit");
	"gl"   = (Get-Command -Name "Invoke-GitLog");
	"gld"  = (Get-Command -Name "Invoke-GitLogDiff");
	"gldl" = (Get-Command -Name "Invoke-GitLogDiffLong");
	"gll"  = (Get-Command -Name "Invoke-GitLogLong");
	"gmg"  = (Get-Command -Name "Invoke-GitMerge");
	"gv"   = (Get-Command -Name "Invoke-GitMv");
	"gu"   = (Get-Command -Name "Invoke-GitPull");
	"gp"   = (Get-Command -Name "Invoke-GitPush");
	"gpu"  = (Get-Command -Name "Invoke-GitPushSetUpstream");
	"ge"   = (Get-Command -Name "Invoke-GitRebase");
	"gei"  = (Get-Command -Name "Invoke-GitRebaseInteractive");
	"go"   = (Get-Command -Name "Invoke-GitRemote");
	"gr"   = (Get-Command -Name "Invoke-GitReset");
	"gw"   = (Get-Command -Name "Invoke-GitShow");
	"gh"   = (Get-Command -Name "Invoke-GitStash");
	"gha"  = (Get-Command -Name "Invoke-GitStashApply");
	"ghl"  = (Get-Command -Name "Invoke-GitStashList");
	"ghp"  = (Get-Command -Name "Invoke-GitStashPop");
	"gs"   = (Get-Command -Name "Invoke-GitStatus");
	"gt"   = (Get-Command -Name "Invoke-GitTag");
};

foreach($Key in $Aliases.Keys) {
	while(Test-Path -Path "Alias:\$Key") {
		Remove-Item -Path "Alias:\$Key" -Force;
	}
	Set-Alias -Name $Key -Value ($Aliases.$Key);
}

Export-ModuleMember -Function * -Alias *;
