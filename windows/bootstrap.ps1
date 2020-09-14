Get-Service ssh-agent | Set-Service -StartupType Automatic;
Get-Service ssh-agent | Start-Service;
git clone https://github.com/frankfuu/dotfiles.git;
cd dotfiles;
git remote set-url origin git@github.com:frankfuu/dotfiles.git
.\install.ps1