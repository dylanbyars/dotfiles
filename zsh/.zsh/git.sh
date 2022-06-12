# git
alias g='git'
alias gco='git checkout'
# pr viewer
alias gpr="gh dash"
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
