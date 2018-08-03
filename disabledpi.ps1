##[Ps1 To Exe]
##
##Kd3HDZOFADWE8uK1
##Nc3NCtDXThU=
##Kd3HFJGZHWLWoLaVvnQnhQ==
##LM/RF4eFHHGZ7/K1
##K8rLFtDXTiW5
##OsHQCZGeTiiZ4tI=
##OcrLFtDXTiW5
##LM/BD5WYTiiZ4tI=
##McvWDJ+OTiiZ4tI=
##OMvOC56PFnzN8u+Vs1Q=
##M9jHFoeYB2Hc8u+Vs1Q=
##PdrWFpmIG2HcofKIo2QX
##OMfRFJyLFzWE8uK1
##KsfMAp/KUzWJ0g==
##OsfOAYaPHGbQvbyVvnQX
##LNzNAIWJGmPcoKHc7Do3uAuO
##LNzNAIWJGnvYv7eVvnQX
##M9zLA5mED3nfu77Q7TV64AuzAgg=
##NcDWAYKED3nfu77Q7TV64AuzAgg=
##OMvRB4KDHmHQvbyVvnQX
##P8HPFJGEFzWE8tI=
##KNzDAJWHD2fS8u+Vgw==
##P8HSHYKDCX3N8u+Vgw==
##LNzLEpGeC3fMu77Ro2k3hQ==
##L97HB5mLAnfMu77Ro2k3hQ==
##P8HPCZWEGmaZ7/K1
##L8/UAdDXTlaDjobQ7iR490r8W1QPZ9aau7qihKWM1qrtrCTLTJQRWkdLsiDvBUmxXLI2ZdxVh9IQWRQkKLwO+rew
##Kc/BRM3KXhU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
##If to create an elevated instance, current folder passed as param
param($location)
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { 
	$args = $PSScriptRoot
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" `"$args`"" -Verb RunAs; exit 
}
function GetProgramFiles64
{
	$common = $ENV:ProgramFiles + "\"
	$common
}
function GetProgramFiles86
{
	$common = $ENV:ProgramFiles + " (x86)\"
	$common
}
function GetListofExes($direc)
{
	Get-ChildItem -Path $direc -Filter *.exe -ErrorAction SilentlyContinue -Force | % { $_.FullName }
}
function GetListofFolders($direc)
{
	Get-ChildItem -Path $direc -Directory | % { $_.FullName }
}
Write-Host "///////////////////////////"
Write-Host "/                         /"
Write-Host "/                         /"
Write-Host "/   Disable DPI Scaling   /"
Write-Host "/                         /"
Write-Host "/                         /"
Write-Host "///////////////////////////"
Write-Host " "
Write-Host " "
Write-Host " "
$direc = GetProgramFiles64
Write-Host $direc
Start-Sleep 1
$listafolder = GetListofFolders($direc)
foreach ($folder in $listafolder)
{
	$lista = GetListofExes($folder)
	foreach ($exe in $lista)
	{
		Write-Host "Registering " $exe
		$arguments="add `"HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers`" /v `"" + $exe + "`" /t REG_SZ /d `"~ HIGHDPIAWARE`" /f"
		Start-Process reg $arguments
	}
}
Write-Host " "
Write-Host " "
Write-Host " "
$direc = GetProgramFiles86
Write-Host $direc
Start-Sleep 5
foreach ($folder in $listafolder)
{
	$lista = GetListofExes($folder)
	foreach ($exe in $lista)
	{
		Write-Host "Registering " $exe
		$arguments="add `"HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers`" /v `"" + $exe + "`" /t REG_SZ /d `"~ HIGHDPIAWARE`" /f"
		Start-Process reg $arguments
	}
}
Read-Host "Press Enter to continue..." | Out-Null
exit