# Go Tools Included in ddev-pi-golang

📚 **Overview**: [README.md](README.md) - Installation & usage | **Philosophy**: [SUMMARY.md](SUMMARY.md) - Tool selection rationale

This document provides a comprehensive overview of the **10 essential Go development tools** installed by this addon.

## Tool Selection Philosophy

Each tool was carefully selected based on:
- **Essential for professional Go development** - Not nice-to-haves
- **Actively maintained** - Regular updates and community support
- **Non-redundant** - Each serves a unique, irreplaceable purpose
- **IDE-independent** - Works in any environment

## Core Go Toolchain

### go (v1.26.4 by default)
The official Go compiler and toolchain.
- **Purpose**: Compile, test, run, and manage Go code
- **Key commands**: `go build`, `go test`, `go run`, `go mod`
- **Documentation**: https://go.dev/doc/

## Language Server

### gopls
The official Go Language Server Protocol (LSP) implementation.
- **Purpose**: Powers IDE features like autocomplete, go-to-definition, refactoring
- **Used by**: VS Code, Vim, Emacs, and other LSP-compatible editors
- **Why essential**: Provides intelligent code assistance in any editor
- **Documentation**: https://github.com/golang/tools/tree/master/gopls

## Code Formatting

### goimports
Format code and automatically add/remove imports.
- **Purpose**: Combines `gofmt` formatting with intelligent import management
- **Usage**: `goimports -w .` to format all files
- **Why essential**: Standard formatter used by 99% of Go projects
- **Documentation**: https://pkg.go.dev/golang.org/x/tools/cmd/goimports

## Linting & Static Analysis

### golangci-lint (v1.62.2 by default)
Fast linter aggregator running 50+ linters in parallel.
- **Purpose**: Comprehensive code quality checks (includes gosec, errcheck, staticcheck, revive, and 40+ more)
- **Usage**: `golangci-lint run`
- **Why essential**: One command runs all linters; industry standard
- **Configuration**: `.golangci.yml` in project root
- **Documentation**: https://golangci-lint.run/

### staticcheck
Advanced static analysis tool.
- **Purpose**: Find bugs and performance issues that other tools miss
- **Usage**: `staticcheck ./...`
- **Why essential**: Deepest analysis; catches subtle bugs golangci-lint may miss
- **Documentation**: https://staticcheck.io/

### govulncheck
Security vulnerability scanner for Go dependencies.
- **Purpose**: Check for known CVEs in your dependencies
- **Usage**: `govulncheck ./...`
- **Why essential**: Critical for security; catches vulnerable dependencies
- **Database**: https://vuln.go.dev/
- **Documentation**: https://pkg.go.dev/golang.org/x/vuln/cmd/govulncheck

## Testing

### gotests
Generate table-driven tests.
- **Purpose**: Automatically generate test skeletons for functions
- **Usage**: `gotests -all -w file.go`
- **Why essential**: Saves time writing boilerplate; promotes table-driven tests
- **Documentation**: https://github.com/cweill/gotests

### mockgen
Generate mock implementations for interfaces.
- **Purpose**: Create test doubles for dependency injection
- **Usage**: `mockgen -source=file.go -destination=mocks/file.go`
- **Why essential**: Required for proper unit testing with dependencies
- **Part of**: go.uber.org/mock (successor to gomock)
- **Documentation**: https://github.com/uber-go/mock

## Debugging

### dlv (Delve)
Powerful debugger for Go.
- **Purpose**: Set breakpoints, inspect variables, step through code
- **Usage**: `dlv debug` to debug main package
- **Why essential**: Only full-featured debugger for Go
- **Features**: Conditional breakpoints, goroutine inspection, expression evaluation
- **Documentation**: https://github.com/go-delve/delve

## Code Generation

### impl
Generate method stubs for implementing interfaces.
- **Purpose**: Quickly implement interface methods
- **Usage**: `impl 'r *MyType' io.Reader`
- **Why essential**: Saves time and prevents errors when implementing interfaces
- **Documentation**: https://github.com/josharian/impl

## Recommended Workflows

### Starting a New Project
```bash
go mod init github.com/user/repo
# Write code
goimports -w .
go test ./...
golangci-lint run
```

### Pre-commit Checks
```bash
goimports -w .
go mod tidy
go test -race ./...
staticcheck ./...
golangci-lint run
govulncheck ./...
```

### Debugging
```bash
# Debug main package
dlv debug

# Debug tests
dlv test ./pkg/...

# Debug running process
dlv attach <pid>
```

## Why These 10 Tools?

### What We Include
✅ **gopls** - Universal editor support  
✅ **goimports** - Standard formatting  
✅ **golangci-lint** - Comprehensive linting (includes 50+ linters)  
✅ **staticcheck** - Deepest analysis  
✅ **govulncheck** - Security scanning  
✅ **gotests** - Test generation  
✅ **mockgen** - Mock generation  
✅ **dlv** - Debugging  
✅ **impl** - Interface implementation  

### What We Don't Include (and why)
❌ **gofumpt** - Nice-to-have; goimports is the standard  
❌ **golines** - Niche use case; most teams don't use it  
❌ **revive** - Already included in golangci-lint  
❌ **go-outline** - Unmaintained; gopls provides this  
❌ **air** - Web-dev specific; not universal  
❌ **goreleaser** - Release tool, not dev tool  
❌ **gomodifytags** - Very specific use case  

## Configuration Files

### .golangci.yml
Most projects benefit from a custom golangci-lint configuration:

```yaml
linters:
  enable:
    - errcheck
    - gosimple
    - govet
    - ineffassign
    - staticcheck
    - unused
    - gofmt
    - goimports
    - misspell
    - revive
    - gosec
```

## Further Reading

- [Effective Go](https://go.dev/doc/effective_go) - Official style guide
- [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments) - Common review items
- [Standard Go Project Layout](https://github.com/golang-standards/project-layout) - Project structure
- [golangci-lint Linters](https://golangci-lint.run/usage/linters/) - All available linters

## Summary

These **10 tools** represent the minimal, essential toolkit for professional Go development:
- **No redundancy** - Each tool has a unique, irreplaceable purpose
- **Actively maintained** - All tools are under active development
- **Industry standard** - Used by professional Go teams worldwide
- **Complete coverage** - Formatting, linting, testing, debugging, and security

This streamlined toolset ensures fast build times, minimal maintenance, and maximum productivity for the Pi coding agent.

## Pi Agent Extension

In addition to these 10 Go tools, this addon includes a TypeScript extension that enhances the Pi agent with Go-specific intelligence:

**Extension**: `pi/global/agent/extensions/golang-development.ts`

**Features**:
- Injects Go tool awareness into the agent's system prompt
- Provides context-aware suggestions (e.g., suggesting `-race` flag for concurrent tests)
- Offers post-development reminders (e.g., running tests after Go file changes)
- Guides toward Go best practices and idioms

**Example Behaviors**:
- Detects `go test` commands and suggests adding `-race` flag
- Recommends `goimports` when user tries `gofmt`
- Reminds to run tests after editing `.go` files

For more details on the extension and agent integration, see the [README.md](README.md) "Pi Agent Enhancements" section.
