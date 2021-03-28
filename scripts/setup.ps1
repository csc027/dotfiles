[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidAssignmentToAutomaticVariable', '', Justification = 'This script assigns to the $IsWindows variable for PowerShell versions 5 or lower.')]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'This script uses Write-Host for interactive display.')]
[CmdletBinding()]
param(
	[Switch] $Force
)

if ($PsVersionTable.PsVersion.Major -le 5) {
	$IsWindows = $true;
}

if ($IsWindows -and -not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
	$Arguments = if ($Force) {
		'-NoExit', "-File $($MyInvocation.MyCommand.Definition)", '-Force' 
	} else {
		'-NoExit', "-File $($MyInvocation.MyCommand.Definition)"
	}
	if ($PsVersionTable.PsVersion.Major -gt 5) {
		Start-Process 'pwsh' -ArgumentList $Arguments -Verb runAs;
	} else {
		Start-Process 'powershell' -ArgumentList $Arguments -Verb runAs;
	}
	return;
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
			cmd /c mklink /d $Path $Value | Out-Null;
		} else {
			cmd /c mklink $Path $Value | Out-Null;
		}
	} else {
		New-Item -ItemType SymbolicLink -Path $Path -Value $Value | Out-Null;
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
		'Source' = '.aliases.psm1';
		'Destination' = Join-Path -Path $HOME -ChildPath '.aliases.psm1';
	},
	@{
		'Source' = '.common.vimrc';
		'Destination' = Join-Path -Path $HOME -ChildPath '.common.vimrc';
	},
	@{
		'Source' = [IO.Path]::Combine('submodules', 'dircolors-solarized', 'dircolors.256dark');
		'Destination' = Join-Path -Path $HOME -ChildPath '.dircolors';
	},
	@{
		'Source' = '.gvimrc';
		'Destination' = Join-Path -Path $HOME -ChildPath '.gvimrc';
	},
	@{
		'Source' = Join-Path -Path 'scripts' -ChildPath 'profile.ps1';
		'Destination' = $PROFILE;
	},
	@{
		'Source' = '.vim';
		'Destination' = $(if ($IsWindows) { Join-Path -Path $HOME -ChildPath 'vimfiles' } else { Join-Path -Path $HOME -ChildPath '.vim' });
	},
	@{
		'Source' = '.vimrc';
		'Destination' = Join-Path -Path $HOME -ChildPath '.vimrc';
	},
	@{
		'Source' = '.vsvimrc';
		'Destination' = Join-Path -Path $HOME -ChildPath '.vsvimrc';
	},
	@{
		'Source' = $(if ($IsWindows) { Join-Path -Path 'scripts' -ChildPath 'windows.ps1' } else { Join-Path -Path 'scripts' -ChildPath 'unix.ps1' });
		'Destination' = Join-Path -Path $ProfileDirectory -ChildPath 'os.ps1';
	}
) | ForEach-Object { New-Object -TypeName PSObject -Property $_ };

if (Get-Command -Name 'wt' -ErrorAction 'SilentlyContinue') {
	$PackageSettingsPath = [IO.Path]::Combine($HOME, 'AppData', 'Local', 'Packages', 'Microsoft.WindowsTerminal_8wekyb3d8bbwe', 'LocalState', 'settings.json');
	$LocalSettingsPath = [IO.Path]::Combine($HOME, 'AppData', 'Local', 'Microsoft', 'Windows Terminal', 'settings.json');
	$Items += New-Object -TypeName PSObject -Property @{
		'Source' = 'settings.json';
		'Destination' = $(if (Test-Path -Path $PackageSettingsPath) { $PackageSettingsPath } else { $LocalSettingsPath });
	};
}

# Create the symbolic links
foreach ($Item in $Items) {
	$DotfilesRootDirectory = Split-Path -Path $PsScriptRoot -Parent;
	$Source = Join-Path -Path $DotfilesRootDirectory -ChildPath $Item.Source;

	Write-Host -Object "Checking if the symbolic link at '$($Item.Destination)' exists... " -NoNewLine;
	if ($Force -and (Get-Item -Path $Item.Destination | Select-Object -ExpandProperty 'Attributes') -notmatch 'ReparsePoint') {
		Write-Host 'done.  A file/directory exists, but is not a symbolic link.';
		Write-Host "Creating a symbolic link at '$($Item.Destination)'... " -NoNewLine;
		New-Symlink -Path $Item.Destination -Value $Source -Force:$Force;
		Write-Host 'done.';
	} elseif (-not (Test-Path -Path $Item.Destination)) {
		Write-Host 'done.  The symbolic link does not exist.';
		Write-Host "Creating a symbolic link at '$($Item.Destination)'... " -NoNewLine;
		New-Symlink -Path $Item.Destination -Value $Source;
		Write-Host 'done.';
	} else {
		Write-Host 'done.';
		Write-Host "The symbolic link '$($Item.Destination)' already exists.";
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
		Write-Host "Checking if module '$Module' is installed... " -NoNewLine;
		if (-not (Get-Module -Name $Module) -and -not (Get-InstalledModule -Name $Module)) {
			Write-Host "done.$([Environment]::NewLine)Installing '$Module'... " -NoNewLine;
			Install-Module -Name $Module -Force;
			Write-Host 'done.';
		} else {
			Write-Host 'done.  Module is already installed.';
		}
	}
}
