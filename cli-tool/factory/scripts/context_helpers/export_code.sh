#!/bin/bash
# factory/scripts/context_helpers/export_code.sh
# Exports the application source code of this project.

set -e

# --- Configuration ---
OUTPUT_FILE="context_export_code.md"

# --- Helper Function ---
# Checks if a file is text-based by examining its MIME type.
is_text_file() {
  local mime_type
  mime_type=$(file --brief --mime-type "$1")
  # Returns true (exit code 0) if the MIME type starts with 'text/' OR is 'application/json' or 'application/javascript'.
  [[ "$mime_type" == text/* || "$mime_type" == application/json || "$mime_type" == application/javascript ]]
}

# --- Main Logic ---

# No longer need to ask the user, we know what code to export.
echo "--> Generating code-only export to $OUTPUT_FILE..."

# 2. Start the report with a clear, hardcoded prompt.
cat <<EOF > "$OUTPUT_FILE"
# AI INSTRUCTION: Code Context Analysis

## Your Role
Assume the role of a senior software engineer. Your memory is being initialized with the application source code for the project.

## Your Task
The content immediately following this prompt is an export of the project's product source code. Your primary task is to **fully ingest and internalize this code**.
---
EOF

# 3. Append all application source files from the project root.
# We use 'git ls-files' to ensure we only include files tracked by git.
git ls-files "cmd/" "go.mod" "main.go" | while read -r file; do
  # Use the robust helper function to check the file type.
  if ! is_text_file "$file"; then
    echo "--> Skipping non-text file: $file (MIME: $(file --brief --mime-type "$file"))"
    continue
  fi

  # Append the file's content, wrapped in a markdown code block.
  {
    echo ""
    echo "======== FILE: ${file} ========"
    echo "\`\`\`${file##*.}"
    cat "$file"
    echo "\`\`\`"
    echo "======== END FILE: ${file} ========"
  } >> "$OUTPUT_FILE"
done

echo "✅ Code export complete. Report saved to '$OUTPUT_FILE'."