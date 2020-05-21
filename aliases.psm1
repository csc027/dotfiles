function Invoke-GitAdd { git add $args }
function Invoke-GitBranch { git branch $args }
function Invoke-GitCheckout { git checkout $args }
function Invoke-GitCherryPick { git cherry-pick $args }
function Invoke-GitCommit { git commit -m $args }
function Invoke-GitDiff { git diff $args }
function Invoke-GitFetch { git fetch $args }
function Invoke-GitGrep { git grep $args }
function Invoke-GitInit { git init $args }
function Invoke-GitLog { git log --decorate --oneline --graph --color $args }
function Invoke-GitMerge { git merge $args }
function Invoke-GitMv { git mv $args }
function Invoke-GitPull { git pull $args }
function Invoke-GitPush { git pull $args }
function Invoke-GitRebase { git rebase $args }
function Invoke-GitRemote { git remote $args }
function Invoke-GitShow { git show $args }
function Invoke-GitStash { git stash $args }
function Invoke-GitStatus { git status $args }
function Invoke-GitTag { git tag $args }

$Aliases = @{
	"ga" = "Invoke-GitAdd";
	"gb" = "Invoke-GitBranch";
	"gk" = "Invoke-GitCheckout";
	"gq" = "Invoke-GitCherryPick";
	"gc" = "Invoke-GitCommit";
	"gd" = "Invoke-GitDiff";
	"gf" = "Invoke-GitFetch";
	"gg" = "Invoke-GitGrep";
	"gi" = "Invoke-GitInit";
	"gl" = "Invoke-GitLog";
	"gm" = "Invoke-GitMerge";
	"gv" = "Invoke-GitMv";
	"gu" = "Invoke-GitPull";
	"gp" = "Invoke-GitPush";
	"ge" = "Invoke-GitRebase";
	"go" = "Invoke-GitRemote";
	"gw" = "Invoke-GitShow";
	"gh" = "Invoke-GitStash";
	"gs" = "Invoke-GitStatus";
	"gt" = "Invoke-GitTag";
};

foreach($Key in $Aliases.Keys) {
	while(Test-Path -Path "Alias:$Key") {
		Remove-Item -Path "Alias:$Key" -Force;
	}
	Set-Alias -Name $Key -Value ($Aliases.$Key);
}

Export-ModuleMember -Function * -Alias *;
