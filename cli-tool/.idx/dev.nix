# This file defines the development environment for a Firebase Studio workspace using Nix.
# It specifies all the packages, services, and editor extensions needed for the project.
{ pkgs, ... }:

let
  # Imports the custom Nix derivation for the 'contextvibes' tool from a separate file.
  # This declarative approach makes the tool a first-class package in the environment,
  # which is more reproducible and cacheable than installing it with an imperative script.
  contextvibes = import ./contextvibes.nix { pkgs = pkgs; };
in
{
  # Specifies the Nixpkgs channel to use. Pinning to a specific channel like "stable-25.05"
  # ensures that everyone on the team gets the exact same package versions, leading to a
  # highly reproducible environment. "nixos-unstable" can be used for more recent packages.
  channel = "stable-25.05";

  # Defines the system packages to be installed and made available in the environment's PATH.
  packages = with pkgs; [
    # --- Core Go Development ---
    go # The Go compiler and core toolchain.
    gopls # The official Go Language Server for IDE features like completion and navigation.
    gotools # A suite of supplementary Go tools used by IDE extensions.
    delve # The Go debugger, essential for step-debugging.
    goimports-reviser # A tool to automatically format and revise Go import statements.

    # --- Automation & Containers ---
    go-task # A task runner used for project automation (see Taskfile.yml).
    docker-compose # Required for orchestrating local multi-container simulations.

    # --- Code Quality ---
    golangci-lint # A fast Go linter that runs multiple linters in parallel.
    nodejs # A JavaScript runtime, often needed for linters or other build tools.
    nodePackages.markdownlint-cli # A linter to enforce standards in Markdown files.

    # --- Cloud & Utilities ---
    google-cloud-sdk # The `gcloud` CLI for interacting with Google Cloud Platform.
    git # The version control system for managing source code.
    gh # The official GitHub CLI for interacting with GitHub.
    jq # A command-line JSON processor for scripting and data inspection.
    tree # A utility to display directory structures.
    gcc # The GNU Compiler Collection, required by Go for certain build modes (e.g., cgo).
    file # A utility to determine file types.
    gum # A tool for glamorous shell scripts, enabling interactive and user-friendly automation.

    # --- Custom Project Tools ---
    contextvibes # The custom-built 'contextvibes' CLI tool, managed by its own Nix file.
  ];

  # Configures the Firebase Studio workspace environment.
  idx = {
    # Specifies VS Code extensions to install automatically when the workspace is created.
    # This ensures a consistent and fully-featured editor experience for all developers.
    extensions = [
      # --- Core Language Support ---
      "golang.go" # Official Go extension (debugging, testing, linting).
      "ms-python.python" # Python language support.
      "ms-python.debugpy" # Python debugging support.

      # --- Tooling & Integration ---
      "ms-azuretools.vscode-docker" # Docker integration and container management.
      "GitHub.vscode-pull-request-github" # GitHub Pull Request and Issues integration.
    ];
  };

  # Note on Omitted Configurations:
  #
  # - `idx.previews`: This section is omitted because its default value (`enable = false`)
  #   is the desired behavior for this command-line application.
  #
  # - `idx.workspace.onCreate` & `idx.workspace.onStart`: These lifecycle hooks are not
  #   defined here. Custom tools are included declaratively in the `packages` list, which
  #   is the preferred Nix approach for reproducibility and caching over setup scripts.
  #   These hooks can be added if other non-package setup scripts are needed.
}
