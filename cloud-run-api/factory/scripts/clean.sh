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
  go clean -cache -modcache -testcache
  echo "--> Removing temporary context files..."
  rm -f context_export_all.md
  echo "--> Removing Task runner cache (./.task)..."
  rm -rf ./.task
}

# --- Main Script Logic ---

# If run without arguments, show the interactive menu.
if [ -z "$1" ]; then
  gum style --bold --padding "1 0" "🧹 What would you like to clean?"
  CHOICE=$(gum choose \
    "Project Files (Fast: Binaries, Go cache)" \
    "Quit")

  case "$CHOICE" in
    "Project Files (Fast: Binaries, Go cache)")
      clean_project_files
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
    *) echo "Error: Invalid non-interactive mode '$MODE'. Use 'project' or 'full'." >&2; exit 1 ;;
  esac
fi

echo
gum style --bold "✅ Clean complete."