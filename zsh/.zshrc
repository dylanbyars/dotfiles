

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
function review() {
  # type review
  # prompt to checkout remote branch I want to review
  # prompt to set merge target
  # show stats of merge
  # open nvim so that every changed file is:
  # 1. in its own tab
  # 2. connected to the language server
  # 3. arranged so that the target branch is on the left and the review branch is on the right
  #
  # learn about remote branches
  git fetch
  # checkout branch to review or use current branch
  # TODO: colors!
  reviewBranch=$(g branches | tr -d '* ' | fzf 'Review Branch')
  echo "Review Branch -> $reviewBranch"
  targetBranch=$(g branches | tr -d '* ' | fzf 'Target Branch')
  echo "Target Branch -> $targetBranch\n"

  # TODO: what if I don't have the target branch locally?
  echo "Updating local version of $targetBranch"
  # don't care about successful output of these
  git checkout $targetBranch 1> /dev/null
  git pull 1> /dev/null

  echo "Checking out $reviewBranch\n"
  git checkout --track $reviewBranch

  mergeBase=$(git merge-base HEAD $targetBranch)
  echo "\nMerge base = $mergeBase\n"

  echo "$targetBranch <-- $reviewBranch"

  # print summary of changes
  git diff --stat $mergeBase

  echo "\n Ready to review?"
  read
  g review $targetBranch
}

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

