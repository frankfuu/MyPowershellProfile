# Remove symbolic links
Remove-Item $PROFILE -Force -ErrorAction SilentlyContinue
Remove-Item $env:USERPROFILE\.gitconfig -Force -ErrorAction SilentlyContinue
Remove-Item $env:USERPROFILE\.gitignore_global -Force -ErrorAction SilentlyContinue
Remove-Item $env:USERPROFILE\.hyper.js  -Force -ErrorAction SilentlyContinue
Remove-Item $env:USERPROFILE\audioscript.ahk  -Force -ErrorAction SilentlyContinue
Remove-Item $env:USERPROFILE\my-ps-modules\FrankModules.ps1 -Force -ErrorAction SilentlyContinue

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

# Unregister audioscript
$taskName2 = "run audioscript upon login"
if(Get-ScheduledTask $taskName2 -ErrorAction Ignore)  {  
    Write-Host "Removing scheduled task : $taskName2"
    Unregister-ScheduledTask -TaskName $taskName2 -Confirm:$false    
}
else {
    Write-Host "Task name : $taskName2 not found. Skipping removal"    
}