 # Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
 if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
   $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
   Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
   Exit
 }
}

Import-Module $PSScriptRoot\DotFiles.psm1

$HomeExists = Test-Path Env:HOME

if ($HomeExists -ne $True) {
  echo "Creating HOME environment variable with value $env:USERPROFILE"
  [Environment]::SetEnvironmentVariable("HOME", $env:USERPROFILE, "User")
} else {
  Write-Warning "HOME environment variable already exists, leaving it alone..."
}

Install-Manifest $PSScriptRoot\MANIFEST

pause
