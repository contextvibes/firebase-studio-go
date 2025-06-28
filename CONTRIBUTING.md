# Contributing to Go Starter Templates

First off, thank you for considering contributing! Your help is essential for making these templates better for everyone.

This document provides guidelines for contributing to this project. Please feel free to propose changes to this document in a pull request.

## Community Guidelines

We strive to maintain a positive and welcoming environment. All participants are expected to act professionally and respectfully toward others. Please see the Code of Conduct section in the main `README.md`.

## How Can I Contribute?

There are many ways to contribute, from writing tutorials or blog posts, improving the documentation, submitting bug reports and feature requests, or writing code which can be incorporated into the main project.

### Submitting Issues

If you find a bug or have a feature request, please [open an issue](https://github.com/contextvibes/firebase-studio-go/issues) on GitHub. Please provide as much detail as possible to help us understand and address the issue effectively.

## Development Workflow

To ensure consistency, we have a few key standards regarding branch names and commit messages. We've built an automation framework to make following these standards easy, but you are free to use standard Git commands as well.

### Using the Automation Framework (Recommended)

This is the easiest and recommended way to contribute. Our framework handles the standards for you.

1.  **Start a New Task:** Create a structured branch.
    ```bash
    task task-start
    ```

2.  **Test and Analyze:** Run all checks before committing.
    ```bash
    task test
    task analyze
    ```

3.  **Commit Your Changes:** This task wraps Git to ensure safety and standards. The `--` is important to pass arguments correctly.
    ```bash
    task commit -- -m "feat(scope): your commit message"
    ```

4.  **Create a Pull Request:** Push your branch and open the GitHub PR creation page.
    ```bash
    task task-finish
    ```

### Using Standard Git (Also Great!)

If you prefer not to use the automation, that's perfectly fine. Please follow these guidelines to ensure your contribution is consistent with the project.

1.  **Create a Branch:** Please follow our branch naming convention: `<type>/<scope>/<description>`.
    *   **Example:** `git checkout -b feat/factory/add-new-task`

2.  **Test and Analyze:** Run the checks manually.
    ```bash
    go test -v -cover ./...
    golangci-lint run
    ```

3.  **Write Your Commit Message:** We follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification. This is important for our release process.
    *   **Format:** `feat(scope): summary of changes`
    *   **Example:** `git commit -m "feat(factory): add script for task-finish"`

4.  **Create a Pull Request:** Push your branch to the repository and open a pull request on GitHub.

---

Thank you again for your contribution!