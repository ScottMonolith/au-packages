﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url           = 'https://github.com/kee-org/keepassrpc/releases/download/v1.12.1/KeePassRPC.plgx'
$checksum      = '73468bcb57472ca6d17e45294136e4d2a4e69ac19e500225f71deab6ad3f1a5e'

$packagePath = $(Split-Path -parent $toolsDir)
$downloadPath = Join-Path $packagePath "KeePassRPC.plgx"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  FileFullPath   = $downloadPath
}

Get-ChocolateyWebFile @packageArgs

# Now copy the plugin into the KeePass plugins directory
if (Test-Path env:"ProgramFiles(x86)")
{
  $fileFullPath = ${env:ProgramFiles(x86)}
} else {
  $fileFullPath = $env:ProgramFiles
}

$fileFullPath = [IO.Path]::Combine($fileFullPath, "KeePass Password Safe 2\Plugins\")

if (-not (Test-Path $fileFullPath)) {
  New-Item -ItemType Directory $fileFullPath | Out-Null
}

Copy-Item -Path $downloadPath -Destination $fileFullPath -Force
