# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias l='ls -lah'
alias sc='cd /mnt/shared/scratch/pjohnsto/'
alias sq='squeue --me'
alias ll='ls -lrtha'
alias nvim='//mnt/apps/users/pjohnsto/nvim.appimage'
alias ..='cd ../'
alias rm=rm
alias gcl='git clone --recurse-submodules'
alias ga='git add'
alias gcmsg='git commit --message'
alias ggp='git push'
alias gl='git pull'
alias gst='git status'

. "$HOME/.cargo/env"

export PATH=/mnt/apps/users/pjohnsto/bin/:$PATH

export TERM=xterm-256color

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/mnt/apps/users/pjohnsto/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/mnt/apps/users/pjohnsto/conda/etc/profile.d/conda.sh" ]; then
        . "/mnt/apps/users/pjohnsto/conda/etc/profile.d/conda.sh"
    else
        export PATH="/mnt/apps/users/pjohnsto/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Enable case-insensitive tab completion
bind "set completion-ignore-case on"

# Show all matches if there's ambiguity
bind "set show-all-if-ambiguous on"

# Add trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

# Show extra file information when completing
bind "set visible-stats on"

# Larger history file
HISTSIZE=50000
HISTFILESIZE=50000

# Don't duplicate lines or lines starting with space
HISTCONTROL=ignoreboth

# Append to history file rather than overwrite
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Update history after each command
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

eval "$(starship init bash)"
export STARSHIP_CONFIG=/mnt/apps/users/pjohnsto/config/starship.toml
