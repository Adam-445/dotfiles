#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No color

echo -e "${BLUE}Installing dotfiles..${NC}"

# Create backup directory
BACKUP_DIR=~/dotfiles_backup_$(date +%Y%m%d_%H%M%S)
mkdir -p $BACKUP_DIR

# Function to backup and link
backup_and_link() {
  local source=$1
  local target=$2

  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "Backing up existing $target"
    mv "$target" "$BACKUP_DIR"
  fi

  ln -sf "$source" "$target"
  echo -e "${GREEN}Linked $source -> $target${NC}"
}

# Link tmux config
backup_and_link ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Link nvim config (So i can version control it too)
backup_and_link ~/dotfiles/nvim ~/.config/nvim

#Link shell config
backup_and_link ~/dotfiles/shell/zshrc ~/.zshrc
chmod +x ~/dotfiles/scripts/*

# Link git config
# backup_and_link ~/dotfiles/git/gitconfig ~/.gitconfig

echo -e "${GREEN} Installation complete!${NC}"
echo "Backup saved to: $BACKUP_DIR"
