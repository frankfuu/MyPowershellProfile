# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ys"

plugins=(
  git 
  docker
  colored-man-pages
  ssh-agent
	command-not-found
	vagrant
)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_exports
source $HOME/.zsh_aliases
source $HOME/.zsh_functions

# If System is WSL, source WSL only exports 
# Need to check not in MacOS first as /proc/version does not exist in MacOS
if [[ "$OSTYPE" != "darwin"* ]] && grep -q Microsoft /proc/version; then
  source $HOME/.zsh_wsl_exports
fi

# https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then		
        ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
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

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
