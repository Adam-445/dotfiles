# ============================================
# ENVIRONMENT VARIABLES
# ============================================

# Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Path additions
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/dotfiles/scripts:$PATH"  # Add scripts to PATH!
export PATH="$PATH:$(go env GOPATH)/bin"
