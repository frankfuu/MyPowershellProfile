Function prompt {
    # Your non-prompt logic here
    "$pwd
> "
    
    # Have posh-git display its default prompt
    # & $GitPromptScriptBlock
}

Function Set-GitOpenSSHWorkaround
{
    # https://github.com/dahlbyk/posh-git/issues/583 - Windows 10 version 1803 broke my ssh-agent
    [System.Environment]::SetEnvironmentVariable("SSH_AUTH_SOCK", $null)
    [System.Environment]::SetEnvironmentVariable("SSH_AGENT_PID", $null)
    git config --global core.sshCommand "'C:\Program Files\OpenSSH-Win64\ssh.exe'"
}

Function Add-PersonalModules 
{
    if (Get-Module -ListAvailable -Name posh-git) {    
        # Import-Module posh-git
    } else {

        # NOTE: If the AllowPrerelease parameter is not recognized, update your version of PowerShellGet to >= 1.6 e.g.
        Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber

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
        # Import-Module DockerCompletion
    } else {
        Write-Host "DockerCompletion required but not found. Installing now .."
        Install-Module DockerCompletion -Force
        Import-Module DockerCompletion
    }
    
    if (Get-Module -ListAvailable -Name GetSTFolderSize) {    
        # Import-Module GetSTFolderSize
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
    Set-Alias -Name v -Value vagrant -Scope Global
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

<#  Features
    - Updates $env:Path so the change takes effect in the current session
    - Persists the environment variable change for future sessions
    - Doesn't add a duplicate path when the same path already exists
#>
function Add-EnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [string] $Path,

        [ValidateSet('Machine', 'User', 'Session')]
        [string] $Container = 'Session'
    )

    

    if ($Container -ne 'Session') {
        $containerMapping = @{
            Machine = [EnvironmentVariableTarget]::Machine
            User = [EnvironmentVariableTarget]::User
        }
        $containerType = $containerMapping[$Container]

        $persistedPaths = [Environment]::GetEnvironmentVariable('Path', $containerType) -split ';'
        if ($persistedPaths -notcontains $Path) {
            $persistedPaths = $persistedPaths + $Path | where { $_ }
            [Environment]::SetEnvironmentVariable('Path', $persistedPaths -join ';', $containerType)
        }
    }

    $envPaths = $env:Path -split ';'
    if ($envPaths -notcontains $Path) {
        $envPaths = $envPaths + $Path | where { $_ }
        $env:Path = $envPaths -join ';'
    }
}

function Remove-EnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [string] $Path,

        [ValidateSet('Machine', 'User', 'Session')]
        [string] $Container = 'Session'
    )

    if ($Container -ne 'Session') {
        $containerMapping = @{
            Machine = [EnvironmentVariableTarget]::Machine
            User = [EnvironmentVariableTarget]::User
        }
        $containerType = $containerMapping[$Container]

        $persistedPaths = [Environment]::GetEnvironmentVariable('Path', $containerType) -split ';'
        if ($persistedPaths -contains $Path) {
            $persistedPaths = $persistedPaths | where { $_ -and $_ -ne $Path }
            [Environment]::SetEnvironmentVariable('Path', $persistedPaths -join ';', $containerType)
        }
    }

    $envPaths = $env:Path -split ';'
    if ($envPaths -contains $Path) {
        $envPaths = $envPaths | where { $_ -and $_ -ne $Path }
        $env:Path = $envPaths -join ';'
    }
}

function Get-EnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('Machine', 'User')]
        [string] $Container
    )

    $containerMapping = @{
        Machine = [EnvironmentVariableTarget]::Machine
        User = [EnvironmentVariableTarget]::User
    }
    $containerType = $containerMapping[$Container]

    [Environment]::GetEnvironmentVariable('Path', $containerType) -split ';' |
        where { $_ }
}

function Test-Administrator  
{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}

Function Print-EnvironmentVariables
{
    [CmdletBinding()]
    [Alias('EnterAliasName')]

    Param
    (
        [ValidateSet('Machine', 'User', 'Process')] 
        [string]$Scope = $(
            Write-Host "Enter a selection --- Machine, User, Process:`t" -NoNewline -ForegroundColor Yellow 
            Read-Host
        )
    )

    switch ($Scope)
    {
        'Machine' { [System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::Machine) }
        'User'    { [System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::User) }
        'Process' { [System.Environment]::GetEnvironmentVariables([System.EnvironmentVariableTarget]::Process) }
        Default {}
    }

    $Scope
}

# Other functions
Function reload {. $PROFILE;}

Add-PersonalModules
Add-PersonalAliases
Set-GitOpenSSHWorkaround
# Set-PoshGitPromptSettings
# Set-Autocompletes

Import-Module $env:USERPROFILE\my-ps-modules\FrankModules.ps1

Write-Host "Loaded PS Profile."
