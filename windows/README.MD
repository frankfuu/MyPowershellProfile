## Windows Terminal settings
Refer to these two documents
- [Summary](https://github.com/microsoft/terminal/blob/master/doc/user-docs/UsingJsonSettings.md)
- [Detailed](https://github.com/microsoft/terminal/blob/master/doc/cascadia/SettingsSchema.md) 
  
  
### Setting up sshd using OpenSSh
```
cd 'C:\Program Files\OpenSSH-Win64\'
.\install-sshd.ps1
```

### Setting Powershell as the default shell for `sshd` using OpenSSH
```
https://github.com/PowerShell/Win32-OpenSSH/wiki/DefaultShell

New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShellCommandOption -Value "/c" -PropertyType String -Force
``` 
