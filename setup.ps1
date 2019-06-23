$Script_Directory = $PsScriptRoot;

if(-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	throw New-Object System.Exception "The setup script requires administrator privileges to run.";
}

$Items = @(
	@{
		"Source" = ".vimrc";
		"Destination" = ".vimrc";
	},
	@{
		"Source" = ".vim";
		"Destination" = "vimfiles";
	}
) | ForEach-Object {
	New-Object -TypeName PsObject -Property $_;
};

foreach($Item in $Items) {
	$Source = Join-Path -Path $Script_Directory -ChildPath $Item.Source;
	$Destination = Join-Path -Path $HOME -ChildPath $Item.Destination;

	Write-Host "Checking if the symlink at '$Destination' exists... " -NoNewLine;
	if(-not (Test-Path -Path $Destination)) {
		Write-Host "done.  The symlink does not exist.";
		Write-Host "Creating a symlink at '$Destination'... " -NoNewLine;
		if(Test-Path -Path $Source -PathType Container) {
			cmd /c mklink /d $Destination $Source | Out-Null;
		} elseif(Test-Path -Path $Source -PathType Leaf) {
			cmd /c mklink $Destination $Source | Out-Null;
		} else {
			throw New-Object System.Exception "The source item $Source does not exist.";
		}
		Write-Host "done";
	} else {
		Write-Host "done.";
		Write-Host "The symlink '$Destination' already exists.";
	}
}
