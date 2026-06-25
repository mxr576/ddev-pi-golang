//#ddev-generated
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { isToolCallEventType } from "@earendil-works/pi-coding-agent";

/**
 * Go development extension for Pi coding agent
 * Provides tool awareness and contextual suggestions
 */
export default function (pi: ExtensionAPI) {
  // Inject available Go tools into system prompt
  pi.on("before_agent_start", async (event, ctx) => {
    const goTools = `

## Go Development Environment

Available Go tools:
- \`go\` - Go toolchain (build, test, run, mod)
- \`gopls\` - Language Server
- \`goimports\` - Format and manage imports
- \`golangci-lint\` - Comprehensive linter (50+ linters)
- \`staticcheck\` - Advanced static analysis
- \`govulncheck\` - Security vulnerability scanner
- \`gotests\` - Generate table-driven tests
- \`mockgen\` - Generate mocks
- \`dlv\` - Debugger
- \`impl\` - Generate interface stubs

Prefer \`goimports\` over \`gofmt\`. Use \`go test -race\` for concurrency testing.
`;

    return {
      systemPrompt: event.systemPrompt + goTools,
    };
  });

  // Provide contextual suggestions
  pi.on("tool_call", async (event, ctx) => {
    if (isToolCallEventType("bash", event)) {
      const cmd = event.input.command;

      // Suggest race detector for tests
      if (/^go\s+test/.test(cmd) && !cmd.includes("-race") && !cmd.includes("-short")) {
        ctx.ui.notify("💡 Consider 'go test -race' for concurrency issues", "info");
      }

      // Suggest goimports over gofmt
      if (/^gofmt/.test(cmd)) {
        ctx.ui.notify("💡 Use 'goimports' instead - it also manages imports", "info");
      }
    }
  });

  // Suggest running tests after Go file changes
  pi.on("agent_finish", async (event, ctx) => {
    const messages = event.messages || [];
    const hasGoChanges = messages.some((msg: any) => {
      const content = typeof msg.content === 'string' ? msg.content : '';
      return content.includes('.go') && (content.includes('write') || content.includes('edit'));
    });

    if (hasGoChanges) {
      ctx.ui.notify("📝 Consider: go test ./... && golangci-lint run", "info");
    }
  });
}
