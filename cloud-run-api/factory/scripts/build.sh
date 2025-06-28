#!/bin/bash
# Finds and compiles the Go module in this project.

set -e

echo "🔎 Building module in current directory..."

# Create a central directory for all output binaries at the project root.
echo "--> Creating output directory at ./bin"
mkdir -p ./bin

binary_name=$(basename "$(pwd)")

echo
gum style --bold --padding "0 1" "Building module: $binary_name"

# Check if a 'cmd' directory exists before attempting to build.
if [ ! -d "cmd" ]; then
    echo "--> ERROR: No 'cmd' directory found. Cannot build." >&2
    exit 1
else
    echo "--> Compiling '$binary_name' from ./cmd directory..."
    # Build the ./cmd package and output to the root ./bin directory.
    go build -o "./bin/$binary_name" ./cmd
fi

echo
gum style --bold "✅ Module built successfully. Binary is in ./bin"