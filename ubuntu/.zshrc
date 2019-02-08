# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="af-magic"

plugins=(
  git 
  docker
  colored-man-pages
  aws
  ssh-agent
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_exports
source $HOME/.zsh_aliases

# references
# https://www.hanselman.com/blog/WebDevelopmentAndAdvancedTechniquesWithLinuxOnWindowsWSL.aspx
# https://www.hanselman.com/blog/SettingUpAShinyDevelopmentEnvironmentWithinLinuxOnWindows10.aspx
# https://www.hanselman.com/blog/TheYearOfLinuxOnTheWindowsDesktopWSLTipsAndTricks.aspx