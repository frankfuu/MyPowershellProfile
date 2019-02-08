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