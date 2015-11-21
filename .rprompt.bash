#!/bin/bash
#
# from https://gist.github.com/1285149.git


__rprompt() {
    printf "%*s\r" "$COLUMNS" "$(eval echo "$RPROMPT")"
}

if [[ ! $PROMPT_COMMAND =~ __rprompt ]]; then
    export PROMPT_COMMAND="__rprompt; ${PROMPT_COMMAND:-:}"
fi
