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
    if (Get-Module -ListAvailable -Name posh-git) {    
        Import-Module posh-git
    } else {

        # NOTE: If the AllowPrerelease parameter is not recognized, update your version of PowerShellGet to >= 1.6 e.g.
        # Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber

        $allowsPreReleaseParam = (Get-Command Install-Module).ParameterSets | Select-Object -ExpandProperty Parameters | Where-Object {$_.Name -eq "AllowPreRelease"} 
        if($null -eq $allowsPreReleaseParam)
        {
            Write-Host "Prerelease param not supported. PowershellGet Module update required."	
            Write-Host "Ensure Nuget has Minimum version of 2.8.5.201. Installing now.. "
            Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

            Write-Host "Installing PowershellGet Module.."
            Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
        }
        
        Write-Host "posh-git required but not found. Installing now .."
        Install-Module posh-git -AllowClobber -AllowPrerelease -Force
        Import-Module posh-git
    }

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
    
    # TO RESET ALL SETTINGS RUN LINE BELOW
    # $GitPromptSettings = & (gmo posh-git) { [PoshGitPromptSettings]::new() }
}

Function Set-Autocompletes
{
    # PowerShell parameter completion shim for the dotnet CLI 
    Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
        param($commandName, $wordToComplete, $cursorPosition)
            dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
            }
    }
}

# Other functions
Function reload {. $PROFILE;}

Add-PersonalModules
Add-PersonalAliases
Set-GitOpenSSHWorkaround
Set-PoshGitPromptSettings
Set-Autocompletes

Write-Host "Loaded PS Profile."
