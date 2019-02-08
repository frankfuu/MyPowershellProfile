#!/bin/bash

# find the windows equiv path of the Window's logged in user e.g. /mnt/c/Users/Frank
WINHOME=$(wslpath $(powershell.exe -NoProfile 'Write-Host $env:USERPROFILE'))

# copy contents of Window's .ssh folder to WSL's ssh folder, take ownership and set correct permissions
sudo cp -r $WINHOME/.ssh ~
sudo chown `whoami` ~/.ssh --recursive
chmod 400 ~/.ssh/id_rsa