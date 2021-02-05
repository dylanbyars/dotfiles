export PATH=$HOME/.bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/nnb479/.oh-my-zsh"

# Set name of the theme to load 
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git thefuck colored-man-pages)

source $ZSH/oh-my-zsh.sh

# User configuration

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.


# NOTE: the proxy only applies to the shell it's running in


# navigate to client
alias client='cd ~/code/client'


# NOTE: api throws this error if the proxy isn't running in the same shell as api
# ```
# Caught an error: read ECONNRESET Error: read ECONNRESET
#    at TLSWrap.onStreamRead (internal/stream_base_commons.js:111:27)
# ```
alias api='cd ~/code/api && cpd' 

# un-fuck cntlm proxy when you get a "Error: tunneling socket could not be established, statusCode=502" error on the app's login page
# NOTE: I don't really use cntlm so I may be able to get rid of this.
alias ufp="sudo pkill cntlm; source ~/.zprofile"

# un-fuck xcode after doing any software update
alias ufx="sudo rm -rf $(xcode-select --print-path)"

# COF root certificates for yarn
export NODE_EXTRA_CA_CERTS=$HOME/.local/etc/ssl/certs/COF.pem

# nvm stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

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
