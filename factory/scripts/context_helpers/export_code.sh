#!/bin/bash
# factory/scripts/context_helpers/export_code.sh
# Exports the source code for a interactively selected product.

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

# 1. Interactively select the product to export.
echo "Please select the product to export:"
PRODUCT_CHOICE=$(gum choose "cli-tool" "cloud-run-api")

# Exit gracefully if the user cancels.
if [ -z "$PRODUCT_CHOICE" ]; then
  echo "No selection made. Aborting."
  exit 1
fi

echo "--> Generating code-only export for '$PRODUCT_CHOICE' to $OUTPUT_FILE..."

# 2. Start the report with a clear, hardcoded prompt.
cat <<EOF > "$OUTPUT_FILE"
# AI INSTRUCTION: Code Context Analysis

## Your Role
Assume the role of a senior software engineer. Your memory is being initialized with the application source code for the project.

## Your Task
The content immediately following this prompt is an export of the project's product source code. Your primary task is to **fully ingest and internalize this code**.
---
EOF

# 3. Append all text files from the selected product's directory.
# We use 'git ls-files' to ensure we only include files tracked by git.
git ls-files "$PRODUCT_CHOICE/" | while read -r file; do
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

echo "✅ Code export for '$PRODUCT_CHOICE' complete. Report saved to '$OUTPUT_FILE'."