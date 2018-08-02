# To use Powershelll Profile

Note - this will install modules like `GetSTFolderSize`
```
git clone https://github.com/frankfuu/dotfiles.git
cd dotfiles
cp .\Microsoft.Powershell_profile.ps1 -Destination $PROFILE
```

# To customize Conemu themes
https://github.com/joonro/ConEmu-Color-Themes
My favourite is Dracula

# Install other 

Chocolatey
```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

