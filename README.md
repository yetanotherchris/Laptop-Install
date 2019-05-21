# Laptop software installer

This repo installs all development software _I use_ in one script, and machine customisations.

It works nicely with the Azure Visual Studio VM (which cost £0.17 an hour for D4s_V3 in 2017, with the Dev discount) - make sure you use a Dxx_V3 or Exx_V3 size instances to get Docker for Windows (nested virtualization) support.

## Installation

Run this in a Powershell administrator shell:

    iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/yetanotherchris/Laptop-Install/master/install.ps1'))
    
or ..

Copy the rider.ps1 onto the machine and run it.

### Enable Docker inside Hyper-V

On the host laptop:

```
$vmName = "Windows 10"
Set-VMProcessor -VMName $vmName -ExposeVirtualizationExtensions $true
Get-VMNetworkAdapter -VMName $vmName | Set-VMNetworkAdapter -MacAddressSpoofing On
```

### Skipping Docker for Windows installation
Set `$env:DOCKER_TOOLS = "no"` before running to skip installation of Docker for Windows and the Linux Subsystem.

### Skipping the fonts being installed
If the installation fails for any reason, fonts end up getting re-installed with a painful set of modals to re-click. You can skip this by using `$env:SKIP_FONTS="yes"`
