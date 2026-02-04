#!/usr/bin/env bash
set -euo pipefail

# dprint
if ! command -v dprint >/dev/null 2>&1; then
  curl -fsSL https://dprint.dev/install.sh | sh
  sudo ln -sf "$HOME/.dprint/bin/dprint" /usr/local/bin/dprint
fi

# golangci-lint v2
GOLANGCI_LINT_VERSION="${GOLANGCI_LINT_VERSION:-v2.8.0}"

if ! command -v golangci-lint >/dev/null 2>&1; then
  sudo mkdir -p /usr/local/bin
  curl -sSfL https://golangci-lint.run/install.sh | sudo sh -s -- -b /usr/local/bin "${GOLANGCI_LINT_VERSION}"
fi

# VS Code Go extension uses the name "golangci-lint-v2" when configured that way.
# Provide it without breaking the normal "golangci-lint" CLI name.
if ! command -v golangci-lint-v2 >/dev/null 2>&1; then
  sudo ln -sf "$(command -v golangci-lint)" /usr/local/bin/golangci-lint-v2
fi

# git hooks
if [ -d ".githooks" ]; then
  chmod +x .githooks/* 2>/dev/null || true
  git config core.hooksPath .githooks || true
fi
