#!/bin/bash
export WINHOME=$(wslpath $(powershell.exe -NoProfile 'Write-Host $env:USERPROFILE'))

sudo cp -r $WINHOME/.ssh ~
sudo chown `whoami` .ssh --recursive
sudo chmod 400 ~/.ssh/id_rsa

eval `ssh-agent`
ssh-add


sudo apt update -y
sudo apt-get install mc -y
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"