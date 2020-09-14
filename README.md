One liner install for Windows
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/frankfuu/dotfiles/master/windows/bootstrap.ps1')); cd windows; .\install.ps1
```

Debugging Git configs:
```
git config --list --show-origin
```

