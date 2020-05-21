$ProfileDirectory = Split-Path -Path $Profile -Parent;
$AliasModule = Join-Path -Path $ProfileDirectory -ChildPath "aliases.psm1";

$Modules = @(
	$AliasModule,
	"posh-git"
);

foreach($Module in $Modules) {
	Import-Module -Name $Module -Force;
}
