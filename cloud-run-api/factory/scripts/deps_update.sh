#!/bin/bash
# Finds all Go modules in the project and updates their dependencies.

set -e

echo "🔎 Searching for Go modules (go.mod files) to update..."

# Find all 'go.mod' files, excluding the .idx directory which contains environment configs.
MODULE_FILES=$(find . -name "go.mod" -not -path "./.idx/*")

if [ -z "$MODULE_FILES" ]; then
  gum style --bold "✅ No Go modules found. Nothing to do."
  exit 0
fi

echo "$MODULE_FILES" | while read -r mod_file; do
  # Get the directory containing the go.mod file.
  module_dir=$(dirname "$mod_file")
  
  echo
  gum style --bold --padding "0 1" "Processing module: $module_dir"

  # Use a subshell `()` to safely run commands in the module's directory
  # without needing to manually change back.
  (
    cd "$module_dir"
    echo "🧹 Tidying go.mod and go.sum files..."
    go mod tidy
    echo "⬆️  Updating dependencies to latest versions..."
    go get -u ./...
    echo "🧹 Tidying again after updates..."
    go mod tidy
  )
done

echo
gum style --bold "✅ All Go modules updated successfully."