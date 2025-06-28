# This file is the core scaffolding engine for a multi-variant Firebase Studio template.
# Its purpose is to take a user's selection from the template UI and copy the
# corresponding project files into the new workspace.

{
  pkgs,
  # This defines an input argument named 'environment'. Its value is provided by the
  # templating system based on the user's choice for the 'projectType' parameter
  # in 'template.json'.
  environment ? "cloud-run-api",
  # This captures the 'goModulePath' parameter from 'template.json'.
  goModulePath ? "github.com/my-org/my-app",
  ...
}: {
  # We need bash and gnsed (GNU sed) for our script to ensure compatibility.
  packages = [ pkgs.bash pkgs.gnsed ];

  # The 'bootstrap' attribute contains the shell script that runs to create the workspace.
  bootstrap = ''
    # 'set -e' causes the script to exit immediately if any command fails.
    # 'set -x' prints each command to the log before it is executed.
    set -ex

    # --- Logging and Verification ---
    echo "Bootstrapping selected project type: ''${environment}''"
    echo "Source directory to copy: ''${./.}/''${environment}''"
    echo "Target workspace name (from env): $WS_NAME"
    echo "Go Module Path to set: ''${goModulePath}''"
    echo "Final output directory (from Nix): $out"

    # --- Critical Pre-flight Check ---
    if [ ! -d "''${./.}/''${environment}''" ]; then
      echo "CRITICAL ERROR: Source directory '''${./.}/''${environment}''' does not exist for the selected project type."
      exit 1
    fi

    # --- Scaffolding Logic ---
    # 1. Copy the source files into a temporary directory.
    TMP_DIR=$(mktemp -d)
    cp -rf "''${./.}/''${environment}"/* "$TMP_DIR"

    # 2. Perform the automated module path replacement.
    # We use a placeholder that is unlikely to conflict with user code.
    PLACEHOLDER="your-module-name"
    echo "Replacing placeholder '$$PLACEHOLDER' with '$$goModulePath'..."
    # Find all .go files, go.mod, and the README, then run sed on them.
    # Using -print0 and xargs -0 is the safest way to handle filenames.
    find "$TMP_DIR" -type f \( -name "*.go" -o -name "go.mod" -o -name "README.md" \) -print0 | xargs -0 sed -i "s|$$PLACEHOLDER|''${goModulePath}''|g"

    # 3. Move the prepared content into the final destination directory.
    # First, create a directory named after the workspace.
    mkdir -p "$WS_NAME"
    # Then, move the modified files from the temp directory into it.
    mv "$TMP_DIR"/* "$WS_NAME"
    # Clean up the temp directory.
    rm -rf "$TMP_DIR"

    # 4. Recursively add write permissions to all copied files and directories.
    chmod -R +w "$WS_NAME"

    # 5. Move the final workspace content to the required output directory.
    mv "$WS_NAME" "$out"

    # --- Final Confirmation ---
    echo "Bootstrapping complete for project type: ''${environment}''."
    echo "Workspace content is now in: $out"
  '';
}