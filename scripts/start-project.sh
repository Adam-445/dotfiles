#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No color

PROJECT_NAME=$1
PROJECT_PATH=$2

if [ -z "$PROJECT_NAME" ] || [ -z "$PROJECT_PATH" ]; then
  echo -e "${RED}Usage:${NC} start-project <name> <path>"
  echo ""
  echo "Examples:"
  echo "  start-project myapp /path/to/project"
  echo "  start-project myapp .                # Use current directory"
  exit 1
fi

# Handle the path
if [ "$PROJECT_PATH" = "." ]; then
  # Use current directory
  PROJECT_PATH=$(pwd)
fi

# Convert to absolute path
PROJECT_PATH=$(cd "$PROJECT_PATH" 2>/dev/null && pwd)

# Check if path exists
if [ ! -d "$PROJECT_PATH" ]; then
  echo -e "${RED}ERROR:${NC} Directory does not exist: $PROJECT_PATH"
  echo -e "Create it first with: ${BLUE}mkdir -p $PROJECT_PATH${NC}"
  exit 1
fi

echo -e "${BLUE}Staring tmux session '${PROJECT_NAME}' in ${PROJECT_PATH}${NC}"

# Check if sessoin already exists
tmux has-session -t "$PROJECT_NAME" 2>/dev/null

if [ $? != 0 ]; then
  # Session doesnt exist, create it,
  # and open nvim in the first window
  tmux new-session -d -s "$PROJECT_NAME" -c "$PROJECT_PATH" -n editor "nvim"

  # Window 2: Shell
  tmux new-window -t "$PROJECT_NAME:2" -n "shell" -c "$PROJECT_PATH"

  # Window 3: Server
  tmux new-window -t "$PROJECT_NAME:3" -n "server" -c "$PROJECT_PATH"

  # Select first window
  tmux select-window -t "$PROJECT_NAME:editor"
  echo -e "${GREEN}Created new session${NC}"
else
  echo -e "${GREEN}Session already exists, attaching..${NC}"
fi

# Attach to session
tmux attach-session -t "$PROJECT_NAME"
