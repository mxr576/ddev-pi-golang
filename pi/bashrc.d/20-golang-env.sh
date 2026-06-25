#!/usr/bin/env bash
#ddev-generated

# Set up Go environment for interactive shell sessions
export PATH="/usr/local/go/bin:${HOME}/go/bin:${PATH}"
export GOPATH="${HOME}/go"
export GOBIN="${GOPATH}/bin"

# Enable Go modules by default (standard since Go 1.16+)
export GO111MODULE=on

# Go private module support (useful for private repos)
# Users can override in their own bashrc.d/99-*.sh if needed
# export GOPRIVATE="github.com/yourorg/*"

# Optimize for container environments
export GOCACHE="${HOME}/.cache/go-build"
export GOMODCACHE="${GOPATH}/pkg/mod"
export GOTMPDIR="${HOME}/.cache/go-tmp"
