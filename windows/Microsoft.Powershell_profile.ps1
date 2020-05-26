Function prompt {
# Your non-prompt logic here
    "$pwd `n> ";
}

Function Set-GitOpenSSHWorkaround
{
    # https://github.com/dahlbyk/posh-git/issues/583 - Windows 10 version 1803 broke my ssh-agent
    [System.Environment]::SetEnvironmentVariable("SSH_AUTH_SOCK", $null)
    [System.Environment]::SetEnvironmentVariable("SSH_AGENT_PID", $null)
    git config --global core.sshCommand "'C:\Program Files\OpenSSH-Win64\ssh.exe'"
}

Function Add-PersonalAliases
{
    Set-Alias sublime "C:\Program Files\Sublime Text 3\sublime_text.exe" -Scope Global
    # New-Alias code "C:\Program Files\Microsoft VS Code\Code.exe" -Scope Global
    Set-Alias -Name dkr -Value docker -Scope Global
    Set-Alias -Name dc -Value docker-compose -Scope Global
    Set-Alias -Name g -Value git -Scope Global
    Set-Alias -Name v -Value vagrant -Scope Global
    Set-Alias -Name hostsfile -Value "explorer $env:SystemRoot\System32\Drivers\etc\hosts" -Scope Global
    Set-Alias -Name boo -Value "C:\Program Files\Microsoft VS Code\Code.exe hihi.txt" -Scope Global    
}
function tree { wsl tree @args }
function hosts { code "$env:windir\System32\drivers\etc\hosts" }

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

# Map some key bindings for powershell to act like Linux shells
Function Set-PSReadLinePrefs() {
    Set-PSReadLineKeyHandler -Key ctrl+w    -Function BackwardDeleteWord
    Set-PSReadLineKeyHandler -Key ctrl+p    -Function PreviousHistory
    Set-PSReadLineKeyHandler -Key alt+d     -Function ShellKillWord    
    Set-PSReadlineKeyHandler -Key alt+b     -Function ShellBackwardWord
    Set-PSReadlineKeyHandler -Key alt+f     -Function ShellForwardWord 
    Set-PSReadLineKeyHandler -Key ctrl+e    -Function MoveToEndOfLine  
    Set-PSReadLineKeyHandler -Key ctrl+a    -Function GotoFirstNonBlankOfLine  
}

# Other functions
Function reload {. $PROFILE;}

Add-PersonalAliases
Set-PSReadLinePrefs
Set-Location $env:USERPROFILE

### OLD STUFF. Clean later ###
# Set-GitOpenSSHWorkaround
# Set-PoshGitPromptSettings
# Set-Autocompletes
# Import-Module $env:USERPROFILE\my-ps-modules\FrankModules.ps1
