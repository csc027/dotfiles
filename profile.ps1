$ProfileDirectory = Split-Path -Path $Profile -Parent;
$SolarizedDefaultFile = switch($HOST.UI.RawUI.BackgroundColor.ToString()) {
	"White" { "Set-SolarizedLightColorDefaults.ps1" }
	"Black" { "Set-SolarizedDarkColorDefaults.ps1" }
	default { return }
};
$SolarizedDefaultPath = Join-Path -Path $ProfileDirectory -ChildPath $SolarizedDefaultFile
if((Test-Path -Path $SolarizedDefaultPath) -and -not (Test-Path -Path "Env:\WT_SESSION")) {
	. $SolarizedDefaultPath;
}

$Modules = @(
	@{
		"Name" = Join-Path -Path $HOME -ChildPath ".aliases.psm1";
		"ArgumentList" = @();
		"Force" = $true
	}, @{
		"Name" = "posh-git";
		"ArgumentList" = @(0, 0, 1);
		"Force" = $true
	}
);

foreach($Module in $Modules) {
	Import-Module @Module;
}

if ($global:GitPromptSettings -and $global:GitPromptSettings.DefaultPromptAbbreviateHomeDirectory) {
	$global:GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $false;
}
if ($global:GitPromptSettings -and $global:GitPromptSettings.DefaultPromptAbbreviateGitDirectory) {
	$global:GitPromptSettings.DefaultPromptAbbreviateGitDirectory = $false;
}

$MachineScriptPath = Join-Path -Path $ProfileDirectory -ChildPath "machine.ps1";
if (Test-Path -Path $MachineScriptPath) {
	& $MachineScriptPath;
}
