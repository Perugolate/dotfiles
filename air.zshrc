source ~/.promptline.sh
# Path to your oh-my-zsh installation.
export ZSH="/Users/pauljohnston/.oh-my-zsh"

ZSH_THEME="robbyrussell"

COMPLETION_WAITING_DOTS="true"

# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting command-not-found dirhistory dirpersist)

source $ZSH/oh-my-zsh.sh

# prompts
PS1='%n@%m:$ '
RPROMPT='%~'
setopt interactivecomments
export EDITOR='nvim'

# improve the highlighting for directories and globbing
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='bold'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# from https://github.com/pyenv/pyenv/issues/1948#issuecomment-848954350
eval "$(pyenv init -)"

alias l='exa --sort newest -l'
alias e='exa -l'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/pauljohnston/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pauljohnston/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/pauljohnston/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pauljohnston/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

