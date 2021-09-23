

export EDITOR=/usr/local/bin/nvim

alias vim='nvim'
function nukeswap() {
  rm -rf ~/.local/share/nvim/swap
}

alias zz='source ~/.zshrc'

# customize default style of fzf and accept an optional header
# NOTE: absolute path to fzf bin is on purpose
function fzf() { /usr/local/bin/fzf --reverse --height=20 --border=rounded --header=$1 }

# git
alias g='git'
alias gco='git checkout'
alias lz='lazygit'
# fzf git aliases
alias ga="git aliases | fzf 'Git Aliases'"
# fzf a branch
alias gb="git for-each-ref --format='%(refname:short)' refs/heads | fzf 'Git Branches'"
# checkout a fuzily-found branch
alias gcob="gb | xargs git checkout"
# checkout a fuzily-found branch (including remotes)
# alias gcorb="git checkout --track $(git branches | fzf)"
# set the branch to compare checkedout branches with (for PR reviews). use with `g review`
export REVIEW_BASE="digital-identity"

# un-fuck xcode after doing any software update
# remove xcode-select then reinstall it
# alias ufx="sudo rm -rf $(xcode-select --print-path) && xcode-select --install"
alias ufx="sudo xcode-select --reset"

# ls
alias ls="ls -GF" # regular format + colorized + item type info
alias l="ls -oGF"   # long format, colorized, with item type info (symlink, directory, etc...)
alias ll="ls -aoGF" # same as ^ but include hidden files

# mktouch -- mkdirs to a new file if the path doesn't exist
# $1 = `path/to/new/file.txt` and new file is called `file.txt`
function mktouch() {
  mkdir -p "$(dirname "$1")" && touch "$1"
}

# a collection of scripts used for Capital One Investing development


# nvm (node version manager) using [this plugin](https://github.com/lukechilds/zsh-nvm)
export NVM_COMPLETION=true
export NVM_AUTO_USE=true
source ~/.zsh/zsh-nvm/zsh-nvm.plugin.zsh

# view all globally installed npm packages
alias globalPackages="npm ls -g --depth=0"

# Vim mode improved with [this plugin](https://github.com/jeffreytse/zsh-vi-mode)
source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# start fancy prompt
eval "$(starship init zsh)"

