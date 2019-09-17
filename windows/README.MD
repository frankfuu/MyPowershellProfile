## Powershell Window settings
- Colors
  - Screen text : Red 255, Green 200
  - Screen background : Black
- Font 
  - Size 15
  - Font Consolas
  
  
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
