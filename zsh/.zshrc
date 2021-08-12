

export EDITOR=/usr/local/bin/nvim

alias vim='nvim'

alias zz='source ~/.zshrc'

# git
alias g='git'
alias gco='git checkout'
alias lz='lazygit'
# fzf git aliases
alias ga="git aliases | fzf"
# fzf a branch
alias gcob="git for-each-ref --format='%(refname:short)' refs/heads | fzf | xargs git checkout"
export REVIEW_BASE="develop"

# un-fuck xcode after doing any software update
# remove xcode-select then reinstall it
alias ufx="sudo rm -rf $(xcode-select --print-path) && xcode-select --install"

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

