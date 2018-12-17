Function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

Function prompt {
    # Your non-prompt logic here

    # Have posh-git display its default prompt
    & $GitPromptScriptBlock
}

Function Set-GitOpenSSHWorkaround
{
    # https://github.com/dahlbyk/posh-git/issues/583 - Windows 10 version 1803 broke my ssh-agent
    [System.Environment]::SetEnvironmentVariable("SSH_AUTH_SOCK", $null)
    [System.Environment]::SetEnvironmentVariable("SSH_AGENT_PID", $null)
    git config --global core.sshCommand C:/Windows/System32/OpenSSH/ssh.exe
}

Function Add-PersonalModules 
{
    if (Get-Module -ListAvailable -Name DockerCompletion) {    
        Import-Module DockerCompletion
    } else {
        Write-Host "DockerCompletion required but not found. Installing now .."
        Install-Module DockerCompletion -Force
        Import-Module DockerCompletion
    }
    
    if (Get-Module -ListAvailable -Name GetSTFolderSize) {    
        Import-Module GetSTFolderSize
    } else {
        Write-Host "GetSTFolderSize required but not found. Installing now .."
        Install-Module GetSTFolderSize -Force
        Import-Module GetSTFolderSize
    }
}

Function Add-PersonalAliases
{
    Set-Alias sublime "C:\Program Files\Sublime Text 3\sublime_text.exe" -Scope Global
    # New-Alias code "C:\Program Files\Microsoft VS Code\Code.exe" -Scope Global
    Set-Alias -Name dkr -Value docker -Scope Global
    Set-Alias -Name dc -Value docker-compose -Scope Global
    Set-Alias -Name g -Value git -Scope Global
}

Function Set-PoshGitPromptSettings
{
    # https://github.com/dahlbyk/posh-git/blob/master/README.md#customizing-the-posh-git-prompt
    $GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'
    $GitPromptSettings.DefaultPromptSuffix = '$(">" * ($nestedPromptLevel + 1)) '
}

# Other functions
Function reload {. $PROFILE;}

Add-PersonalModules
Add-PersonalAliases
Set-GitOpenSSHWorkaround
Set-PoshGitPromptSettings

Write-Host "Loaded PS Profile."
