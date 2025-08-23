[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidAssignmentToAutomaticVariable', '', Justification = 'This script assigns to the $IsWindows variable for PowerShell versions 5 or lower.')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'This script uses Write-Host for interactive display.')]
[CmdletBinding()]
param(
	[Switch] $Force
)

if ($PSVersionTable.PsVersion.Major -le 5) {
	$IsWindows = $true;
}

function New-Symlink {
	[CmdletBinding()]
	param (
		[String] $Path,
		[String] $Value,
		[Switch] $Force
	)

	if (-not (Test-Path -Path $Value)) {
		throw New-Object System.Exception "The source item $Value does not exist.";
	}

	if ($Force -and (Test-Path -Path $Path)) {
		Remove-Item -Path $Path;
	}

	if ($IsWindows) {
		if (Test-Path -Path $Value -PathType Container) {
			cmd /c mklink /j $Path $Value > $null;
		} else {
			cmd /c mklink /h $Path $Value > $null;
		}
	} else {
		if (Test-Path -Path $Value -PathType Container) {
			New-Item -ItemType Junction -Path $Path -Value $Value > $null;
		} else {
			New-Item -ItemType HardLink -Path $Path -Value $Value > $null;
		}
	}
}

# Create profile directory if it is missing
$ProfileDirectory = Split-Path -Path $PROFILE -Parent;
if (-not (Test-Path -Path $ProfileDirectory)) {
	New-Item -ItemType Directory $ProfileDirectory;
}

# List files to be symbolically linked to other locations
$Items = @(
	@{
		'Source' = Join-Path -Path 'settings' -ChildPath '.aliases.psm1';
		'Destination' = Join-Path -Path $HOME -ChildPath '.aliases.psm1';
	},
	@{
		'Source' = [IO.Path]::Combine('submodules', 'dircolors-solarized', 'dircolors.256dark');
		'Destination' = Join-Path -Path $HOME -ChildPath '.dircolors';
	},
	@{
		'Source' = Join-Path -Path 'scripts' -ChildPath 'profile.ps1';
		'Destination' = $PROFILE;
	},
	@{
		'Source' = 'nvim';
		'Destination' = $(if ($IsWindows) { [IO.Path]::Combine($HOME, 'AppData', 'Local', 'nvim') } else { [IO.Path]::Combine($HOME, '.config', 'nvim') });
	},
	@{
		'Source' = Join-Path -Path 'settings' -ChildPath '.vsvimrc';
		'Destination' = Join-Path -Path $HOME -ChildPath '.vsvimrc';
	},
	@{
		'Source' = Join-Path -Path 'settings' -ChildPath 'omnisharp.json';
		'Destination' = [IO.Path]::Combine($HOME, '.omnisharp', 'omnisharp.json');
	},
	@{
		'Source' = Join-Path -Path 'settings' -ChildPath 'prompt.json';
		'Destination' = Join-Path -Path $HOME -ChildPath '.prompt.json';
	},
	@{
		'Source' = $(if ($IsWindows) { Join-Path -Path 'scripts' -ChildPath 'windows.ps1' } else { Join-Path -Path 'scripts' -ChildPath 'unix.ps1' });
		'Destination' = Join-Path -Path $ProfileDirectory -ChildPath 'os.ps1';
	}
) | ForEach-Object { New-Object -TypeName PSObject -Property $_ };

if (Get-Command -Name 'wt' -ErrorAction 'SilentlyContinue') {
	$PackageSettingsPath = [IO.Path]::Combine($HOME, 'AppData', 'Local', 'Packages', 'Microsoft.WindowsTerminal_8wekyb3d8bbwe', 'LocalState', 'settings.json');
	$LocalSettingsPath = [IO.Path]::Combine($HOME, 'AppData', 'Local', 'Microsoft', 'Windows Terminal', 'settings.json');
	$RepositorySettingsPath = Join-Path -Path 'settings' -ChildPath 'settings.json';
	if (Test-Path -Path $LocalSettingsPath) {
		$Items += New-Object -TypeName PSObject -Property @{
			'Source' = $RepositorySettingsPath;
			'Destination' = $LocalSettingsPath;
		};
	}
	if (Test-Path -Path $PackageSettingsPath) {
		$Items += New-Object -TypeName PSObject -Property @{
			'Source' = $RepositorySettingsPath;
			'Destination' = $PackageSettingsPath;
		};
	}
}

# Create the symbolic links
$DotfilesRootDirectory = Split-Path -Path $PSScriptRoot -Parent;
foreach ($Item in $Items) {
	$Source = Join-Path -Path $DotfilesRootDirectory -ChildPath $Item.Source;

	Write-Host -Object "Checking if the symbolic link at '$($Item.Destination)' exists... " -NoNewline;
	if ($Force -and (Test-Path -Path $Item.Destination) -and (Get-Item -Path $Item.Destination | Select-Object -ExpandProperty 'Attributes') -notmatch 'ReparsePoint') {
		Write-Host 'done.  A file/directory exists, but is not a symbolic link.';
		Write-Host "Creating a symbolic link at '$($Item.Destination)'... " -NoNewline;
		New-Symlink -Path $Item.Destination -Value $Source -Force:$Force;
		Write-Host 'done.';
	} elseif (Test-Path -Path $Item.Destination) {
		Write-Host 'done.';
		Write-Host "The symbolic link '$($Item.Destination)' already exists.";
	} else {
		Write-Host 'done.  The symbolic link does not exist.';
		$ParentDirectory = Split-Path -Path $Item.Destination -Parent;
		if (-not (Test-Path -Path $ParentDirectory -PathType Container)) {
			Write-Host "Creating missing parent directory '$ParentDirectory'... " -NoNewline;
			New-Item -ItemType Directory -Path $ParentDirectory > $null;
			Write-Host 'done.';
		}
		Write-Host "Creating a symbolic link at '$($Item.Destination)'... " -NoNewline;
		New-Symlink -Path $Item.Destination -Value $Source;
		Write-Host 'done.';
	}
}

# Setup GitHub CLI aliases
if (Get-Command -Name 'gh' -ErrorAction 'SilentlyContinue') {
	$GitHubAliases = [IO.Path]::Combine($DotfilesRootDirectory, 'settings', 'ghcli.yml');
	if (Test-Path -Path $GitHubAliases) {
		if ($Force) {
			gh.exe alias delete --all;
		}
		gh.exe alias import $GitHubAliases;
	}
}

# Install modules
if (Get-Command -Name 'Install-Module' -ErrorAction SilentlyContinue) {
	if ($Host.UI.SupportsVirtualTerminal) {
		$Modules = @('DirColors', 'posh-git', 'PsReadLine');
	} else {
		$Modules = @('posh-git', 'PsReadLine');
	}
	foreach ($Module in $Modules) {
		Write-Host "Checking if module '$Module' is installed... " -NoNewline;
		if (-not (Get-Module -Name $Module) -and -not (Get-InstalledModule -Name $Module)) {
			Write-Host "done.$([Environment]::NewLine)Installing '$Module'... " -NoNewline;
			Install-Module -Name $Module -Force;
			Write-Host 'done.';
		} else {
			Write-Host 'done.  Module is already installed.';
		}
	}
}
