# Laptop software installer

This repo installs all development software _I use_ in one script, and machine customisations.

It works nicely with the Azure Visual Studio VM (which cost £0.17 an hour for D4s_V3 in 2017, with the Dev discount) - make sure you use a Dxx_V3 or Exx_V3 size instances to get Docker for Windows (nested virtualization) support.

## Installation

Run this in a Powershell administrator shell:

    iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/yetanotherchris/Laptop-Installer/master/rider.ps1'))
    
or ..

Copy the rider.ps1 onto the machine and run it.

## The older Visual Studio installation

I use Rider now but the script below should still work for Visual Studio:

    iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/yetanotherchris/Laptop-Installer/master/install.ps1'))
    
or ..

Copy the install.ps1 onto the machine and run it.

### Installing Visual Studio Community
To install Visual Studio 2017 as well, set an environmental variable first: `$env:INSTALL_VS2017="yes"`

### Setup for Visual Studio Professional
Set `$env:IS_VS_PRO = "yes"` before running to do this

### Skipping Docker for Windows installation
Set `$env:DOCKER_TOOLS = "no"` before running to skip installation of Docker for Windows and the Linux Subsystem.

### Skipping the fonts being installed
If the installation fails for any reason, fonts end up getting re-installed with a painful set of modals to re-click. You can skip this by using `$env:SKIP_FONTS="yes"`
