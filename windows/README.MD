## Windows Terminal settings
Refer to these two documents
- [Summary](https://github.com/microsoft/terminal/blob/master/doc/user-docs/UsingJsonSettings.md)
- [Detailed](https://github.com/microsoft/terminal/blob/master/doc/cascadia/SettingsSchema.md) 

Example
```


"defaultProfile": "{07b52e3e-de2c-5db4-bd2d-ba144ed6c273}", // Ubuntu 20.04


"defaults": {
        // Put settings here that you want to apply to all profiles.
        "cursorColor": "#ff9900", // make cursor a orangey color
        "cursorShape": "filledBox", // make cursor a blinking block
        "fontSize": 12
      },


"keybindings":
    [
        { "command": { "action": "splitPane", "split": "horizontal", "splitMode": "duplicate" }, "keys": "ctrl+shift+h" },
        { "command": { "action": "splitPane", "split": "vertical", "splitMode": "duplicate" }, "keys": "ctrl+shift+j" }
    ]      


```
  
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
