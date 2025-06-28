# This file defines a Nix "derivation," which is a recipe for building a piece of software.
# It accepts 'pkgs' (the Nix Packages collection) as an input so it can access necessary build tools.
{ pkgs }:

# 'buildGoModule' is a specialized builder from Nixpkgs designed specifically for Go projects
# that use Go Modules for dependency management. It automates the process of fetching dependencies
# and building the Go binary in a way that is compatible with Nix's sandboxed environment.
pkgs.buildGoModule {
  # --- Package Metadata ---

  # 'pname' is the package name. It should be descriptive and is used to identify the package within Nix.
  pname = "contextvibes";
  # 'version' is the package version. It should match the version of the source code you are building.
  version = "0.2.0";

  # --- Source Code Location ---

  # 'src' specifies where to get the source code from.
  # We use 'fetchFromGitHub' to download a specific release from a GitHub repository.
  src = pkgs.fetchFromGitHub {
    # The username or organization that owns the repository.
    owner = "contextvibes";
    # The name of the repository.
    repo = "cli";
    # The git tag, branch, or commit hash to check out. Using a tag is best for reproducibility.
    rev = "v0.2.0";

    # 'hash' is a cryptographic checksum of the source code archive.
    # Nix uses this to guarantee that the downloaded code is exactly what we expect it to be,
    # preventing accidental changes or malicious tampering. This is a key part of Nix's
    # commitment to reproducibility. This hash is discovered during the first failed build attempt.
    hash = "sha256-YEyUqlXvxhQ+PjEb1pMCKzkgEkuufb1UyXv+kCKePI4=";
  };

  # --- Go-Specific Build Configuration ---

  # 'vendorHash' is a cryptographic checksum of the Go module dependencies listed in the go.mod file.
  # Because Nix builds happen in a sandbox without network access, 'buildGoModule' pre-fetches
  # all dependencies first. This hash verifies that the pre-fetched dependencies are correct and
  # haven't changed. Like the 'hash' above, this value is discovered during a failed build attempt.
  vendorHash = "sha256-a+8G4XwfPt7m9PGhVw/NVNfBNj0cfoKJgk1madwEDaU=";

  # 'subPackages' tells the builder which specific Go package(s) to build from the source repository.
  # This is necessary when the main executable is not at the root of the repository.
  # In this case, the main function is located in the 'cmd/contextvibes' directory.
  subPackages = [ "cmd/contextvibes" ];
}