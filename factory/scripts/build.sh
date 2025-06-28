#!/bin/bash
# Finds and compiles all Go modules within the project.

set -e

echo "🔎 Searching for Go modules (go.mod files) to build..."
MODULE_FILES=$(find . -name "go.mod" -not -path "./.idx/*")

if [ -z "$MODULE_FILES" ]; then
  echo "✅ No Go modules found. Nothing to build."
  exit 0
fi

# Create a central directory for all output binaries at the project root.
echo "--> Creating output directory at ./bin"
mkdir -p ./bin

echo "$MODULE_FILES" | while read -r mod_file; do
  module_dir=$(dirname "$mod_file")
  binary_name=$(basename "$module_dir")
  
  echo
  gum style --bold --padding "0 1" "Processing module: $module_dir"

  (
    cd "$module_dir"
    
    # --- START: CRITICAL FIX ---
    # Check if a 'cmd' directory exists before attempting to build.
    # This is the correct, convention-based check.
    if [ ! -d "cmd" ]; then
        echo "--> No 'cmd' directory found in '$module_dir'. Skipping build."
    else
        echo "--> Compiling '$binary_name' from ./cmd directory..."
        # Build the ./cmd package and output to the root ../bin directory.
        go build -o "../bin/$binary_name" ./cmd
    fi
    # --- END: CRITICAL FIX ---
  )
done

echo
gum style --bold "✅ All modules built successfully. Binaries are in ./bin"