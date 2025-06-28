#!/bin/bash
# factory/scripts/task_finish.sh
#
# WHY:  Standardizes the process of finalizing a feature branch.
# WHAT: Pushes the current branch and uses the GitHub CLI to create a pull request.

set -e

# --- Phase 1: State Verification ---
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [[ "$CURRENT_BRANCH" == "main" || "$CURRENT_BRANCH" == "master" ]]; then
  gum style --bold --foreground "9" "Error: You cannot create a pull request from the main branch."
  exit 1
fi

gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "🚀 Ready to finish task on branch '$CURRENT_BRANCH'?"

# --- Phase 2: Push to Remote ---
if gum confirm "Push branch to remote repository?"; then
  gum spin --spinner dot --title "Pushing '$CURRENT_BRANCH' to origin..." -- git push -u origin "$CURRENT_BRANCH"
  echo "✅ Branch pushed successfully."
else
  echo "Aborted. Your branch was not pushed."
  exit 0
fi

# --- Phase 3: Create Pull Request ---
# Check for the GitHub CLI `gh`
if ! command -v gh &> /dev/null; then
  gum style --bold --foreground "9" "Warning: GitHub CLI ('gh') not found." >&2
  echo "Cannot create the PR automatically. Please install 'gh' or create the PR manually on the GitHub website." >&2
  exit 1
fi

gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Next, let's create the Pull Request."

# Use `gh pr create`. It's interactive and powerful.
# --fill: pre-fills title and body from commits.
# --web: opens the new PR in the browser after creation.
if gum confirm "Create a Pull Request on GitHub now?"; then
  gh pr create --fill --web
  gum style --bold "✅ Pull Request created and opened in your browser."
else
  echo "Aborted. You can create the PR later by running 'gh pr create'."
fi