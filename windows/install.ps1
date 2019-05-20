# Create symbolic links
New-Item -Type SymbolicLink -Path $PROFILE -Value .\Microsoft.Powershell_profile.ps1 -Force
New-Item -Type SymbolicLink -Path $env:USERPROFILE\.gitconfig -Value .\.gitconfig -Force
New-Item -Type SymbolicLink -Path $env:USERPROFILE\.gitignore_global -Value .\.gitignore_global -Force
New-Item -Type SymbolicLink -Path $env:USERPROFILE\.hyper.js -Value .\.hyper.js -Force
New-Item -Type SymbolicLink -Path $env:USERPROFILE\audioscript.ahk -Value .\audioscript.ahk -Force

New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\audioscript.exe" -Value ".\audioscript.exe" -Force

# Create sheduled task to periodically pull if not exist
$taskName = "pull dotfiles"
if(Get-ScheduledTask $taskName -ErrorAction Ignore)  {  
    Write-Host "Scheduled task already exists. Skipping install of scheduled task" 
}
else {
    Write-Host "Installing scheduled task named :  $taskName"
    $startTrigger =  New-ScheduledTaskTrigger -Daily -At 6pm
    $sAction = New-ScheduledTaskAction -Execute "git.exe" -Argument '-C "c:\projects\dotfiles" pull --verbose'
    Register-ScheduledTask -Action $sAction -TaskName $taskName -TaskPath $env:USERNAME -Trigger $startTrigger    
}

# Create sheduled task run audioscript upon login
$taskName2 = "run audioscript upon login"
if(Get-ScheduledTask $taskName2 -ErrorAction Ignore)  {  
    Write-Host "Scheduled task already exists. Skipping install of scheduled task" 
}
else {
    Write-Host "Installing scheduled task named :  $taskName2"
    $startTrigger =  New-ScheduledTaskTrigger -AtLogOn
    $sAction = New-ScheduledTaskAction -Execute "${pwd}\audioscript.exe"
    Register-ScheduledTask -Action $sAction -TaskName $taskName2 -TaskPath $env:USERNAME -Trigger $startTrigger -RunLevel Highest
}

# Reload Powershell profile
. $PROFILE