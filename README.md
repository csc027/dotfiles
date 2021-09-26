# dotfiles
This repository is a collection of basic configuration files for terminal and Vim use.

## Installation
To install, simply clone the repository and run the setup script.

```bash
git clone https://github.com/csc027/dotfiles --recurse
```

### Windows
For Windows, you can install by running the PowerShell setup script from the repository top directory.  On Windows, creating true symlinks requires administrator privileges.  The script will request it via UAC and spawn a child administrator process to run.
```powershell
.\scripts\setup.ps1
```

### Linux
For Linux bash, you can install by running the setup script from the repository top directory.
```bash
./scripts/setup.sh
```

PowerShell Core is also available on Linux.  You can still set up the configuration using PowerShell if desired.
```powershell
.\scripts\setup.ps1
```
