# Zsh Configuration - Optimized for speed and simplicity
# Profile startup performance: `PROFILE=1 zsh`
[[ "$PROFILE" == "1" ]] && zmodload zsh/zprof

# ==============================================
# CORE ENVIRONMENT
# ==============================================
export EDITOR=nvim
export VISUAL=nvim
export STARSHIP_CONFIG=~/.config/starship/config.toml
export MANPAGER='nvim +Man!'  # Open man pages in neovim

# PATH: prioritize local tools over system ones
export PATH=/opt/homebrew/bin:/usr/local/bin:$HOME/bin:$HOME/.local/bin:$PATH

# Optional machine-local overlay (ignored by git)
# Keep shared defaults in this file; put machine-specific settings in this overlay.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# ==============================================
# ALIASES & FUNCTIONS
# ==============================================
# Modern replacements for standard tools
alias vim='nvim'
alias f="eza --long --header"        # Better ls
alias ff="eza --long --header --all" # ls -la
alias F="eza --tree --level 2"       # Tree view

# Development tools
alias lz='lazygit'  # Git UI
alias ld='lazydocker'                                  # Docker UI
alias globalPackages="npm ls -g --depth=0"           # List global npm packages

# Utility functions
nukeswap() { rm -rf ~/.local/state/nvim/swap/; }  # Clear nvim swap files
ufx() { 
  echo 'Reinstalling Xcode command line tools...'
  sudo rm -rf $(xcode-select --print-path)
  xcode-select --install
}

# ==============================================
# PYTHON ENVIRONMENT AUTO-ACTIVATION
# ==============================================
# Automatically create and activate Python venvs using uv
auto_activate() {
  if [[ "$PWD" == "$HOME/code"* ]]; then
    if [[ -f "pyproject.toml" || -f "requirements.txt" || -f ".python-version" ]]; then
      if [[ ! -d ".venv" ]]; then
        echo "Creating Python venv with uv..."
        uv venv
      fi
      
      if [[ "$VIRTUAL_ENV" != "$PWD/.venv" ]]; then
        echo "Activating Python venv..."
        source .venv/bin/activate
      fi
    fi
  fi
}

# Run auto_activate on every directory change
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate

# ==============================================
# ZSH PLUGINS & COMPLETIONS
# ==============================================
# Completion paths: local, cached, homebrew, system
fpath=(~/.zsh ~/.zsh/completions /opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz compinit
# -C skips security checks on completion files (saves ~350ms startup time)
# Safe on single-user machines where you trust your package manager
compinit -C -u

# Make completion improvements
zstyle ':completion:*:make:*' tag-order 'targets'
zstyle ':completion:*:make:*:targets' call-command true

# Essential plugins for productivity
[[ ! -d ~/.zsh ]] && mkdir ~/.zsh/
local PLUGINS=(
  'Aloxaf/fzf-tab'                # Better tab completion with fzf
  'zsh-users/zsh-autosuggestions' # Fish-like autosuggestions
  'agkozak/zsh-z'                 # Smart directory jumping
  'zsh-users/zsh-completions'     # 400+ additional completions
)

for p in "${PLUGINS[@]}"; do
  local PLUGIN_NAME=$(echo $p | cut -f 2 -d '/')
  local PLUGIN_DIR="$HOME/.zsh/$PLUGIN_NAME"
  
  # Only clone the plugin if not already present
  [[ ! -d "$PLUGIN_DIR" ]] && git -C $HOME/.zsh clone https://github.com/$p 2>/dev/null
  source "$PLUGIN_DIR/$PLUGIN_NAME.plugin.zsh"
done

# ==============================================
# KEYBINDINGS & WIDGETS
# ==============================================
bindkey -v  # Vi mode

# Smart Ctrl-Z: suspend/resume with one keystroke
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

# Fuzzy history search with Ctrl-R
fzf-history-widget() {
  local selected=$(fc -l 1 | fzf --tac +s --no-sort)
  if [[ -n $selected ]]; then
    BUFFER=$(echo $selected | sed 's/^[ 0-9]*//') 
    CURSOR=${#BUFFER}
  fi
  zle redisplay
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget

# Edit long commands in nvim: Ctrl+X Ctrl+E
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# ==============================================
# TOOL INITIALIZATION
# ==============================================
# Starship prompt (fast, customizable)
eval "$(starship init zsh)"

# Cached completions for speed - only regenerate when tools update
_load_completion() {
  local tool=$1 cache_file="$HOME/.zsh/completions/_${tool}" tool_path=$(which $tool)
  [[ ! -d "$HOME/.zsh/completions" ]] && mkdir -p "$HOME/.zsh/completions"
  if [[ ! -f "$cache_file" || "$tool_path" -nt "$cache_file" ]]; then
    $tool generate-shell-completion zsh > "$cache_file" 2>/dev/null
  fi
}
_load_completion uv
_load_completion uvx

# Mise: manage Node.js versions and other tools
eval "$(mise activate zsh)"

# Show profiling results if enabled
[[ "$PROFILE" == "1" ]] && zprof
