export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/homebrew/bin:/usr/local/go/bin:$HOME/bin:/usr/libexec:/home/$USER/.deno/bin:$HOME/.local/bin:$PATH

export EDITOR=/usr/local/bin/nvim

export DELTA_PAGER="less -r"

alias vim='nvim'

nukeswap() {
  rm -rf ~/.local/state/nvim/swap/
}

alias zz='exec zsh'

# source broot
source $HOME/.config/broot/launcher/bash/br
alias /='br'

# go edit my dotfiles
alias dot="cd ~/dotfiles && vim"

# go to 
alias org="cd ~/org"

# customize the style of fzf and accept an optional header
fzfancy() {
  fzf --reverse --height=20 --border=rounded --header=$1
}

# git stuff
source ~/.zsh/git.sh

# lazygit
alias lz='lazygit -ucf ~/.config/lazygit/config.yml' # -ucf === use-config-file
# lazydocker
alias ld='lazydocker'

# (mac only)
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

# Function to check if the current directory is a Poetry project
is_poetry_project() {
  [[ -f "pyproject.toml" ]] && grep -q '\[build-system\]' "pyproject.toml"
}

# Function to activate Poetry virtual environment
activate_poetry_env() {
  echo "Activating Poetry virtual environment..."
  VENV_PATH=$(poetry env info --path)
  source $VENV_PATH/bin/activate
}

# Function to activate Node.js LTS version
activate_node_lts() {
  echo "Activating Node.js LTS version..."
  nvm use --lts
}

# Main function that gets called whenever you navigate to a new directory
auto_activate() {
  if is_poetry_project; then
    activate_poetry_env
    activate_node_lts
  fi
}

# Hook the function to the 'chpwd' event, which triggers whenever you change directory
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate


# I'll put completion files in ~/.zsh
fpath=(~/.zsh $fpath)
autoload -Uz compinit
compinit -u

#
# plugins
#

# nvm -> node version manager
export NVM_COMPLETION=true
export NVM_NO_USE=true
export NVM_LAZY_LOAD=true

# fzf-tab -> Replace zsh's default completion selection menu with fzf
# NOTE: fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting!!

function() {
  # setup a ~/.zsh dir if it doesn't already exist
  if [[ ! -d ~/.zsh ]]; then
    # make a directory to house the plugins
    mkdir ~/.zsh/ 
  fi

  local PLUGINS=('lukechilds/zsh-nvm' 'Aloxaf/fzf-tab' 'zsh-users/zsh-autosuggestions' 'agkozak/zsh-z')

  for p in "${PLUGINS[@]}"; do
    :
    git -C $HOME/.zsh clone https://github.com/$p 2> /dev/null

    local PLUGIN_NAME=`echo $p | cut -f 2 -d '/'`

    source $HOME/.zsh/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh
  done
}

# convert an org file into markdown with no line wrapping
# TODO: pandoc escapes a lot of symbols that don't need to be escaped. mainly <, >, and '
to-md() {
  file=$1
  filename=$(basename $file .org)
  pandoc $file -o $filename.md --wrap none
}

# use <C-z> to toggle current process between foreground and background
fancy-ctrl-z() {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Enable vi mode
bindkey -v

# NOTE: for when I forget what these are. use when yabaii is messing up
# yabai --restart-service
# skhd --restart-service

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

export STARSHIP_CONFIG=~/.config/starship/config.toml

source ~/bin/work_scripts

# caps <-> escape
# eval `$(setxkbmap -option "caps:escape")`

source /Users/dylan.byars/.config/broot/launcher/bash/br
