{ pkgs, ... }: {
  channel = "stable-24.11";

  packages = [
    pkgs.go
    pkgs.gopls
    pkgs.delve
    pkgs.golangci-lint
    pkgs.git
  ];

  idx = {
    extensions = [
      "golang.go",
      "GitHub.vscode-pull-request-github",
    ];
    workspace.onCreate.installAndTidy = ''
      go mod download
      go mod tidy
    '';
    previews.enable = false; # No web preview needed for a CLI tool
  };
}
