# Remove symbolic links
Remove-Item $PROFILE -Force -ErrorAction SilentlyContinue
Remove-Item $env:USERPROFILE\.gitconfig -Force -ErrorAction SilentlyContinue
Remove-Item $env:USERPROFILE\.gitignore_global -Force -ErrorAction SilentlyContinue
Remove-Item $env:USERPROFILE\.hyper.js  -Force -ErrorAction SilentlyContinue
Remove-Item $env:USERPROFILE\audioscript.ahk  -Force -ErrorAction SilentlyContinue

Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\audioscript.exe"  -Force -ErrorAction SilentlyContinue

# Unregister periodic pull
$taskName = "pull dotfiles"
if(Get-ScheduledTask $taskName -ErrorAction Ignore)  {  
    Write-Host "Removing scheduled task : $taskname"
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false    
}
else {
    Write-Host "Task name : $taskName not found. Skipping removal"    
}