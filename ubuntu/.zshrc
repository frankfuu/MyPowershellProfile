# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ys"

plugins=(
  git 
  docker
  colored-man-pages
  ssh-agent
	command-not-found
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_exports
source $HOME/.zsh_aliases
source $HOME/.zsh_functions

# If System is WSL, source WSL only exports
if grep -q Microsoft /proc/version; then
  source $HOME/.zsh_wsl_exports
fi

# https://gnunn1.github.io/tilix-web/manual/vteconfig/
# Might also need to add a missing symlink in ubuntu 16.04+ e.g.
# ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
				sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
        source /etc/profile.d/vte.sh
fi

# Load fzf if installed
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# references
# https://www.hanselman.com/blog/WebDevelopmentAndAdvancedTechniquesWithLinuxOnWindowsWSL.aspx
# https://www.hanselman.com/blog/SettingUpAShinyDevelopmentEnvironmentWithinLinuxOnWindows10.aspx
# https://www.hanselman.com/blog/TheYearOfLinuxOnTheWindowsDesktopWSLTipsAndTricks.aspx


## Turn off all beeps
unsetopt BEEP

