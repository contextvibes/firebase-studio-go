# This file is the core scaffolding engine for a multi-variant Firebase Studio template.
# Its purpose is to take a user's selection from the template UI and copy the
# corresponding project files into the new workspace.

{
  pkgs,
  # This defines an input argument named 'environment'. Its value is provided by the
  # templating system based on the user's choice for the 'projectType' parameter
  # in 'template.json'.
  # The '? "cloud-run-api"' sets a default value. This is a safety measure ensuring
  # the template has a fallback if the input is not provided for any reason.
  # This value should match the 'default' in 'template.json'.
  environment ? "cloud-run-api",
  ...
}: {
  # We only need a basic shell for this script, so we request 'bash' from Nixpkgs.
  packages = [ pkgs.bash ];

  # The 'bootstrap' attribute contains the shell script that runs to create the workspace.
  bootstrap = ''
    # 'set -e' causes the script to exit immediately if any command fails.
    # 'set -x' prints each command to the log before it is executed.
    # This combination is a best practice for robust and debuggable shell scripts.
    set -ex

    # --- Logging and Verification ---
    # These echo statements provide clear output in the build logs, which is
    # essential for understanding and debugging the template creation process.
    echo "Bootstrapping selected project type: ${environment}"
    echo "Source directory to copy: ${./.}/${environment}"
    echo "Target workspace name (from env): $WS_NAME"
    echo "Final output directory (from Nix): $out"

    # --- Critical Pre-flight Check ---
    # This is the most important safety feature. It verifies that a source directory
    # corresponding to the selected 'environment' actually exists before trying to copy it.
    # This prevents cryptic errors if the template is misconfigured.
    if [ ! -d "${./.}/${environment}" ]; then
      echo "CRITICAL ERROR: Source directory '${./.}/${environment}' does not exist for the selected project type."
      exit 1
    fi

    # --- Scaffolding Logic ---
    # 1. Copy the source files from the selected template variant directory into a
    #    new directory named after the workspace ($WS_NAME is provided by the environment).
    cp -rf "${./.}/${environment}" "$WS_NAME"

    # 2. Recursively add write permissions to all copied files and directories.
    #    This is a crucial step because files managed by Nix can be read-only by default.
    #    This ensures the user can edit the files in their new workspace.
    chmod -R +w "$WS_NAME"

    # 3. Move the prepared workspace content into the final destination directory ($out).
    #    The Nix build process requires that the final result of the script be placed
    #    in the location specified by the '$out' environment variable.
    mv "$WS_NAME" "$out"

    # --- Final Confirmation ---
    echo "Bootstrapping complete for project type: ${environment}."
    echo "Workspace content is now in: $out"
  '';
}