#!/bin/bash

function today() {
  # Check if the directories expected exist. If not, create them.
  if [[ ! -d ~/today ]]; then
    mkdir -p ~/today
  fi

  cd ~/today

  # if <yesterday>.md is not in the git history, summarize and commit it
  yesterday=$(date -v-1d "+%Y-%m-%d")
  if [[ -z $(git log --oneline -- $yesterday.md) ]]; then
    # TODO: work on the prompt and explore other models. I want this succinct and fast (or done in the background?)
    # summary=$(ollama run mistral:instruct "summarize this into 1 sentence. only include the most important things: $(cat $yesterday.md)")
    git add $yesterday.md
    git commit -m "$yesterday"
  fi

  today=$(date "+%Y-%m-%d")
  vim $today.md
}
