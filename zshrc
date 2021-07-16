

alias vim='nvim'

export EDITOR=/usr/local/bin/nvim

# push ssh key to bastion host
alias pk="~/bin/push-ssh-key.exp ~/.ssh/id_rsa.pu"
# connect to the bastion host (enable DB connection)


# NOTE: the proxy only applies to the shell it's running in


# navigate to client
alias client="cd ~/code/client"

# navigate to api and get it ready to run
function api() {
  cd ~/code/api # go to project

  # confirm docker is setup to support the application OR set it up
  function startContainer() {
    docker-compose up -d sessiondb 2> /dev/null
  }

  startContainer

  # if the `startContainer` command fails, try starting Docker Desktop then run `startContainer` again
  if [[ $? -ne 0 ]]; then
    echo "Docker is not running. Starting Docker Desktop..."
    open -a Docker
    echo "Press [ENTER} to continue once Docker Desktop is ready."
    read
    startContainer
    if [[ $(docker ps --filter "name=api" | wc -l) -eq 2 ]]; then
      echo "dynamodb container started."
    fi
  fi
}

# git
alias g='git'
# fzf git aliases
alias ga="git aliases | fzf"

# fzf a branch
alias gcob="git for-each-ref --format='%(refname:short)' refs/heads | fzf | xargs git checkout"

# un-fuck xcode after doing any software update
# remove xcode-select then reinstall it
alias ufx="sudo rm -rf $(xcode-select --print-path) && xcode-select --install"

# ls
alias l="ls -oGF"   # long format, colorized, with item type info (symlink, directory, etc...)
alias ll="ls -aoGF" # same as ^ but include hidden files

# COF root certificates for yarn
export NODE_EXTRA_CA_CERTS=$HOME/.local/etc/ssl/certs/COF.pem

# nvm (node version manager) using [this plugin](https://github.com/lukechilds/zsh-nvm)
export NVM_COMPLETION=true
export NVM_AUTO_USE=true
source ~/.zsh-nvm/zsh-nvm.plugin.zsh

# awscli
alias awsToken="cloudsentry access get --ba ASVUNITEDINCOME --all --force"
# auto completion -- https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
# TODO: learn about compinit
compinit
complete -C '/usr/local/bin/aws_completer' aws

# start fancy prompt
eval "$(starship init zsh)"

# start the best script ever
eval $(thefuck --alias)
