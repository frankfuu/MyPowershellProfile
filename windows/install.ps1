# Create symbolic links
New-Item -Type SymbolicLink -Path $PROFILE -Value .\Microsoft.Powershell_profile.ps1 -Force
New-Item -Type SymbolicLink -Path $env:USERPROFILE\.gitconfig -Value .\.gitconfig -Force
New-Item -Type SymbolicLink -Path $env:USERPROFILE\.gitignore_global -Value .\.gitignore_global -Force

# Create sheduled task to periodically pull
$startTrigger =  New-ScheduledTaskTrigger -Daily -At 6pm
$sAction = New-ScheduledTaskAction -Execute "git.exe" -Argument '-C "c:\projects\dotfiles" pull --verbose'
$taskName = "pull dotfiles"
Register-ScheduledTask -Action $sAction -TaskName $taskName -TaskPath $env:USERNAME -Trigger $startTrigger

# Reload Powershell profile
. $PROFILE