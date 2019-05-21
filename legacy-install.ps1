# Check that we're an admin shell
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent())
if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -eq $false)
{
    Write-Error "Please run this scripts as an administrator"
    exit 1
}

function log($message)
{
    Write-Host "$message" -ForegroundColor Green
}

Set-ExecutionPolicy RemoteSigned -Confirm:$false -Force
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# Stop prompting in Chocolately
choco feature enable -n allowGlobalConfirmation

$vsStudio = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\devenv.exe"
$installFonts = $true;

if ($env:SKIP_FONTS -eq "yes")
{
    $installFonts = $false;
}

# -------------------------------------------------------------------------------------------
# For installing onto Hyper-V on the desklaptop
# -------------------------------------------------------------------------------------------
if ($env:INSTALL_VS2017 -eq "yes")
{
    if ($env:IS_VS_PRO -eq "no")
    {
        choco install visualstudio2017community
        choco install visualstudio2017-workload-netcoretools
        choco install visualstudio2017-workload-netweb
    }
    elseif ($env:IS_VS_PRO -eq "yes")
    {
        choco install visualstudio2017professional
        choco install visualstudio2017-workload-netcoretools
        choco install visualstudio2017-workload-netweb
    }

}

# -------------------------------------------------------------------------------------------
# VS Professional toggle
# -------------------------------------------------------------------------------------------
if ($env:IS_VS_PRO -eq "yes")
{
    $vsStudio = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"
}

# -------------------------------------------------------------------------------------------
# All the software needed to be a modern website developing programmer engineer
# -------------------------------------------------------------------------------------------
choco upgrade googlechrome
choco upgrade firefox
choco upgrade conemu
choco upgrade visualstudiocode
choco upgrade linqpad5
choco upgrade 7zip
choco upgrade curl
choco upgrade terraform
choco upgrade poshgit

if ($env:DOCKER_TOOLS -ne "no")
{
    choco upgrade docker-for-windows
}

# -------------------------------------------------------------------------------------------
# Resharper
# -------------------------------------------------------------------------------------------
choco upgrade resharper-platform -y
$resharperInstaller = Resolve-Path "$env:ChocolateyInstall\lib\resharper-platform\JetBrains.ReSharperUltimate.*.exe"
Write-Output "Installing ReSharper Ultimate with lots of goodies: $resharperInstaller"
Start-Process -FilePath "$resharperInstaller" -ArgumentList "/SpecificProductNames=ReSharper /Silent=True" -Wait -PassThru

# -------------------------------------------------------------------------------------------
# Linux Windows subsystem
# -------------------------------------------------------------------------------------------
if ($env:DOCKER_TOOLS -ne "no")
{
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
}

# -------------------------------------------------------------------------------------------
# Download the source of this repo
# -------------------------------------------------------------------------------------------
pushd $env:temp

rm -Force master.zip -ErrorAction Ignore;
rm -Force -Recurse master  -ErrorAction Ignore;
curl.exe -O -k -L https://github.com/yetanotherchris/Laptop-Install/archive/master.zip
Expand-Archive ./master.zip -Force
pushd master/Laptop-Install-master

# -------------------------------------------------------------------------------------------
# Powershell profile
# -------------------------------------------------------------------------------------------
log "Updating Powershell profile"
cp -Force ./profile.ps1 $profile

# -------------------------------------------------------------------------------------------
# Install code snippets
# -------------------------------------------------------------------------------------------
log "Installing code snippets"
md -Force "~\Documents\Visual Studio 2017\Code Snippets\Visual C#\My Code Snippets"
cp -Force snippets/*.* "~\Documents\Visual Studio 2017\Code Snippets\Visual C#\My Code Snippets"

# -------------------------------------------------------------------------------------------
# Install the Ubuntu font for Conemu
# -------------------------------------------------------------------------------------------
if ($installFonts -eq $true)
{
    log "Installing the Ubuntu font"
    Expand-Archive ubuntu-font-family-0.83.zip ./ubuntu-fonts

    $fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
    dir ubuntu-fonts\ubuntu-font-family-0.83\*.ttf | foreach-object { $fonts.CopyHere($_.fullname) }
}
# -------------------------------------------------------------------------------------------
# Install conemu settings
# -------------------------------------------------------------------------------------------
log "Updating conemu settings"
cp -Force ./conemu.xml ~\AppData\Roaming\conemu.xml

# -------------------------------------------------------------------------------------------
# Install VS settings
# -------------------------------------------------------------------------------------------
log "Updating Visual Studio user settings"
set-alias devenv "$vsStudio" -Scope global
devenv /ResetSettings .\vs2017.vssettings

log "Done!"
popd

# -------------------------------------------------------------------------------------------
# Sourcetree
# -------------------------------------------------------------------------------------------
choco install sourcetree

# Fire up the Docker notification to prompt a logout
if ($env:DOCKER_TOOLS -ne "no")
{
    start "C:\Program Files\Docker\Docker\Docker for Windows.exe"
}
