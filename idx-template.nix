{
  pkgs,
  environment ? "cloud-run-api",
  ...
}: {
  # Add git to the environment so the bootstrap script can use it.
  packages = [ pkgs.git ];

  bootstrap = ''
    # 1. Copy the template directory to a new directory named after the workspace.
    #    This preserves the original, working copy logic.
    cp -rf ${./.}/${environment} "$WS_NAME"
    chmod -R +w "$WS_NAME"

    # 2. Initialize the git repository inside this new directory.
    #    We use a subshell to avoid changing the main script's directory.
    (
      cd "$WS_NAME"
      echo "--> Initializing Git repository in $(pwd)..."
      git init
      git checkout -b main
      # Set dummy user info for the commit to work in the build environment
      git config user.email "template@example.com"
      git config user.name "Template Initializer"
      git add .
      git commit -m "feat: initial commit from template"
    )

    # 3. Move the prepared directory to the final output location.
    mv "$WS_NAME" "$out"

    echo "✅ Git repository initialized and initial commit created."
  '';
}