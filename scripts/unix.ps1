[CmdletBinding()]
param(
)

$script:aliases = @{
	ac = 'Add-Content';
	cat = 'Get-Content';
	cd = 'Set-Location';
	clear = 'Clear-Host';
	cp = 'Copy-Item';
	cpp = 'Copy-ItemProperty';
	diff = 'Compare-Object';
	echo = 'Write-Output';
	kill = 'Stop-Process';
	ls = 'Get-ChildItem';
	man = 'Get-Help';
	mount = 'New-PSDrive';
	mv = 'Move-Item';
	ps = 'Get-Process';
	pwd = 'Get-Location';
	rm = 'Remove-Item';
	rmdir = 'Remove-Item';
	sleep = 'Start-Sleep';
	sort = 'Sort-Object';
	tee = 'Tee-Object';
	type = 'Get-Content';
	write = 'Write-Output';
};

$script:Aliases.Keys | ForEach-Object {
	Write-Verbose "Adding $_";
	Set-Alias -Name $_ -Value $script:Aliases[$_] -Option AllScope -Scope Global;
}
