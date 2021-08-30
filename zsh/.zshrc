

export EDITOR=/usr/local/bin/nvim

alias vim='nvim'

alias zz='source ~/.zshrc'

alias rr='ranger'

# git
alias g='git'
alias gco='git checkout'
alias lz='lazygit'
# fzf git aliases
alias ga="git aliases | fzf"
# fzf a branch
alias gcob="git for-each-ref --format='%(refname:short)' refs/heads | fzf | xargs git checkout"

# ls
alias ls="ls -GF" # regular format + colorized + item type info
alias l="ls -oGF"   # long format, colorized, with item type info (symlink, directory, etc...)
alias ll="ls -aoGF" # same as ^ but include hidden files

# mktouch -- mkdirs to a new file if the path doesn't exist
# $1 = `path/to/new/file.txt` and new file is called `file.txt`
function mktouch() {
  mkdir -p "$(dirname "$1")" && touch "$1"
}

# nvm (node version manager) using [this plugin](https://github.com/lukechilds/zsh-nvm)
# export NVM_COMPLETION=true
# export NVM_AUTO_USE=true
# source ~/.zsh/zsh-nvm/zsh-nvm.plugin.zsh

# view all globally installed npm packages
alias globalPackages="npm ls -g --depth=0"

# Vim mode improved with [this plugin](https://github.com/jeffreytse/zsh-vi-mode)
source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# start fancy prompt
eval "$(starship init zsh)"

# colorful man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
