#!/bin/bash

# if current system is WSL then copy wsl.conf from repo to /etc/wsl.conf
if [[ "$OSTYPE" != "darwin"* ]] && grep -q Microsoft /proc/version; then
    
    if [ ! -e /etc/wsl.conf ]; then 
        echo "/etc/wsl.conf does not exist, copying now"
        sudo cp wsl-only/wsl.conf /etc/wsl.conf
        echo "Copy success  "
        echo "Please close all WSL Windows and open Powershell as Administrator and execute"
        echo "Get-Service LxssManager | Restart-Service"
        echo "Then re run this script"
        exit 1
        # powershell.exe "Get-Service LxssManager | Restart-Service"
    fi
fi

# install ZSH shell if not found
if [[ "$OSTYPE" != "darwin"* ]] && [ ! -x "$(command -v zsh)" ]; then 
    echo zsh not found, installing it now ...
    sudo apt update
    sudo apt install zsh -y
fi

# install oh-my-zsh if not found
if [ ! -e "$HOME/.oh-my-zsh" ]; then
    echo oh-my-zsh not found, installing now ..
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# install FZF if not found
if [ ! -x "$(command -v fzf)" ]; then 
    echo fzf not found, installing it now ...
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

# install playerctl if not found
if [[ "$OSTYPE" != "darwin"* ]] && [ ! -x "$(command -v playerctl)" ]; then 
    echo playerctl not found, installing it now ...
		sudo apt install playerctl
fi


# finally add symlinks
./install.sh

# change default shell to ZSH
sudo chsh -s $(which zsh) $USER

# Setup crontab to run every hour fetch updates from remote git repo 
(crontab -l ; echo "1 * * * * sh /home/frank/projects/dotfiles/ubuntu/cron_pull.sh >/dev/null 2>&1") | sort - | uniq - | crontab -
