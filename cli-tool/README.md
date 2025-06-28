# Go CLI Tool Template

This template provides a starter kit for building a command-line interface (CLI) application in Go using the popular [Cobra](https://cobra.dev/) library.

When you create a project from this template, the Go module path will be automatically set to the value you provided.

## Features

- **Structure:** Follows the standard Cobra layout (`main.go` and a `cmd/` directory).
- **Example Command:** Includes a `hello` subcommand to demonstrate basic functionality.
- **Flag Support:** The `hello` command includes a `--name` flag to show how to handle user input.

## How to Use

1.  **Build the binary:**
    ```bash
    go build -o my-cli .
    ```

2.  **Run the command:**
    ```bash
    # Run the default hello command
    ./my-cli hello

    # Run with the name flag
    ./my-cli hello --name "Alice"
    ```
