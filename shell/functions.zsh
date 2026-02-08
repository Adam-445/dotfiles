# Auto-sync dotfiles on shell startup
dotfiles_sync() {
  local dotfiles_dir="$HOME/dotfiles"
  local lockfile="/tmp/dotfiles_sync.lock"

  # only run if dotfiles directory exists and is a repo
  [[ -d "$dotfiles_dir/.git" ]] || return

  (
    # aquire lock and exit if another sync is running
    exec 9>"$lockfile" || return
    flock -n 9 || return

    cd "$dotfiles_dir"|| return

    # skip if not upstream configured
    git rev-parse @{u} >/dev/null 2>&1 || return

    # fetch
    timeout 1 git fetch --quiet || return

    # check if remote has changes
    local LOCAL=$(git rev-parse @)
    local REMOTE=$(git rev-parse @{u})

    #nothing to sync
    [[ "$LOCAL" == "$REMOTE" ]] && return

    # skip if dirty
    git diff --quiet && git diff --cached --quiet || return

    # try to pull
    if git merge-base --is-ancestor HEAD @{u}; then
      git pull --ff-only --quiet && echo "Dotfiles synced"
    else
      echo "Dotfiles: can't auto-sync (you have unpushed commits)"
    fi
  ) &! # background, disowned process
}

dotfiles_sync
