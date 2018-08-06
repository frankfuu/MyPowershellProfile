export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ys"

plugins=(
  git
  colored-man-pages
  ssh-agent
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

## Completions 

# dotnet CLI
_dotnet_zsh_complete() 
{
  local dotnetPath=$words[1]

  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}
compctl -K _dotnet_zsh_complete dotnet

# Azure CLI
autoload -U +X bashcompinit && bashcompinit
source /usr/local/etc/bash_completion.d/az
