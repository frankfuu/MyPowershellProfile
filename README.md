# To use Powershelll Profile

Find path to `$PROFILE`
```
echo $PROFILE
```

Paste contents of `Microsoft.Powershell_profile.ps1` to the result printed above

# To customize Conemu themes
https://github.com/joonro/ConEmu-Color-Themes
My favourite is Dracula

# Install other 

Chocolatey
```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

