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
  # For a root module, the binary name is the name of the project directory.
  binary_name=$(basename "$(pwd)")
  
  echo
  gum style --bold --padding "0 1" "Building module: $module_dir"

  (
    # No need to cd if we are already in the root.
    echo "--> Compiling '$binary_name'..."
    # Output the binary to the root ./bin directory.
    go build -o "./bin/$binary_name" .
  )
done

echo
gum style --bold "✅ All modules built successfully. Binaries are in ./bin"