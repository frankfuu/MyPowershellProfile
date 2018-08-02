# https://github.com/dahlbyk/posh-git/issues/583 - Windows 10 version 1803 broke my ssh-agent
[System.Environment]::SetEnvironmentVariable("SSH_AUTH_SOCK", $null)
[System.Environment]::SetEnvironmentVariable("SSH_AGENT_PID", $null)
git config --global core.sshCommand C:/Windows/System32/OpenSSH/ssh.exe

# Install desired modules
if (Get-Module -ListAvailable -Name DockerCompletion) {    
    Import-Module DockerCompletion
} else {
    Install-Module DockerCompletion -Force
    Import-Module DockerCompletion
}

if (Get-Module -ListAvailable -Name GetSTFolderSize) {    
    Import-Module GetSTFolderSize
} else {
    Install-Module GetSTFolderSize -Force
    Import-Module GetSTFolderSize
}

function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function prompt {
    # https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt
    $origLastExitCode = $LastExitCode
    Write-VcsStatus

    if (Test-Administrator) {  # if elevated
        Write-Host "[Administrator] " -NoNewline -ForegroundColor DarkGreen
    }

    Write-Host "$env:USERNAME@" -NoNewline -ForegroundColor Yellow
    Write-Host "$env:COMPUTERNAME" -NoNewline -ForegroundColor Magenta
    Write-Host " : " -NoNewline -ForegroundColor DarkGray

    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($curPath.ToLower().StartsWith($Home.ToLower()))
    {
        $curPath = "~" + $curPath.SubString($Home.Length)
    }

    Write-Host $curPath -NoNewline -ForegroundColor DarkGray
    Write-Host " : " -NoNewline -ForegroundColor DarkGray
    Write-Host $(get-date) -NoNewline -ForegroundColor Green    
    $LastExitCode = $origLastExitCode
    "`n$('> ' * ($nestedPromptLevel + 1)) "
}

# Create aliases
Set-Alias sublime "C:\Program Files\Sublime Text 3\sublime_text.exe"
Set-Alias code "C:\Program Files\Microsoft VS Code\Code.exe"

