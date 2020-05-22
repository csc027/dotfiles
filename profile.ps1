$ProfileDirectory = Split-Path -Path $Profile -Parent;
$SolarizedDefaultFile = switch($HOST.UI.RawUI.BackgroundColor.ToString()) {
	"White" { "Set-SolarizedLightColorDefaults.ps1" }
	"Black" { "Set-SolarizedDarkColorDefaults.ps1" }
	default { return }
};
$SolarizedDefaultPath = Join-Path -Path $ProfileDirectory -ChildPath $SolarizedDefaultFile
if((Test-Path -Path $SolarizedDefaultPath) -and -not (Get-Item -Path "Env:\WT_SESSION")) {
	. $SolarizedDefaultPath;
}

$AliasModule = Join-Path -Path $ProfileDirectory -ChildPath "aliases.psm1";

$Modules = @(
	$AliasModule,
	"posh-git"
);

foreach($Module in $Modules) {
	Import-Module -Name $Module -Force;
}
