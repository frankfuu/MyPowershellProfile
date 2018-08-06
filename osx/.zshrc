# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


ZSH_THEME="ys"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
  git
  colored-man-pages
  ssh-agent
)

source $ZSH/oh-my-zsh.sh

# Aliases

alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# Completions 

# zsh parameter completion for the dotnet CLI

_dotnet_zsh_complete() 
{
  local dotnetPath=$words[1]

  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet


