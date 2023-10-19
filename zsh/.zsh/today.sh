#!/bin/zsh

function today() {
    # Check if the directories expected exist. If not, create them.
    if [[ ! -d ~/today ]]; then
        mkdirp ~/today
    fi

    # Check if today.md exists
    if [[ -f ~/today/today.md ]]; then
        # Get yesterday's date
        yesterday=$(date -v-1d "+%Y-%m-%d")
        # Move today.md to <day-before-today>.md
        mv ~/today/today.md ~/today/${yesterday}.md
    fi

    # Create and open a new today.md
    vim ~/today/today.md
}


