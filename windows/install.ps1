# Create symbolic links
New-Item -Type SymbolicLink -Path $PROFILE -Value .\Microsoft.Powershell_profile.ps1 -Force
New-Item -Type SymbolicLink -Path $env:USERPROFILE\.gitconfig -Value .\.gitconfig -Force
New-Item -Type SymbolicLink -Path $env:USERPROFILE\.gitignore_global -Value .\.gitignore_global -Force

# Reload Powershell profile
. $PROFILE