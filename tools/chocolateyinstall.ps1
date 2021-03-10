$ErrorActionPreference = 'Stop';

# https://download.chitubox.com/17839/v1.8.1/CHITUBOX64Install_V1.8.1.exe?auth_key=1615082793-8dm1guft08qa7dowhim2bm1ohassus5e-0-e42d1722e3297f87112c50f3442b79ea
$packageName = $env:ChocolateyPackageName
$basePackageName = 'CHITUBOX64Install_V1.8.1'
$fullPackage = $basePackageName + '.exe'
$url64 = 'https://download.chitubox.com/17839/v1.8.1/' + $fullPackage
$checksum64 = '7e3e93278e5b52d640ede1e2968bad637c38886e367c91317a71b2d47c0e54a1'
$autoitExe = 'C:\Program Files (x86)\AutoIt3\AutoIt3.exe'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$WorkSpace = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"
$autoitFile = Join-Path $toolsDir 'chitubox.au3'

$WebFileArgs = @{
    packageName         = $packageName
    FileFullPath        = Join-Path $WorkSpace $fullPackage
    Url64bit            = $url64
    Checksum64          = $checkSum64
    ChecksumType        = 'sha256'
    GetOriginalFileName = $true
}

# $PackedInstaller = Get-ChocolateyWebFile @WebFileArgs

$InstallArgs = @{
    PackageName    = $packageName
    File           = Join-Path $toolsDir $fullPackage
    fileType       = 'exe'
    silentArgs     = '/S /SD IDYES'
    checksum64     = $checksum64
    checksumType64 = 'sha256'
    checksum       = $checksum64
    checksumType   = 'sha256'
    validExitCodes = @(0, 3010, 1641, 1603)
    softwareName   = 'CHITUBOX*'
}

$autoitProc = Start-Process -FilePath $autoitExe -ArgumentList "$autoitFile" -PassThru

#Install-ChocolateyInstallPackage @InstallArgs
Install-ChocolateyPackage @InstallArgs
#Get-ChecksumValid @InstallArgs

if ($autoitFile) {
    if (get-process -id $autoitProc.Id -ErrorAction SilentlyContinue) {
        stop-process -id $autoitProc.Id
    }
}
