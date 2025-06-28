#!/bin/bash
# Exports the application source code of this project.

set -e

# --- Configuration ---
OUTPUT_FILE="context_export_code.md"

echo "--> Generating code-only export to $OUTPUT_FILE..."

# --- Main Logic ---
cat <<EOF > "$OUTPUT_FILE"
# AI INSTRUCTION: Code Context Analysis

## Your Role
Assume the role of a senior software engineer. Your memory is being initialized with the application source code for the project.

## Your Task
The content immediately following this prompt is an export of the project's product source code. Your primary task is to **fully ingest and internalize this code**.
---
EOF

# Append all application source files from the project.
git ls-files "cmd/" "internal/" "tests/" "go.mod" "go.sum" "Dockerfile" | while read -r file; do
  if ! file --brief --mime-type "$file" | grep -q -e 'text' -e 'application/json'; then
    continue
  fi
  {
    echo ""
    echo "======== FILE: \${file} ========"
    echo "\`\`\`\${file##*.}"
    cat "\$file"
    echo "\`\`\`"
    echo "======== END FILE: \${file} ========"
  } >> "\$OUTPUT_FILE"
done

echo "✅ Code export complete. Report saved to '$OUTPUT_FILE'."