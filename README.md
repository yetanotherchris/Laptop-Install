# VisualStudio Virtual Machine installer

This repo installs all development software _I use_ in one script, and machine customisations. 

It works nicely with the Azure Visual Studio VM (which cost £0.17 an hour for D4s_V3 in 2017, with the Dev discount) - make sure you use a Dxx_V3 or Exx_V3 size instances to get Docker for Windows (nested virtualization) support.

    iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/yetanotherchris/VisualStudio-VM/master/install.ps1'))
    
or ..

Copy the install.ps1 onto the machine and run it.

## Installing Visual Studio Community
To install Visual Studio 2017 as well, set an environmental variable first: `$env:INSTALL_VS2017="yes"`

## Setup for Visual Studio Professional
Set `$env:IS_VS_PRO = "yes"` before running to do this

## Skipping the fonts being installed
If the installation fails for any reason, fonts end up getting re-installed with a painful set of modals to re-click. You can skip this by using `$env:SKIP_FONTS="yes"`
