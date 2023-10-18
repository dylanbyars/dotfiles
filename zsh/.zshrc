# uncomment this and the last line to profile startup time
# zmodload zsh/zprof

# -----------------------
# Environment Variables
# -----------------------
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/homebrew/bin:/usr/local/go/bin:$HOME/bin:/usr/libexec:/home/$USER/.deno/bin:$HOME/.local/bin:$PATH
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
alias f="exa --long --header"
alias ff="exa --long --header --all"
alias F="exa --tree --level 2"
alias globalPackages="npm ls -g --depth=0"

# -----------------------
# Utility Functions
# -----------------------
nukeswap() { rm -rf ~/.local/state/nvim/swap/; }
ufx() { echo 'removing xcode-select tools'; sudo rm -rf $(xcode-select --print-path); echo 'reinstalling xcode-select'; xcode-select --install; }
mktouch() { mkdir -p "$(dirname "$1")" && touch "$1"; }
fzfancy() { fzf --reverse --height=20 --border=rounded --header=$1; }
to-md() { file=$1; filename=$(basename $file .org); pandoc $file -o $filename.md --wrap none; }

# -----------------------
# Project Environment Functions
# -----------------------
is_poetry_project() { [[ -f "pyproject.toml" ]] && grep -q '\[build-system\]' "pyproject.toml"; }
activate_poetry_env() { echo "Activating Poetry virtual environment..."; VENV_PATH=$(poetry env info --path); source $VENV_PATH/bin/activate; }
activate_node_lts() { echo "Activating Node.js LTS version..."; nvm use --lts; }
is_nvm_project() { [[ -f ".nvmrc" ]]; }
activate_nvm_env() { echo "Activating Node.js version specified in .nvmrc..."; nvm use; }

# Main function that gets called whenever you navigate to a new directory
auto_activate() {
  # Check if the current directory is under ~/code
  if [[ "$PWD" == "$HOME/code"* ]]; then
    if is_poetry_project; then
      activate_poetry_env && activate_node_lts
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
fpath=(~/.zsh $fpath)
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

