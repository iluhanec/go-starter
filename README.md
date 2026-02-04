# go-starter

A minimal Go starter repository with VSCode configuration, linting, testing, a Makefile for custom commands, and pre-push hooks.

## Prerequisites

Using Dev Containers:

- Docker

Manual setup:

- Go 1.25+
- [golangci-lint](https://golangci-lint.run)
- Make
- dprint
- VSCode with the Go extension installed (pre-release version is required to support golangci-lint v2)

> **Warning:** The VS Code Go extension expects a binary named `golangci-lint-v2` to correctly work with golangci-lint version 2. If you have `golangci-lint` installed but the extension can't find it, create a symlink:
>
> ```sh
> export GOLANG_CI_PATH=$(which golangci-lint)
> ln -s "$GOLANG_CI_PATH" "${GOLANG_CI_PATH}-v2"
>
> # Verify the symlink was created
> ls -l $(which golangci-lint-v2)
>
> # Test that golangci-lint-v2 works
> golangci-lint-v2 help
> ```

## Setup

1. Clone the repository:

   ```sh
   git clone https://github.com/iluhanec/go-starter.git
   cd go-starter
   ```

2. Configure Git hooks:

   ```sh
   git config core.hooksPath .githooks
   ```

3. Ensure the pre-push hook is executable:

   ```sh
   chmod +x .githooks/pre-push
   ```

## Running & Custom Commands

This repo uses a **Makefile** to define common tasks.
