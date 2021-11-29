export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/go/bin:$HOME/bin:/usr/libexec:/home/$USER/.deno/bin:$PATH

export EDITOR=/usr/local/bin/nvim

alias vim='nvim'

nukeswap() {
  rm -rf ~/.local/share/nvim/swap
}

alias zz='exec zsh'

# source broot
source $HOME/.config/broot/launcher/bash/br
alias z='br'
alias Z='br -h' # include hidden files

# customize the style of fzf and accept an optional header
fzfancy() {
  fzf --reverse --height=20 --border=rounded --header=$1
}

# git
alias g='git'
alias gco='git checkout'
alias lz='lazygit'
# fzf a branch
alias gb="git for-each-ref --format='%(refname:short)' refs/heads | fzfancy 'Git Branches'"
# checkout a fuzily-found branch
alias gcob="gb | xargs git checkout"
# checkout a fuzily-found branch (including remotes)
# alias gcorb="git checkout --track $(git branches | fzf)"
# set the branch to compare checkedout branches with (for PR reviews). use with `g review`
export REVIEW_BASE="main"
review() {
  # type `review`
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
  reviewBranch=$(g branches | tr -d '* ' | fzfancy 'Review Branch')
  echo "Review Branch -> $reviewBranch"
  targetBranch=$(g branches | tr -d '* ' | fzfancy 'Target Branch')
  echo "Target Branch -> $targetBranch\n"

  # TODO: what if I don't have the target branch locally?
  echo "Updating local version of $targetBranch"
  # don't care about successful output of these
  git checkout -b $targetBranch 1>/dev/null
  git pull 1>/dev/null

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
# alias ufx="sudo xcode-select --reset" -- thought this would work but it didn't
ufx() {
  echo 'removing xcode-select tools'
  sudo rm -rf $(xcode-select --print-path)
  echo 'reinstalling xcode-select'
  xcode-select --install
}

# exa -- f is easy to type :shrug:
alias f="exa --long --header"
alias ff="exa --long --header --all"
alias F="exa --tree --level 2"

# mktouch -- mkdirs to a new file if the path doesn't exist
# $1 = `path/to/new/file.txt` and new file is called `file.txt`
mktouch() {
  mkdir -p "$(dirname "$1")" && touch "$1"
}

# view all globally installed npm packages
alias globalPackages="npm ls -g --depth=0"

# I'll put completion files in ~/.zsh
fpath=(~/.zsh $fpath)
autoload -Uz compinit
compinit -u

source_plugin() {
  PLUGIN_NAME=$1
  source $HOME/.zsh/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh
}

# Replace zsh's default completion selection menu with fzf
# NOTE: fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting!!
source_plugin fzf-tab

# nvm (node version manager)
export NVM_COMPLETION=true
export NVM_AUTO_USE=true
source_plugin zsh-nvm

# npm completions
source_plugin zsh-better-npm-completion

# Vim mode improved
source_plugin zsh-vi-mode

# start fancy prompt
eval "$(starship init zsh)"

# zoxide helpers
eval "$(zoxide init zsh)"

# colorful man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
