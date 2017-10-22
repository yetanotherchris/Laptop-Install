# VisualStudio Virtual Machine installer

This repo installs all development software _I use_ in one script, and machine customisations. 

It works nicely with the Azure Visual Studio VM (which costs 13p an hour) - make sure you use a D_V3 or E_V3 size instances to get Docker for Windows (nested virtualization) support.

    iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/yetanotherchris/VisualStudio-VM/master/install.ps1'))
    
or ..

Copy the install.ps1 onto the machine and run it.
