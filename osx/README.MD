## Setup

- Iterm2
- Brew
- Zsh
- Oh-My-Zsh

### Themes for Iterm2 - from [Martin Seeler](https://github.com/MartinSeeler/iterm2-material-design)
1. Clone the `.itermcolors` file
```
# see https://github.com/MartinSeeler/iterm2-material-design
curl -O https://raw.githubusercontent.com/MartinSeeler/iterm2-material-design/master/material-design-colors.itermcolors
```
2. *iTerm2 > Preferences > Profiles > Colors Tab*
3. Click *Color Presets...*
4. Click *Import...*
5. Select the `material-design-colors.itermcolors` file
5. Select the *material-design-colors* from *Load Presets...*


## Tab completions for Azure CLI on Zsh . 
https://stackoverflow.com/questions/49273395/how-to-enable-command-completion-for-azure-cli-in-zsh
Info - I installed Azure CLI using [brew as described here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-macos?view=azure-cli-latest)
1. Find path to completion file (mine was in /usr/local/etc/bash_completion.d/az)
2. Enable bash autocompletions in zsh (if it's not enabled already) [1]: 
`autoload -U +X bashcompinit && bashcompinit`
3. `source /path/to/az.completion` (you will likely want this in your startup file for zsh also).
