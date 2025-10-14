function Invoke-FzfFileNameSearch {
	fzf.exe `
		--multi `
		--preview 'type {}' `
		--height=50% `
		--layout=reverse `
		--style full `
		--list-label ' Search ' `
		--input-label ' Input ' `
		--preview-label ' Preview ' `
		--color 'preview-border:#d2a6ff,preview-label:#d2a6ff' `
		--color 'list-border:#91b362,list-label:#91b362' `
		--color 'input-border:#ea6c73,input-label:#ea6c73' `
		--bind 'ctrl-e:become(nvim {+})' `
		$args
	;
}
function Invoke-FzfFileSearch {
	fzf.exe `
		--ansi `
		--delimiter ':' `
		--height=50% `
		--layout=reverse `
		--multi `
		--bind 'start:reload:rg.exe --column --line-number --no-heading --color=always --smart-case .' `
		--bind 'enter:become(nvim {1} +{2})' `
		$args
	;
}
function Invoke-FzfRegexFileSearch {
	$RipGrep = 'rg.exe --column --line-number --no-heading --color=always --smart-case ';
	fzf.exe `
		--ansi `
		--delimiter ':' `
		--disabled `
		--height=50% `
		--layout=reverse `
		--multi `
		--query "${*:-}" `
		--bind "start:reload:$RipGrep {q}" `
		--bind "change:reload:$RipGrep {q} || true" `
		--bind 'enter:become(nvim {1} +{2})' `
		$args
	;
}
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
function Invoke-GitCommit { git commit --message $args }
function Invoke-GitCommitAmend { git commit --amend --message $args }
function Invoke-GitDiff { git diff $args }
function Invoke-GitDiffWhitespace { git diff --ignore-all-space $args }
function Invoke-GitDiffCached { git diff --cached $args }
function Invoke-GitDiffCachedWhitespace { git diff --ignore-all-space --cached $args }
function Invoke-GitDiffNameOnly { git diff --name-only $args }
function Invoke-GitDiffNameOnlyWhitespace { git diff --ignore-all-space --name-only $args }
function Invoke-GitDiffNameStatus { git diff --name-status $args }
function Invoke-GitDiffNameStatusWhitespace { git diff --ignore-all-space --name-status $args }
function Invoke-GitDiffTool { git difftool $args }
function Invoke-GitFetch { git fetch $args }
function Invoke-GitFetchAll { git fetch --all $args }
function Invoke-GitFetchAllPrune { git fetch --all --prune $args }
function Invoke-GitFetchPrune { git fetch --prune $args }
function Invoke-GitFetchTags { git fetch --tags $args }
function Invoke-GitGrep { git grep $args }
function Invoke-GitInit { git init $args }
function Invoke-GitListTree { git ls-tree --name-only -r $args }
function Invoke-GitLog { git log --all --decorate --oneline --graph --color $args }
function Invoke-GitLogDiff { git log --all --decorate --oneline --graph --color --boundary $args }
function Invoke-GitLogDiffLong { git log --all --decorate --graph --color --boundary $args }
function Invoke-GitLogFormat { git log --all --graph --abbrev-commit --format=format:'%C(auto)%>|(26)%h%C(reset) %C(cyan)%an%C(reset)%C(auto)%d%C(reset) %C(white)%s%C(reset) - %C(dim white)%ar%C(reset)' $args }
function Invoke-GitLogLongFormat { git log --all --graph --abbrev-commit --date=format:'%a %b %d, %Y %I:%M %p' --format=format:'%C(auto)%>|(26)%h%C(reset)  %C(magenta)%ad%C(reset)  %C(cyan)%an <%ae>%C(reset) %C(auto)%d%C(reset)%n %C(dim white)%>|(28)%C(reset)- %C(white)%s%C(reset)%n' $args }
function Invoke-GitLogLong { git log --all --decorate --graph --color $args }
function Invoke-GitLogLongPatch { git log --all --decorate --graph --color -p $args }
function Invoke-GitLogLongPatchFollow { git log --decorate --graph --color -p --follow -- $args }
function Invoke-GitLogPatch { git log --all --decorate --oneline --graph --color -p $args }
function Invoke-GitLogPatchFollow { git log --decorate --oneline --graph --color -p --follow -- $args }
function Invoke-GitLogRegularExpression { git log --decorate --color -G $args }
function Invoke-GitLogSearch { git log --decorate --color -S $args }
function Invoke-GitMerge { git merge $args }
function Invoke-GitMergeTool { git mergetool $args }
function Invoke-GitMv { git mv $args }
function Invoke-GitPull { git pull $args }
function Invoke-GitPush { git push $args }
function Invoke-GitPushSetUpstream { git push -u $args }
function Invoke-GitPushTags { git push --tags $args }
function Invoke-GitRebase { git rebase $args }
function Invoke-GitRebaseInteractive { git rebase --interactive $args }
function Invoke-GitRemote { git remote -v $args }
function Invoke-GitRemoteAdd { git remote add $args }
function Invoke-GitReset { git reset $args }
function Invoke-GitShow { git show $args }
function Invoke-GitShowUpstreamBranches { git for-each-ref --format='%(refname:short) <- %(upstream:short)' refs/heads $args }
function Invoke-GitStashApply { git stash apply $args }
function Invoke-GitStashList { git stash list $args }
function Invoke-GitStashPop { git stash pop $args }
function Invoke-GitStashPush { git stash push $args }
function Invoke-GitStashShow { git stash show -p $args }
function Invoke-GitStashShowNameOnly { git stash show $args }
function Invoke-GitStashUntracked { git stash -u $args }
function Invoke-GitStatus { git status $args }
function Invoke-GitTag { git tag $args }
<#
.DESCRIPTION
Repeats the supplied command until dismissed with a keyboard interrupt, or the process is killed.
.PARAMETER Interval
The number of seconds between command invocations.
.PARAMETER Command
The command to be repeated, represented as a [SwitchBlock].
.PARAMETER NoTitle
An indication that the command definition and interval should not be printed to the console.
#>
function Invoke-RepeatCommand {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $false, Position = 0)]
		[Alias('n')]
		[double] $Interval = 2.0,

		[Parameter(Mandatory = $true, Position = 1)]
		[ScriptBlock] $Command,

		[Parameter(Mandatory = $false)]
		[Alias('t')]
		[switch] $NoTitle
	)

	end {
		while ($true) {
			Clear-Host;
			if (-not $NoTitle) {
				Write-Host "Every $Interval seconds: $($Command.ToString())";
			}
			& $Command;
			Start-Sleep -Seconds $Interval;
		}
	}
}

function Invoke-Neovim {
	$MultislotArgument = @('--startuptime', '-c', '--cmd', '-S', '-l', '-ll', '-u', '-i', '-s', '-w', '-w', '-W', '--listen');
	$ArgumentList = @();
	for ($i = 0; $i -lt $args.Count; $i++) {
		if ($args[$i] -is [string]) {
			if ($args[$i] -in $MultislotArgument) {
				# Skip the next argument if this flag is a multislot argument
				$ArgumentList += @($args[$i++]) + @($args[$i]);
			} elseif (
				$args[$i] -notlike '-*' -and
				$args[$i] -notlike '+*' -and (
					$args[$i] -like '*`**' -or
					$args[$i] -like '~*'
				)
			) {
				# If a glob/tilde is detected, wrap the glob/tilde value with a
				# :next command execution and prepend spaces with a backslash
				$ArgumentList += @("+n $($args[$i] -replace ' ', '\ ')");
			} else {
				$ArgumentList += @($args[$i]);
			}
		} elseif ($args[$i] -is [Array]) {
			$ArgumentList += @($args[$i]);
		} else {
			$ArgumentList += @($args[$i]);
		}
	}

	if ($input) {
		$input | nvim.exe $ArgumentList;
	} else {
		nvim.exe $ArgumentList;
	}
}

$Aliases = @{
	'fns' = 'Invoke-FzfFileNameSearch';
	'fs' = 'Invoke-FzfFileSearch';
	'ga' = 'Invoke-GitAdd';
	'gap' = 'Invoke-GitAddChunk';
	'gba' = 'Invoke-GitBranchAll';
	'gbav' = 'Invoke-GitBranchAllVerbose';
	'gbd' = 'Invoke-GitBranchDelete';
	'gb' = 'Invoke-GitBranch';
	'gbv' = 'Invoke-GitBranchVerbose';
	'gca' = 'Invoke-GitCommitAmend';
	'gc' = 'Invoke-GitCommit';
	'gdc' = 'Invoke-GitDiffCached';
	'gdcw' = 'Invoke-GitDiffCachedWhitespace';
	'gd' = 'Invoke-GitDiff';
	'gdn' = 'Invoke-GitDiffNameOnly';
	'gdnw' = 'Invoke-GitDiffNameOnlyWhitespace';
	'gds' = 'Invoke-GitDiffNameStatus';
	'gdsw' = 'Invoke-GitDiffNameStatusWhitespace';
	'gdt' = 'Invoke-GitDiffTool';
	'gdw' = 'Invoke-GitDiffWhitespace';
	'gei' = 'Invoke-GitRebaseInteractive';
	'ge' = 'Invoke-GitRebase';
	'gfa' = 'Invoke-GitFetchAll';
	'gfap' = 'Invoke-GitFetchAllPrune';
	'gf' = 'Invoke-GitFetch';
	'gfp' = 'Invoke-GitFetchPrune';
	'gft' = 'Invoke-GitFetchTags';
	'gg' = 'Invoke-GitGrep';
	'gha' = 'Invoke-GitStashApply';
	'ghl' = 'Invoke-GitStashList';
	'gho' = 'Invoke-GitStashPop';
	'ghp' = 'Invoke-GitStashPush';
	'ghu' = 'Invoke-GitStashUntracked';
	'ghw' = 'Invoke-GitStashShow';
	'ghwn' = 'Invoke-GitStashShowNameOnly';
	'gi' = 'Invoke-GitInit';
	'gkb' = 'Invoke-GitCheckoutBranch';
	'gk' = 'Invoke-GitCheckout';
	'gld' = 'Invoke-GitLogDiff';
	'gldl' = 'Invoke-GitLogDiffLong';
	'gl' = 'Invoke-GitLog';
	'glf' = 'Invoke-GitLogFormat';
	'gll' = 'Invoke-GitLogLong';
	'gllf' = 'Invoke-GitLogLongFormat';
	'gllpf' = 'Invoke-GitLogLongPatchFollow';
	'gllp' = 'Invoke-GitLogLongPatch';
	'glpf' = 'Invoke-GitLogPatchFollow';
	'glp' = 'Invoke-GitLogPatch';
	'glr' = 'Invoke-GitLogRegularExpression';
	'gls' = 'Invoke-GitLogSearch';
	'glt' = 'Invoke-GitListTree';
	'gmg' = 'Invoke-GitMerge';
	'gmt' = 'Invoke-GitMergeTool';
	'goa' = 'Invoke-GitRemoteAdd';
	'go' = 'Invoke-GitRemote';
	'gp' = 'Invoke-GitPush';
	'gpt' = 'Invoke-GitPushTags';
	'gpu' = 'Invoke-GitPushSetUpstream';
	'gq' = 'Invoke-GitCherryPick';
	'gr' = 'Invoke-GitReset';
	'gs' = 'Invoke-GitStatus';
	'gt' = 'Invoke-GitTag';
	'gu' = 'Invoke-GitPull';
	'gv' = 'Invoke-GitMv';
	'gw' = 'Invoke-GitShow';
	'gwu' = 'Invoke-GitShowUpstreamBranches';
	'nvim' = 'Invoke-Neovim';
	'rfs' = 'Invoke-FzfRegexFileSearch';
	'watch' = 'Invoke-RepeatCommand';
};

foreach ($Key in $Aliases.Keys) {
	while (Test-Path -Path "Alias:\$Key") {
		Remove-Item -Path "Alias:\$Key" -Force;
	}
	Set-Alias -Name $Key -Value ($Aliases.$Key);
}

Export-ModuleMember -Function * -Alias *;
