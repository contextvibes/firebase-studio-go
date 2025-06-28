#!/bin/bash
# Runs the Go application, passing all arguments to it.

set -e

echo "▶️  Executing 'go run ./cmd $@'..."
echo

# The "$@" passes all command-line arguments from the task to the go run command.
go run ./cmd "$@"