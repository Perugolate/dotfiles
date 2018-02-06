export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting command-not-found dirhistory dirpersist)
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/home/paul/.local/bin:$PATH"
source $ZSH/oh-my-zsh.sh
alias vimdiff='nvim -d'
PS1='%n@%m:$ '
RPROMPT='%~'
setopt interactivecomments
export EDITOR='nvim'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='bold'
source /home/paul/.shell_prompt.sh
