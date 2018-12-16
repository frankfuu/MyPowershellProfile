# Add a new Powershell Profile symlink to this repo and reload.
New-Item -Type SymbolicLink -Path $PROFILE -Value .\windows\Microsoft.Powershell_profile.ps1 -Force
. $PROFILE
