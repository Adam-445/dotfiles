# ENVIRONMENT VARIABLES

# Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Path additions
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/dotfiles/scripts:$PATH"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
