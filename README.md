# Go Starter Templates for Firebase Studio

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
<!-- Add other badges as relevant, e.g., build status, PRs welcome -->

<a href="https://studio.firebase.google.com/new?template=https%3A%2F%2Fgithub.com%2Fcontextvibes%2Ffirebase-studio-go">
  <picture>
    <source
      media="(prefers-color-scheme: dark)"
      srcset="https://cdn.firebasestudio.dev/btn/open_dark_32.svg">
    <source
      media="(prefers-color-scheme: light)"
      srcset="https://cdn.firebasestudio.dev/btn/open_light_32.svg">
    <img
      height="32"
      alt="Open in Firebase Studio"
      src="https://cdn.firebasestudio.dev/btn/open_blue_32.svg">
  </picture>
</a>

This repository provides a collection of Go application templates designed to accelerate development using [Google's Firebase Studio](https://studio.firebase.google.com/). It also serves as a showcase for the AI-led development methodology used to build it.

## Vision

To provide a comprehensive set of high-quality, production-ready Go starter templates that integrate seamlessly with Firebase Studio, enabling developers to quickly bootstrap new Go applications with best practices in mind.

## Available Templates

Currently, the following templates are available:

1.  **Cloud Run API Server (Hello World)**
    *   **Description:** A simple "Hello World" style HTTP API server built in Go, ready for deployment on Google Cloud Run. It features structured logging, configuration management, and a ready-to-use Dockerfile.
    *   **Location:** [`./cloud-run-api/`](./cloud-run-api/)
    *   **Quick Start:** See the [Cloud Run API README](./cloud-run-api/README.md) for detailed instructions.

2.  **CLI Tool**
    *   **Description:** A starter template for building a command-line interface (CLI) application in Go.
    *   **Location:** [`./cli-tool/`](./cli-tool/)
    *   **Quick Start:** See the [CLI Tool README](./cli-tool/README.md) for detailed instructions.

*(More templates will be added over time!)*

## The Automation Factory

This repository is built on a powerful but simple automation framework called "The Factory," designed to make development and contribution easy and consistent. All common tasks—from building and testing to creating pull requests—are handled by a single, user-friendly command menu.

To see all available commands, simply run the following from your terminal:

```bash
task
```

This provides a consistent, high-level interface for all development workflows. For a full guide on using and extending the factory, please see our **[Factory Guide](./docs/guides/factory-guide.md)**.

## Documentation

For guides on using the templates, extending the automation framework, or understanding the AI-led development process used to create this repository, please see our **[Full Documentation Hub](./docs/README.md)**.

## Contributing

Contributions are highly welcome! Whether it's proposing a new template, improving an existing one, or enhancing the documentation, your help is appreciated.

Please read our [Contributing Guidelines](CONTRIBUTING.md) for more details on how to get started.

## Community and Code of Conduct

This project has adopted the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/). We are committed to providing a welcoming and harassment-free experience for everyone. All contributors and participants are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

## License

This project and its templates are licensed under the MIT License. See the [LICENSE](LICENSE) file for details.