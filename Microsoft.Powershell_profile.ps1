if (Get-Module -ListAvailable -Name GetSTFolderSize) {    
    Import-Module GetSTFolderSize
} else {
    Install-Module GetSTFolderSize -Force
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
    "`n$('>' * ($nestedPromptLevel + 1)) "
}

# Create aliases
Set-Alias sublime "C:\Program Files\Sublime Text 3\sublime_text.exe"
Set-Alias code "C:\Program Files\Microsoft VS Code\Code.exe"

