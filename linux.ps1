$global:__aliases = @{
	ac    = "Add-Content";
	cat   = "Get-Content";
	cd    = "Set-Location";
	clear = "Clear-Host";
	cp    = "Copy-Item";
	cpp   = "Copy-ItemProperty";
	diff  = "Compare-Object";
	echo  = "Write-Output";
	fc    = "Format-Custom";
	kill  = "Stop-Process";
	ls    = "Get-ChildItem";
	man   = "Get-Help";
	mount = "New-PSDrive";
	mv    = "Move-Item";
	ps    = "Get-Process";
	pwd   = "Get-Location";
	ri    = "Remove-Item";
	rm    = "Remove-Item";
	rmdir = "Remove-Item";
	sleep = "Start-Sleep";
	sort  = "Sort-Object";
	tee   = "Tee-Object";
	type  = "Get-Content";
	write = "Write-Output";
};

$global:__aliases.Keys | ForEach-Object { 
	Write-Verbose "Adding $_";
	Set-Alias -Name $_ -Value $global:__aliases[$_] -Scope Global;
}
