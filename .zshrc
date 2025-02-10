export PATH=$HOME/opt/testing/nvim-macos-arm64/bin/:/Users/paul/opt/:/Users/paul/opt/sratoolkit.3.0.10-mac-x86_64/bin/:$PATH
export ZSH="$HOME/.oh-my-zsh"

# zsh themes
ZSH_THEME="robbyrussell"
plugins=(git fast-syntax-highlighting)
ZVM_VI_ESCAPE_BINDKEY=jj
plugins+=(zsh-vi-mode)
source $ZSH/oh-my-zsh.sh

# aliases
alias rocky="ssh rocky"
alias dt225="ssh dt225"
alias sc="cd /Users/paul/scratch/"

# clipboard
pb-kill-line () {
  zle kill-line
  echo -n $CUTBUFFER | pbcopy
}

pb-kill-whole-line () {
  zle kill-whole-line
  echo -n $CUTBUFFER | pbcopy
}

pb-backward-kill-word () {
  zle backward-kill-word
  echo -n $CUTBUFFER | pbcopy
}

pb-kill-word () {
  zle kill-word
  echo -n $CUTBUFFER | pbcopy
}

pb-kill-buffer () {
  zle kill-buffer
  echo -n $CUTBUFFER | pbcopy
}

pb-copy-region-as-kill-deactivate-mark () {
  zle copy-region-as-kill
  zle set-mark-command -n -1
  echo -n $CUTBUFFER | pbcopy
}

pb-yank () {
  CUTBUFFER=$(pbpaste)
  zle yank
}

zle -N pb-kill-line
zle -N pb-kill-whole-line
zle -N pb-backward-kill-word
zle -N pb-kill-word
zle -N pb-kill-buffer
zle -N pb-copy-region-as-kill-deactivate-mark
zle -N pb-yank

bindkey '^K'   pb-kill-line
bindkey '^U'   pb-kill-whole-line
bindkey '\e^?' pb-backward-kill-word
bindkey '\e^H' pb-backward-kill-word
bindkey '^W'   pb-backward-kill-word
bindkey '\ed'  pb-kill-word
bindkey '\eD'  pb-kill-word
bindkey '^X^K' pb-kill-buffer
bindkey '\ew'  pb-copy-region-as-kill-deactivate-mark
bindkey '\eW'  pb-copy-region-as-kill-deactivate-mark
bindkey '^Y'   pb-yank


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/paul/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/paul/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/Users/paul/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/Users/paul/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/paul/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/Users/paul/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


# starship
eval "$(starship init zsh)"
export PATH=/Users/paul/edirect:${PATH}
source <(fzf --zsh)

# should move this to plugins
#source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Normal mode
function append-last-word { ((++CURSOR)); zle insert-last-word; }
zle -N append-last-word
bindkey -M vicmd '\e.' append-last-word

# following required as zvm breaks yank last argument
# Insert mode
bindkey -M viins '\e.' insert-last-word

# Insert mode
bindkey -M viins '\e\b' backward-kill-word    # Alt + Backspace
bindkey -M viins '^[^?' backward-kill-word    # Alternative binding that might be needed

# Normal mode (if you want it there too)
#bindkey -M vicmd '\e\b' backward-kill-word
#bindkey -M vicmd '^[^?' backward-kill-word

. "$HOME/.atuin/bin/env"

bindkey -r '^R'

eval "$(atuin init zsh --disable-up-arrow)"
#bindkey '^r' atuin-search

## bind to the up key, which depends on terminal mode
#bindkey '^[[A' atuin-up-search
#bindkey '^[OA' atuin-up-search

# Define a function to set up Atuin bindings
function zvm_after_init() {
    # Bind for both vi insert and normal modes
    bindkey -M viins '^r' atuin-search
    bindkey -M vicmd '^r' atuin-search
    
    # Up arrow bindings for both modes
#    bindkey -M viins '^[[A' atuin-up-search
#    bindkey -M viins '^[OA' atuin-up-search
#    bindkey -M vicmd '^[[A' atuin-up-search
#    bindkey -M vicmd '^[OA' atuin-up-search
}

function zvm_vi_yank() {
	zvm_yank
	echo ${CUTBUFFER} | pbcopy
	zvm_exit_visual_mode
}

