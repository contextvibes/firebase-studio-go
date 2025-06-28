#!/bin/bash
# A smart, interactive script for cleaning the project.
# Supports two modes:
#   1. Interactive Mode: A user-friendly menu for manual cleaning tasks.
#   2. Non-Interactive Mode: For use in automated environments like CI/CD.

# Exit immediately if any command fails.
set -e

# --- Cleaning Functions ---

# Cleans local project-level artifacts. Fast, common, and safe.
clean_project_files() {
  echo "--> Removing compiled binaries (./bin)..."
  rm -rf ./bin
  echo "--> Cleaning Go build cache..."
  go clean
  echo "--> Removing temporary context files..."
  rm -f context_*.md
  rm -f context_*.log
  rm -f contextvibes_*.md
  rm -f contextvibes_*.log
  echo "--> Removing Task runner cache (./.task)..."
  rm -rf ./.task
}

# Cleans deeper system-level caches. Slow and destructive.
clean_system_caches() {
  echo "--> Cleaning Go module and test caches..."
  go clean -cache -modcache -testcache
  echo "--> Pruning all unused Docker resources..."
  docker system prune -af --volumes
}

# Finds and interactively deletes stale local Git branches.
# A "stale" branch is one that has been merged into 'main' and deleted from the remote.
clean_stale_branches() {
  echo "--> Fetching remote state and pruning tracking branches..."
  git fetch --prune

  echo "--> Searching for stale local branches..."
  # Get local branches merged into main, excluding the current branch (*) and main itself.
  MERGED_LOCAL_BRANCHES=$(git branch --merged main | grep -vE '^\*|main$' | sed 's/^[ \t]*//')
  # Get remote branches, stripping the 'origin/' prefix for comparison.
  REMOTE_BRANCHES=$(git branch -r | sed 's|origin/||' | sed 's/^[ \t]*//')
  # Find branches in the first list but not the second using `comm`.
  BRANCHES_TO_DELETE=$(comm -23 <(echo "$MERGED_LOCAL_BRANCHES" | sort) <(echo "$REMOTE_BRANCHES" | sort))

  if [ -z "$BRANCHES_TO_DELETE" ]; then
    gum style --bold "✅ No stale local branches found."
    return
  fi

  gum style --bold "The following stale branches can be safely deleted:"
  echo "$BRANCHES_TO_DELETE" | gum style --faint
  echo
  if gum confirm "Proceed with deletion?"; then
    echo "$BRANCHES_TO_DELETE" | xargs git branch -d
    gum style --bold "✅ Stale branches deleted."
  else
    gum style --bold "Aborted. No branches were deleted."
  fi
}

# --- Main Script Logic ---

# If run without arguments, show the interactive menu.
if [ -z "$1" ]; then
  gum style --bold --padding "1 0" "🧹 What would you like to clean?"
  CHOICE=$(gum choose \
    "Project Files (Fast: Binaries, Go build cache)" \
    "Full System Clean (Slow: Also purges Go & Docker caches)" \
    "Stale Git Branches" \
    "Quit")

  case "$CHOICE" in
    "Project Files (Fast: Binaries, Go build cache)")
      clean_project_files
      ;;
    "Full System Clean (Slow: Also purges Go & Docker caches)")
      clean_project_files
      echo
      if gum confirm "DANGER: This will also remove ALL unused Docker resources on your system. Are you sure?"; then
        clean_system_caches
      else
        gum style --bold "Aborted by user."
      fi
      ;;
    "Stale Git Branches")
      clean_stale_branches
      ;;
    *)
      gum style --bold "Aborted."
      exit 0
      ;;
  esac
# If run with an argument, use non-interactive mode.
else
  MODE=$1
  echo "Running clean in non-interactive mode: $MODE"
  case "$MODE" in
    "project") clean_project_files ;;
    "full") clean_project_files && clean_system_caches ;;
    *) echo "Error: Invalid non-interactive mode '$MODE'. Use 'project' or 'full'." >&2; exit 1 ;;
  esac
fi

echo
gum style --bold "✅ Clean complete."