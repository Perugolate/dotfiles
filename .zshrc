export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting command-not-found dirhistory dirpersist)
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
source $ZSH/oh-my-zsh.sh
PS1='%n@%m:$ '
RPROMPT='%~'
setopt interactivecomments
export EDITOR='nvim'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='bold'
source home/paul/.shell_prompt.sh
