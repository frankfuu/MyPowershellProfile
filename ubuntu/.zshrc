# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
  git  
  ssh-agent
  colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias dkr="docker-compose"
alias dc="docker-compose"
alias reload="source .zshrc"

