#!/bin/bash
# Finds and compiles all Go modules within the project.

set -e

echo "🔎 Searching for Go modules (go.mod files) to build..."
MODULE_FILES=$(find . -name "go.mod" -not -path "./.idx/*")

if [ -z "$MODULE_FILES" ]; then
  echo "✅ No Go modules found. Nothing to build."
  exit 0
fi

# Create a central directory for all output binaries. `mkdir -p` is idempotent.
echo "--> Creating output directory at ./bin"
mkdir -p ./bin

echo "$MODULE_FILES" | while read -r mod_file; do
  module_dir=$(dirname "$mod_file")
  # Use the directory name as the binary name (e.g., "cloud-run-api").
  binary_name=$(basename "$module_dir")
  
  echo
  gum style --bold --padding "0 1" "Building module: $module_dir"

  (
    cd "$module_dir"
    echo "--> Compiling '$binary_name'..."
    # The -o flag specifies the output path and name for the compiled binary.
    go build -o "../../bin/$binary_name" .
  )
done

echo
gum style --bold "✅ All modules built successfully. Binaries are in ./bin"