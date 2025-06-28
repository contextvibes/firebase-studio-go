#!/bin/bash
# Finds and analyzes all Go modules using golangci-lint.

set -e

echo "🔎 Searching for Go modules (go.mod files) to analyze..."
MODULE_FILES=$(find . -name "go.mod" -not -path "./.idx/*")

if [ -z "$MODULE_FILES" ]; then
  echo "✅ No Go modules found. Nothing to analyze."
  exit 0
fi

echo "$MODULE_FILES" | while read -r mod_file; do
  module_dir=$(dirname "$mod_file")
  
  echo
  gum style --bold --padding "0 1" "Analyzing module: $module_dir"

  (
    cd "$module_dir"
    echo "--> Running golangci-lint..."
    # golangci-lint will automatically find and use the .golangci.yml config file if it exists.
    golangci-lint run
  )
done

echo
gum style --bold "✅ Analysis complete."