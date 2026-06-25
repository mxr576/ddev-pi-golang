#!/usr/bin/env bash
#ddev-generated
set -eu -o pipefail

# Install Go from official source
# This script runs as root during the Docker build process

# Allow version override via build arg or environment variable
GOLANG_VERSION="${GOLANG_VERSION:-1.26.4}"
GOLANG_ARCH="amd64"

# Detect architecture
case "$(uname -m)" in
  x86_64)  GOLANG_ARCH="amd64" ;;
  aarch64) GOLANG_ARCH="arm64" ;;
  armv7l)  GOLANG_ARCH="armv6l" ;;
  *)       echo "Unsupported architecture: $(uname -m)"; exit 1 ;;
esac

echo "Installing Go ${GOLANG_VERSION} for ${GOLANG_ARCH}..."

# Download and install Go
cd /tmp
curl -fsSL "https://go.dev/dl/go${GOLANG_VERSION}.linux-${GOLANG_ARCH}.tar.gz" -o go.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf go.tar.gz
rm go.tar.gz

# Create Go cache directories (avoid /tmp noexec restrictions)
mkdir -p /home/pi/.cache/go-tmp
mkdir -p /home/pi/.cache/go-build
chown -R pi:pi /home/pi/.cache

# Create wrappers in /usr/local/bin so Go commands are in PATH for all contexts
echo '#!/bin/sh' > /usr/local/bin/go
echo 'export GOPATH="${GOPATH:-/home/pi/go}"' >> /usr/local/bin/go
echo 'export GOBIN="${GOBIN:-/home/pi/go/bin}"' >> /usr/local/bin/go
echo 'export GOTMPDIR="${GOTMPDIR:-/home/pi/.cache/go-tmp}"' >> /usr/local/bin/go
echo 'export PATH="/usr/local/go/bin:${GOBIN}:${PATH}"' >> /usr/local/bin/go
echo 'exec /usr/local/go/bin/go "$@"' >> /usr/local/bin/go
chmod +x /usr/local/bin/go

# Create wrappers for other Go binaries that might be called directly
for cmd in gofmt; do
  echo '#!/bin/sh' > "/usr/local/bin/${cmd}"
  echo "exec /usr/local/go/bin/${cmd} \"\$@\"" >> "/usr/local/bin/${cmd}"
  chmod +x "/usr/local/bin/${cmd}"
done

# Verify installation
/usr/local/bin/go version

echo "Go ${GOLANG_VERSION} installed successfully."
