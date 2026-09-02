# Role: devmachine_ai_agents_mcp

Ansible role to configure AI agents on developer workstations with MCP (Model Context Protocol) servers.
It starts with the GitHub MCP server, dynamically reading credentials (`GITHUB_PERSONAL_ACCESS_TOKEN`) from the `.env` file or role variables.

## Supported AI Agent Clients
- **Gemini CLI** (`~/.gemini/settings.json`)
- **Claude Desktop** (`~/.config/Claude/claude_desktop_config.json`)
- **Claude Code** (`~/.claude.json`)
- **VSCode Cline Extension** (`~/.config/Code/User/globalStorage/saoudrizwan.claude-dev/settings/cline_mcp_settings.json`)
- **VSCode Roo-Code Extension** (`~/.config/Code/User/globalStorage/rooveterinaryinc.roo-cline/settings/cline_mcp_settings.json`)
- **OpenCode** (`~/.config/opencode/opencode.json`)
- **Shell Environment** (`~/.bashrc_ai_mcp` loaded in `~/.bashrc`)

## Environment Variables (.env)
Set your GitHub token in `.env`:
```bash
GITHUB_PERSONAL_ACCESS_TOKEN="ghp_your_token_here"
```

## Role Variables
| Variable | Default | Description |
|---|---|---|
| `mcp_dotenv_paths` | `["{{ playbook_dir }}/../.env", ...]` | Paths searched to locate `.env` |
| `github_personal_access_token` | `""` | Optional fallback token override |
| `configure_gemini_mcp` | `true` | Configure Gemini CLI MCP settings |
| `configure_claude_desktop_mcp` | `true` | Configure Claude Desktop MCP settings |
| `configure_claude_code_mcp` | `true` | Configure Claude Code MCP settings |
| `configure_vscode_cline_mcp` | `true` | Configure VSCode Cline / Roo-Code MCP |
| `configure_opencode_mcp` | `true` | Configure OpenCode MCP |
| `configure_shell_env_mcp` | `true` | Configure MCP shell environment exports |

## Example Usage
```yaml
- hosts: devmachines_workstations
  become: yes
  roles:
    - devmachine_ai_agents_mcp
```
