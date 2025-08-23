[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidGlobalVars', '', Justification = 'This script requires the use of global variables.')]
param(
)

$ProfileDirectory = Split-Path -Path $PROFILE -Parent;

$Modules = @(
	@{
		'Name' = Join-Path -Path $HOME -ChildPath '.aliases.psm1';
		'ArgumentList' = @();
		'Force' = $true
	}, @{
		'Name' = 'posh-git';
		'ArgumentList' = @($false, $false, $true);
		'Force' = $true
	}
);

if ($Host.UI.SupportsVirtualTerminal) {
	$Modules += @(
		@{
			'Name' = 'DirColors';
			'ArgumentList' = @();
			'Force' = $true
		}
	);
}

foreach ($Module in $Modules) {
	Import-Module @Module;
}

if ((Get-Command -Name 'Get-PSReadLineOption' -ErrorAction SilentlyContinue) -and (Get-PSReadLineOption | Select-Object -ExpandProperty EditMode)) {
	Set-PSReadLineOption -EditMode 'Windows';
}

if (Get-Command -Name 'Update-DirColors' -ErrorAction SilentlyContinue) {
	Update-DirColors -Path (Join-Path -Path $HOME -ChildPath '.dircolors');
}

if (Get-Command -Name 'oh-my-posh' -ErrorAction SilentlyContinue) {
	oh-my-posh.exe init pwsh | Invoke-Expression;
} else {
	if ($env:WT_SESSION) {
		$script:RightSeparator = ' ❭ ';
		$script:LeftSeparator = ' ❬ ';
	} else {
		$script:RightSeparator = ' > ';
		$script:LeftSeparator = ' < ';
	}

	function prompt {
		$LastCommandState = $global:?;

		Write-Host -Object '┌ ' -ForegroundColor 'Gray' -NoNewline;
		if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
			Write-Host -Object "Admin$script:RightSeparator" -ForegroundColor 'Red' -NoNewline;
		} elseif ($PSDebugContext) {
			Write-Host -Object "Debug$script:RightSeparator" -ForegroundColor 'Yellow' -NoNewline;
		}

		$Machine = if ($IsLinux) { (hostname); } else { $env:COMPUTERNAME; }
		Write-Host -Object "$Machine$script:RightSeparator" -ForegroundColor 'Magenta' -NoNewline;
		Write-Host -Object "$($env:USERNAME)$script:RightSeparator" -ForegroundColor 'Green' -NoNewline;
		Write-Host -Object "$(Get-PromptPath)$script:RightSeparator" -ForegroundColor 'Blue' -NoNewline;
		if ($global:GitStatus = Get-GitStatus -Force) {
			$BranchColor = Get-GitBranchStatusColor -Status $global:GitStatus;
			Write-Host -Object (Write-GitBranchName -Status $global:GitStatus -NoLeadingSpace) -NoNewline;
			Write-Host -Object $script:RightSeparator -ForegroundColor $BranchColor.ForegroundColor -NoNewline;
			if ($BranchStatus = Write-GitBranchStatus -Status $global:GitStatus -NoLeadingSpace) {
				Write-Host -Object $BranchStatus -NoNewline;
				Write-Host -Object $script:RightSeparator -ForegroundColor $BranchColor.ForegroundColor -NoNewline;
			}
			if ($global:GitStatus.HasIndex) {
				Write-Host -Object (Write-GitIndexStatus -Status $global:GitStatus -NoLeadingSpace) -NoNewline;
				Write-Host -Object $script:RightSeparator -ForegroundColor 'Green' -NoNewline;
			}
			if ($global:GitStatus.HasWorking) {
				Write-Host -Object "$(Write-GitWorkingDirStatus -Status $global:GitStatus -NoLeadingSpace)$(Write-GitWorkingDirStatusSummary -Status $global:GitStatus -NoLeadingSpace)" -NoNewline;
				Write-Host -Object $script:RightSeparator -ForegroundColor 'DarkRed' -NoNewline;
			}
		}

		$RightWidth = if (-not $LastCommandState) { 36; } else { 32; }
		$BlankWidth = $Host.UI.RawUI.WindowSize.Width - $Host.UI.RawUI.CursorPosition.X - $RightWidth;
		if ($BlankWidth -gt 0) {
			Write-Host (' ' * $BlankWidth) -NoNewline;
			if (-not $LastCommandState) {
				Write-Host -Object "$script:LeftSeparator!" -ForegroundColor 'Red' -NoNewline;
			}
			$Date = Get-Date;
			Write-Host -Object "$script:LeftSeparator$(Get-Date -Date $Date -Format 'MM/dd/yyyy')" -ForegroundColor 'DarkYellow' -NoNewline;
			Write-Host -Object "$script:LeftSeparator$(Get-Date -Date $Date -Format 'hh:mm tt')" -ForegroundColor 'DarkMagenta' -NoNewline;
			Write-Host -Object "$script:LeftSeparator$(Get-Date -Date $Date -Format 'ss.ff')" -ForegroundColor 'Gray' -NoNewline;
		}

		Write-Host -Object "`n└─▶" -NoNewline;
		return ' ';
	}

	if ($global:GitPromptSettings) {
		if ($global:GitPromptSettings.PSObject.Properties.Name -contains 'DefaultPromptPrefix') {
			$global:GitPromptSettings.DefaultPromptPrefix = $null;
		}
		if ($global:GitPromptSettings.PSObject.Properties.Name -contains 'BeforePath') {
			$global:GitPromptSettings.BeforePath = $null;
		}
		if ($global:GitPromptSettings.PSObject.Properties.Name -contains 'DefaultBeforeSuffix') {
			$global:GitPromptSettings.DefaultPromptBeforeSuffix = $null;
		}
		if ($global:GitPromptSettings.PSObject.Properties.Name -contains 'DefaultPromptSuffix') {
			$global:GitPromptSettings.DefaultPromptSuffix = $null;
		}
		if ($global:GitPromptSettings.PSObject.Properties.Name -contains 'DefaultPromptAbbreviateHomeDirectory') {
			$global:GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true;
		}
		if ($global:GitPromptSettings.PSObject.Properties.Name -contains 'DefaultPromptAbbreviateGitDirectory') {
			$global:GitPromptSettings.DefaultPromptAbbreviateGitDirectory = $false;
		}
	}
}

$DotSourceNames = @('machine.ps1', 'os.ps1');
foreach ($DotSourceName in $DotSourceNames) {
	$DotSourcePath = Join-Path -Path $ProfileDirectory -ChildPath $DotSourceName;
	if (Test-Path -Path $DotSourcePath) {
		. $DotSourcePath;
	}
}
