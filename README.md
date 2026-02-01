# go-starter

A minimal Go starter repository with VSCode configuration, linting, testing, a Makefile for custom commands, and pre-push hooks.

## Prerequisites

- Go 1.25+
- [golangci-lint](https://golangci-lint.run)
- Make
- dprint
- VSCode with the Go extension installed (pre-release version is required to support golangci-lint v2)

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
