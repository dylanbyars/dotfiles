# uncomment this and the last line to profile startup time
# zmodload zsh/zprof

# -----------------------
# Environment Variables
# -----------------------
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/homebrew/bin:/opt/homebrew/share/zsh/site-functions:/usr/local/go/bin:$HOME/bin:/usr/libexec:/home/$USER/.deno/bin:$HOME/.local/bin:$PATH
export EDITOR=nvim
export DELTA_PAGER="less -r"
export STARSHIP_CONFIG=~/.config/starship/config.toml

# -----------------------
# Aliases
# -----------------------
alias vim='nvim'
alias zz='exec zsh'
alias /='br'
alias dot="cd ~/dotfiles && vim"
alias org="cd ~/org"
alias lz='lazygit -ucf ~/.config/lazygit/config.yml'
alias ld='lazydocker'
alias f="eza --long --header"
alias ff="eza --long --header --all"
alias F="eza --tree --level 2"
alias globalPackages="npm ls -g --depth=0"

# -----------------------
# Utility Functions
# -----------------------
nukeswap() { rm -rf ~/.local/state/nvim/swap/; }
ufx() { echo 'removing xcode-select tools'; sudo rm -rf $(xcode-select --print-path); echo 'reinstalling xcode-select'; xcode-select --install; }
mktouch() { mkdir -p "$(dirname "$1")" && touch "$1"; }
fzfancy() { fzf --reverse --height=20 --border=rounded --header=$1; }
to-md() { file=$1; filename=$(basename $file .org); pandoc $file -o $filename.md --wrap none; }
source ~/.zsh/today.sh
source ~/.zsh/monthly.sh
source ~/.zsh/pomodoro.sh

# -----------------------
# Project Environment Functions
# -----------------------
# is_poetry_project() { [[ -f "pyproject.toml" ]] && grep -q '\[build-system\]' "pyproject.toml"; }
is_python_project() { [[ -d ".venv" ]]; }
activate_venv() { echo "Activating Python virtual environment..."; . .venv/bin/activate; }
activate_node_lts() { echo "Activating node stable version..."; nvm use stable; }
is_nvm_project() { [[ -f ".nvmrc" ]]; }
activate_nvm_env() { echo "Activating Node.js version specified in .nvmrc..."; nvm use; }

# Main function that gets called whenever you navigate to a new directory
auto_activate() {
  # Check if the current directory is under ~/code
  if [[ "$PWD" == "$HOME/code"* ]]; then
    if is_python_project; then
      activate_venv && activate_node_lts
    fi
    if is_nvm_project; then
      activate_nvm_env
    fi
  fi
}

# -----------------------
# Hooks and Plugins
# -----------------------
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate

# Completion
fpath=(~/.zsh ~/.zsh/completions /opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit -u

# Plugin Management
source ~/.zsh/git.sh

# Zsh Plugins
if [[ ! -d ~/.zsh ]]; then
  mkdir ~/.zsh/
fi

local PLUGINS=('lukechilds/zsh-nvm' 'Aloxaf/fzf-tab' 'zsh-users/zsh-autosuggestions' 'agkozak/zsh-z')

for p in "${PLUGINS[@]}"; do
  git -C $HOME/.zsh clone https://github.com/$p 2> /dev/null
  local PLUGIN_NAME=`echo $p | cut -f 2 -d '/'`
  source $HOME/.zsh/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh
done

# -----------------------
# Keybindings
# -----------------------

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z

bindkey -v
bindkey '^Z' fancy-ctrl-z

# -----------------------
# Prompt and Appearance
# -----------------------
eval "$(starship init zsh)"

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Work Scripts (Loaded Last)
source ~/bin/work_scripts


# zprof > profile.txt

preview() {
  if ! type browser-sync >/dev/null 2>&1; then
    echo 'Need to install browser-sync.'
    echo 'try: `nvm use stable && npm install -g browser-sync`'
    # exit 1
  fi

  browser-sync start \
    --no-notify --no-ui \
    --ignore '**/.*' \
    -sw
}

# use nvim to write to mods
# ai() {
#   TEMP=$(mktemp) && nvim "$TEMP" && cat "$TEMP" | mods && rm "$TEMP"
# }
# TODO: update the aic to print the conversation to the buffer and also remove it before submitting
 # aic() {
 #      # get the latest conversation, save output to CONVERSATION
 #      CONVERSATION=$(mods --show-last)
 #
 #      # write the conversation to the buffer with unique delimiter added
 #      echo -e "$CONVERSATION\n###USERRESPONSE###" > "$TEMP"
 #
 #      # open file with nvim
 #      nvim "$TEMP"
 #
 #      # remove the conversation part from the buffer before you pipe it to mods
 #      sed -n '/^###USERRESPONSE###$/,$p' "$TEMP" | tail -n +2 | mods --continue-
 #  last
 #
 #      # clean up
 #      rm "$TEMP"
 #    }
# aic() {
#   TEMP=$(mktemp) && nvim "$TEMP" && cat "$TEMP" | mods --continue && rm "$TEMP"
# }
# BUG: do the branch one
# aib() {
#   # list all named conversations and select one
#   mods --list
#   # dump the full text of the conversation so far
#   mods --show $(pbpaste)
#   TEMP=$(mktemp) && nvim "$TEMP" && cat "$TEMP" | mods --continue="$(pbpaste)"
#   && rm "$TEMP"
# }

source /Users/dylan.byars/.config/broot/launcher/bash/br
export PATH=$PATH:$(go env GOPATH)/bin

alias bong="afplay /System/Library/Sounds/Funk.aiff"

. "$HOME/.cargo/env"
