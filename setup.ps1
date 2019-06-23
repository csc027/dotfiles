$Script_Location = $PsScriptRoot;
$Script_Directory = Split-Path -Path $Script_Location -Parent | Get-Item;

$Symlinks = @(".vimrc", ".vim");

foreach($Symlink in $Symlinks) {
	$Source = Join-Path -Path $Script_Directory -ChildPath $Symlink;
	$Destination = Join-Path -Path $HOME -ChildPath $Symlink;

	Write-Host "Checking if the symlink at '$Destination' exists... " -NoNewLine;
	if(-not (Test-Path -Path $Destination)) {
		Write-Host "done.  The symlink does not exist.";
		Write-Host "Creating a symlink at '$Destination'... " -NoNewLine;
		if(Test-Path -Path $Source -PathType Container) {
			cmd /c mklink /d $Destination $Source;
		} elseif(Test-Path -Path $Source -PathType Leaf) {
			cmd /c mklink $Destination $Source;
		} else {
			throw New-Object Exception "The source item $Source does not exist.";
		}
		Write-Host "done";
	} else {
		Write-Host "done.";
		Write-Host "The symlink '$Destination' already exists.";
	}
}
