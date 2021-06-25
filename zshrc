export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# open scratch.md doc in vscode
alias scratch="code ~/scratch.md"


# NOTE: the proxy only applies to the shell it's running in


# navigate to client
alias client="cd ~/code/client"


# NOTE: api throws this error if the proxy isn't running in the same shell as api
# ```
# Caught an error: read ECONNRESET Error: read ECONNRESET
#    at TLSWrap.onStreamRead (internal/stream_base_commons.js:111:27)
# ```
alias api='cd ~/code/api && cpd'

# fzf a branch
alias gcob="git for-each-ref --format='%(refname:short)' refs/heads | fzf | xargs git checkout"

# un-fuck cntlm proxy when you get a "Error: tunneling socket could not be established, statusCode=502" error on the app's login page
# NOTE: I don't really use cntlm so I may be able to get rid of this.
alias ufp="sudo pkill cntlm; source ~/.zprofile"

# un-fuck xcode after doing any software update
# remove xcode-select then reinstall it
alias ufx="sudo rm -rf $(xcode-select --print-path) && xcode-select --install"

# ls
alias l="ls -oGF" # long format, colorized, with item type info (symlink, directory, etc...)
alias ll="ls -aoGF" # same as ^ but include hidden files

# COF root certificates for yarn
export NODE_EXTRA_CA_CERTS=$HOME/.local/etc/ssl/certs/COF.pem

# nvm stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# call `nvm use` on directory navigation
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# start fancy prompt
eval "$(starship init zsh)"

# start the best script ever
eval $(thefuck --alias)
