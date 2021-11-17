﻿$platformPackageName = 'resharper-platform'
$packageName = 'teamCityAddin'
$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$commonPath = $(Split-Path -parent $(Split-Path -parent $scriptPath))
$filename = 'JetBrains.dotUltimate.2021.3.EAP8.Checked.exe'

$installPath = Join-Path  (Join-Path $commonPath $platformPackageName) $filename
$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = $installPath
  silentArgs    = "/Silent=True /SpecificProductNames=teamCityAddin /VsVersion=*"
  validExitCodes= @(0)
  softwareName  = 'TeamCity Add-in'
}
Install-ChocolateyInstallPackage @packageArgs
