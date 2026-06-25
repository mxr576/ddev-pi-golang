#!/usr/bin/env bash
#ddev-generated
set -eu -o pipefail

# Install essential Go development tools
# This script runs as root during Docker build, but installs tools as the pi user

export PATH="/usr/local/go/bin:${PATH}"
export GOPATH="${USER_HOME}/go"
export GOBIN="${GOPATH}/bin"

echo "Installing Go development tools..."

# Create Go workspace directories for the user
sudo -u "${USERNAME}" mkdir -p "${GOPATH}/src" "${GOPATH}/pkg" "${GOBIN}"

# Install gopls (Go Language Server) - Essential for IDE/editor features
echo "Installing gopls (Go Language Server)..."
sudo -u "${USERNAME}" GOPATH="${GOPATH}" GOBIN="${GOBIN}" /usr/local/bin/go install golang.org/x/tools/gopls@latest

# Install goimports - Format code and manage imports
echo "Installing goimports..."
sudo -u "${USERNAME}" GOPATH="${GOPATH}" GOBIN="${GOBIN}" /usr/local/bin/go install golang.org/x/tools/cmd/goimports@latest

# Install golangci-lint - Comprehensive linting (runs 50+ linters)
echo "Installing golangci-lint..."
GOLANGCI_VERSION="${GOLANGCI_LINT_VERSION:-1.62.2}"
curl -fsSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | \
  sudo -u "${USERNAME}" sh -s -- -b "${GOBIN}" "v${GOLANGCI_VERSION}"

# Install staticcheck - Advanced static analysis
echo "Installing staticcheck..."
sudo -u "${USERNAME}" GOPATH="${GOPATH}" GOBIN="${GOBIN}" /usr/local/bin/go install honnef.co/go/tools/cmd/staticcheck@latest

# Install govulncheck - Security vulnerability scanner
echo "Installing govulncheck..."
sudo -u "${USERNAME}" GOPATH="${GOPATH}" GOBIN="${GOBIN}" /usr/local/bin/go install golang.org/x/vuln/cmd/govulncheck@latest

# Install gotests - Generate table-driven tests
echo "Installing gotests..."
sudo -u "${USERNAME}" GOPATH="${GOPATH}" GOBIN="${GOBIN}" /usr/local/bin/go install github.com/cweill/gotests/gotests@latest

# Install dlv (Delve) - Go debugger
echo "Installing delve debugger..."
sudo -u "${USERNAME}" GOPATH="${GOPATH}" GOBIN="${GOBIN}" /usr/local/bin/go install github.com/go-delve/delve/cmd/dlv@latest

# Install mockgen - Generate mock implementations for testing
echo "Installing mockgen..."
sudo -u "${USERNAME}" GOPATH="${GOPATH}" GOBIN="${GOBIN}" /usr/local/bin/go install go.uber.org/mock/mockgen@latest

# Install impl - Generate interface method stubs
echo "Installing impl..."
sudo -u "${USERNAME}" GOPATH="${GOPATH}" GOBIN="${GOBIN}" /usr/local/bin/go install github.com/josharian/impl@latest

# Create symlinks for Go tools in /usr/local/bin (always in PATH)
echo "Creating symlinks for Go tools..."
for tool in gopls goimports golangci-lint staticcheck govulncheck gotests dlv mockgen impl; do
  if [ -f "${GOBIN}/${tool}" ]; then
    ln -sf "${GOBIN}/${tool}" "/usr/local/bin/${tool}"
    echo "  ✓ Symlinked: /usr/local/bin/${tool}"
  else
    echo "  ✗ Not found: ${GOBIN}/${tool}"
  fi
done

# Set ownership
chown -R "${USER_UID}:${USER_GID}" "${GOPATH}"

echo "Go development tools installed successfully."
