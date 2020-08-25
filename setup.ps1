param(
	[Switch] $Force
)

if(-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	throw New-Object System.Exception "The setup script requires administrator privileges to run.";
}

function New-Symlink {
	[CmdletBinding()]
	param (
		[String] $Path,
		[String] $Value
	)

	if(Test-Path -Path $Path -PathType Container) {
		cmd /c mklink /d $Value $Path | Out-Null;
	} elseif(Test-Path -Path $Path -PathType Leaf) {
		cmd /c mklink $Value $Path | Out-Null;
	} else {
		throw New-Object System.Exception "The source item $Path does not exist.";
	}
}

function Rename-Backup {
	[CmdletBinding()]
	param (
		[String] $Path
	)

	$NewPath = $Path;
	for($i = 1; Test-Path -Path $NewPath; $i++) {
		$NewPath = $Path + ".$i.bak"
	}

	Rename-Item -Path $Path -NewName $NewPath;
}

# Create profile directory if it is missing
$ProfileDirectory = Split-Path -Path $PROFILE -Parent;
if(-not (Test-Path -Path $ProfileDirectory)) {
	New-Item -ItemType Directory $ProfileDirectory;
}

# List files to be symbolically linked to other locations
$Items = @(
	@{
		"Source" = ".common.vimrc";
		"Destination" = Join-Path -Path $HOME -ChildPath ".common.vimrc";
	},
	@{
		"Source" = ".gvimrc";
		"Destination" = Join-Path -Path $HOME -ChildPath ".gvimrc";
	},
	@{
		"Source" = ".vimrc";
		"Destination" = Join-Path -Path $HOME -ChildPath ".vimrc";
	},
	@{
		"Source" = ".vim";
		"Destination" = Join-Path -Path $HOME -ChildPath "vimfiles";
	},
	@{
		"Source" = ".vsvimrc";
		"Destination" = Join-Path -Path $HOME -ChildPath ".vsvimrc";
	},
	@{
		"Source" = "aliases.psm1";
		"Destination" = Join-Path -Path $HOME -ChildPath ".aliases.psm1";
	},
	@{
		"Source" = "profile.ps1";
		"Destination" = $PROFILE;
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
		New-Symlink -Path $Source -Value $Item.Destination;
		Write-Host "done.";
	} elseif($Force -and (Get-Item -Path $Item.Destination | Select-Object -ExpandProperty "Attributes") -notmatch "ReparsePoint") {
		Write-Host "done.  A file/directory exists, but is not a symbolic link.";
		Write-Host "Backing up existing file/directory... ";
		Rename-Backup -Path $Item.Destination;
		Write-Host "done."
		Write-Host "Creating a symbolic link at '$($Item.Destination)'... " -NoNewLine;
		New-Symlink -Path $Source -Value $Item.Destination;
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
		Write-Host "Checking if module '$Module' is installed... " -NoNewLine;
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
