# Location of this file: C:\Users\chris\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psd1'

# Fix curl, add a grep, start in the home directory
Remove-Item alias:curl; set-Alias curl curl.exe -Scope Global
Set-Alias grep select-string

# Only go to the home directory when we're not in VSCode/Rider
if ($env:TERM_PROGRAM -ne 'vscode' -AND $env:TERMINAL_EMULATOR -ne 'JetBrains-JediTerm') {
    cd ~
}

# A nice bash-like prompt
function prompt {
    $time = (get-date).ToString("HH:mm")

    # Shorten the path
    $path = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    $path = $path.Replace($HOME, "~") 

    Write-Host "$($time):" -ForegroundColor Green -NoNewline
    Write-Host " $path" -ForegroundColor Green -NoNewline
    Write-VcsStatus
    Write-Host ""

    "$('$' * ($nestedPromptLevel + 1)) "
}
