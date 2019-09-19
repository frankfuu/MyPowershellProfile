
# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install dev essentials
brew cask install visual-studio-code
brew cask install virtualbox 
brew cask install vagrant
brew cask install vagrant-manager
brew cask install iterm2

# add basic vagrant boxes
vagrant box add ubuntu/xenial64
vagrant box add yzgyyang/macOS-10.14