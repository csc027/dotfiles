if(-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	throw New-Object System.Exception "The setup script requires administrator privileges to run.";
}

# Create profile directory if it is missing
$ProfileDirectory = Split-Path -Path $PROFILE -Parent;
if(-not (Test-Path -Path $ProfileDirectory)) {
	New-Item -ItemType Directory $ProfileDirectory;
}

# List files to be symbolically linked to other locations
$Items = @(
	@{
		"Source" = ".vimrc";
		"Destination" = Join-Path -Path $HOME -ChildPath ".vimrc";
	},
	@{
		"Source" = ".vim";
		"Destination" = Join-Path -Path $HOME -ChildPath "vimfiles";
	},
	@{
		"Source" = "profile.ps1";
		"Destination" = $PROFILE;
	},
	@{
		"Source" = "aliases.psm1";
		"Destination" = Join-Path -Path $ProfileDirectory -ChildPath "aliases.psm1";
	}
) | ForEach-Object {
	New-Object -TypeName PsObject -Property $_;
};

# Create the symbolic links
foreach($Item in $Items) {
	$Source = Join-Path -Path $PsScriptRoot -ChildPath $Item.Source;

	Write-Host "Checking if the symbolic link at '$($Item.Destination)' exists... " -NoNewLine;
	if(-not (Test-Path -Path $Item.Destination)) {
		Write-Host "done.  The symbolic link does not exist.";
		Write-Host "Creating a symbolic link at '$($Item.Destination)'... " -NoNewLine;
		if(Test-Path -Path $Source -PathType Container) {
			cmd /c mklink /d $Item.Destination $Source | Out-Null;
		} elseif(Test-Path -Path $Source -PathType Leaf) {
			cmd /c mklink $Item.Destination $Source | Out-Null;
		} else {
			throw New-Object System.Exception "The source item $Source does not exist.";
		}
		Write-Host "done.";
	} else {
		Write-Host "done.";
		Write-Host "The symbolic link '$($Item.Destination)' already exists.";
	}
}

# Install modules
if(Get-Command -Name "Install-Module") {
	$Modules = @(
		"posh-git",
		"PsReadLine"
	);
	foreach($Module in $Modules) {
		Write-Host "Checking if module '$Module' is installed... " -NoNewLline;
		if(-not (Get-Module -Name $Module)) {
			Write-Host "done."
			Write-Host "Installing '$Module'... " -NoNewLine;
			Install-Module -Name $Module -Force;
			Write-Host "done.";
		} else {
			Write-Host "done.  Module is already installed.";
		}
	}
}
