# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ys"

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

# If System is WSL, source WSL only exports
if grep -q Microsoft /proc/version; then
  source $HOME/.zsh_wsl_exports
fi

# Load fzf if installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# references
# https://www.hanselman.com/blog/WebDevelopmentAndAdvancedTechniquesWithLinuxOnWindowsWSL.aspx
# https://www.hanselman.com/blog/SettingUpAShinyDevelopmentEnvironmentWithinLinuxOnWindows10.aspx
# https://www.hanselman.com/blog/TheYearOfLinuxOnTheWindowsDesktopWSLTipsAndTricks.aspx


## Turn off all beeps
unsetopt BEEP

