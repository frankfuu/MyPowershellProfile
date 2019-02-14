#!/bin/bash

# if current system is WSL then copy wsl.conf from repo to /etc/wsl.conf
if grep -q Microsoft /proc/version; then
    
    if [ ! -e /etc/wsl.conf ]; then 
        echo "/etc/wsl.conf does not exist, copying now"
        sudo cp wsl-only/wsl.conf /etc/wsl.conf
        echo "copy success - Please close all WSL Windows and open Powershell as Administrator and execute "
        echo "Get-Service LxssManager | Restart-Service"
        exit 1
        # powershell.exe "Get-Service LxssManager | Restart-Service"
    fi
fi

# install ZSH shell if not found
if [ ! -x "$(command -v zsh)" ]; then 
    echo zsh not found, installing it now ...; 
    sudo apt update
    sudo apt install zsh -y
fi

# install oh-my-zsh if not found
if [ ! -e "$HOME/.oh-my-zsh" ]; then
    echo oh-my-zsh not found, installing now
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# finally add symlinks
./install.sh