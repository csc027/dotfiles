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

if ((Get-Command -Name 'Get-PSReadLineOption' -ErrorAction SilentlyContinue) -and (Get-PSReadLineOption | Select-Object -ExpandProperty EditMode)) {
	Set-PSReadLineOption -EditMode 'Windows';
}

if (Get-Command -Name 'Update-DirColors' -ErrorAction SilentlyContinue) {
	Update-DirColors -Path (Join-Path -Path $HOME -ChildPath '.dircolors');
}

if ($global:GitPromptSettings) {
	$global:GitPromptSettings.BeforePath = ':';
	$global:GitPromptSettings.DefaultPromptSuffix = ' $ ';
	if ($global:GitPromptSettings.DefaultPromptPath.PSObject.Properties.Name -contains 'ForegroundColor') {
		$global:GitPromptSettings.DefaultPromptPath.ForegroundColor = [ConsoleColor]::Blue;
	}
	if ($global:GitPromptSettings.PSObject.Properties.Name -contains 'DefaultPromptPrefix') {
		$global:GitPromptSettings.DefaultPromptPrefix = if ($IsLinux) {
			"$env:USERNAME@$(hostname)";
		} else {
			"$env:USERNAME@$env:COMPUTERNAME";
		}
		if ($global:GitPromptSettings.DefaultPromptPrefix.PSObject.Properties.Name -contains 'ForegroundColor') {
			$global:GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green;
		}
	}
	if ($global:GitPromptSettings.PSObject.Properties.Name -contains 'BeforePath') {
		$global:GitPromptSettings.BeforePath = ':';
	}
	if ($global:GitPromptSettings.PSObject.Properties.Name -contains 'DefaultPromptSuffix') {
		$global:GitPromptSettings.DefaultPromptSuffix = ' $ ';
	}
	if ($global:GitPromptSettings.PSObject.Properties.Name -contains 'DefaultPromptAbbreviateHomeDirectory') {
		$global:GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true;
	}
	if ($global:GitPromptSettings.PSObject.Properties.Name -contains 'DefaultPromptAbbreviateGitDirectory') {
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
