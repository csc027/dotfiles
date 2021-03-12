[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidGlobalVars', '', Justification = 'This script requires the use of global variables.')]
param(
)

$ProfileDirectory = Split-Path -Path $PROFILE -Parent;

$SolarizedDefaultFile = switch ($Host.UI.RawUI.BackgroundColor.ToString()) {
	'White' { 'Set-SolarizedLightColorDefaults.ps1' }
	'Black' { 'Set-SolarizedDarkColorDefaults.ps1' }
	default { 'Set-SolarizedDarkColorDefaults.ps1' }
};

$SolarizedDefaultPath = Join-Path -Path $ProfileDirectory -ChildPath $SolarizedDefaultFile;
if ((Test-Path -Path $SolarizedDefaultPath) -and -not (Test-Path -Path 'Env:\WT_SESSION')) {
	. $SolarizedDefaultPath;
}

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

if ((Get-Command -Name 'Get-PsReadLineOption' -ErrorAction SilentlyContinue) -and (Get-PsReadLineOption | Select-Object -ExpandProperty EditMode)) {
	Set-PsReadLineOption -EditMode 'Windows';
}

if (Get-Command -Name 'Update-DirColors' -ErrorAction SilentlyContinue) {
	Update-DirColors -Path (Join-Path -Path $HOME -ChildPath '.dircolors');
}

if ($global:GitPromptSettings) {
	$global:GitPromptSettings.DefaultPromptPath.ForegroundColor = [ConsoleColor]::Blue;
	$global:GitPromptSettings.DefaultPromptPrefix = (Write-Prompt -ForegroundColor [ConsoleColor]::Green -Object "$env:USERNAME@$env:COMPUTERNAME") + ':';
	if ($global:GitPromptSettings.DefaultPromptAbbreviateGitDirectory) {
		$global:GitPromptSettings.DefaultPromptAbbreviateGitDirectory = $false;
	}
}

$DotSourceNames = @('machine.ps1', 'os.ps1');
foreach ($DotSourceName in $DotSourceNames) {
	$DotSourcePath = Join-Path -Path $ProfileDirectory -ChildPath $DotSourceName;
	if (Test-Path -Path $DotSourcePath) {
		. $DotSourcePath;
	}
}
