#!/bin/bash
# Finds and runs tests for all Go modules within the project.

set -e

echo "🔎 Searching for Go modules (go.mod files) to test..."
MODULE_FILES=$(find . -name "go.mod" -not -path "./.idx/*")

if [ -z "$MODULE_FILES" ]; then
  echo "✅ No Go modules found. Nothing to test."
  exit 0
fi

echo "$MODULE_FILES" | while read -r mod_file; do
  module_dir=$(dirname "$mod_file")
  
  echo
  gum style --bold --padding "0 1" "Testing module: $module_dir"

  (
    cd "$module_dir"
    echo "--> Running tests with coverage..."
    # -v: verbose output to see individual test results.
    # -cover: generate a coverage report.
    # ./...: run tests in the current directory and all subdirectories.
    go test -v -cover ./...
  )
done

echo
gum style --bold "✅ All tests completed."