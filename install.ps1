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

# -------------------------------------------------------------------------------------------
# All the software needed to be a modern website developing programmer engineer
# -------------------------------------------------------------------------------------------
choco upgrade googlechrome
choco upgrade microsoft-edge
choco upgrade visualstudiocode
choco upgrade linqpad5
choco upgrade 7zip
choco upgrade curl
choco upgrade poshgit
choco upgrade google-backup-and-sync
choco upgrade everything
choco upgrade adobereader

if ($env:DOCKER_TOOLS -ne "no")
{
    choco upgrade docker-for-windows
}

# -------------------------------------------------------------------------------------------
# Rider
# -------------------------------------------------------------------------------------------
choco upgrade jetbrains-rider

# -------------------------------------------------------------------------------------------
# Linux Windows subsystem
# -------------------------------------------------------------------------------------------
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

# -------------------------------------------------------------------------------------------
# Download rider settings file. Not sure how to install them automatically?
# -------------------------------------------------------------------------------------------
pushd $env:HOMEPATH/Downloads

rm -Force rider-settings.jar -ErrorAction Ignore;
curl.exe -O -k -L https://raw.githubusercontent.com/yetanotherchris/Laptop-Install/master/rider-settings.jar

# -------------------------------------------------------------------------------------------
# Powershell profile
# -------------------------------------------------------------------------------------------
curl.exe -O -k -L https://raw.githubusercontent.com/yetanotherchris/Laptop-Install/master/profile.ps1
log "Updating Powershell profile"
cp -Force ./profile.ps1 $profile
