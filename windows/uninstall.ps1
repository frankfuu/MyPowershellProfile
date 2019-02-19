# Remove symbolic links
Remove-Item $PROFILE
Remove-Item $env:USERPROFILE\.gitconfig
Remove-Item $env:USERPROFILE\.gitignore_global

# Unregister periodic pull
$taskName = "pull dotfiles"
Unregister-ScheduledTask -TaskName $taskName -Confirm:$false