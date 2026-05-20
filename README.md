
# Ansible Artifacts

Infrastructure as Code (IaC) for setting up development environments, math/science workstations, and application deployment.

## Key Playbooks

### 1. playbooks/devmachine-setup.yml
Installs development languages (Node.js, Python, Java), IDEs (VSCode,
JetBrains), and Docker.

```bash
ansible-playbook playbooks/devmachine-setup.yml --ask-become-pass
```

### 2. Setup AI Machine (IAMachine)
This playbook installs the most common AI agents and SDKs using NPM
and Python (isolated via `pipx`). 

It also configures **Gemini CLI Extensions (MCP)** including GitHub, Google Maps, Brave Search, Fetch, and Sequential Thinking.

**Note:** For MCP extensions to work fully, you must provide the following tokens in `vars/vault.yml`:
- `github_mcp_token`: GitHub Personal Access Token (with `repo` and `user` scopes).
- `google_maps_mcp_key`: Google Maps API Key.

```bash
ansible-playbook playbooks/iamachine-setup.yml --ask-become-pass
```

## AI Agents & Documentation

The `iamachine-setup.yml` playbook installs a powerful suite of AI assistants. Below are the links to their official documentation and repositories:

| Agent | Category | Documentation / Link |
| :--- | :--- | :--- |
| **Claude Code** | NPM | [Official Docs](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code) |
| **Gemini CLI** | NPM | [GitHub Repo](https://github.com/google/gemini-cli) |
| **Gemini CLI MCP**| NPM | [MCP Servers Info](https://modelcontextprotocol.io) |
| **GitHub Copilot** | NPM | [Official Docs](https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line) |
| **OpenClaude** | NPM | [GitHub Repo](https://github.com/Gitlawb/openclaude) |
| **v0 CLI** | NPM | [Vercel v0](https://v0.dev) |
| **Aider** | Python | [Official Site](https://aider.chat) |
| **Shell-GPT** | Python | [GitHub Repo](https://github.com/TheR1D/shell_gpt) |
| **Open Interpreter**| Python | [Official Docs](https://docs.openinterpreter.com) |

### 2. Deploy ProjCatracas VM
This provides a clean environment with only the essentials and Docker. 
1. Edit `inventory/hosts.ini` and add your VM IP under `[catracas_vms]`.
2. Run the playbook:
```bash
ansible-playbook playbooks/projcatracasvm-setup.yml -i inventory/hosts.ini -K
```


## Custom Start Commands (FZL Pattern)

This project implements a custom pattern for starting manually installed applications using `fzl-<app>-start` commands. These aliases run applications in the background using `nohup` to ensure they persist even after the terminal is closed.

### Available Commands

| Application | Provided by Playbook | Command |
| :--- | :--- | :--- |
| **Telegram Desktop** | `usermachine-setup.yml` | `fzl-telegram-start` |
| **IntelliJ IDEA** | `devmachine-setup.yml` | `fzl-intellij-start` |
| **PyCharm** | `devmachine-setup.yml` | `fzl-pycharm-start` |
| **WebStorm** | `devmachine-setup.yml` | `fzl-webstorm-start` |
| **VS Code** | `devmachine-setup.yml` | `fzl-vscode-start` |
| **DBeaver** | `devmachine-setup.yml` | `fzl-dbeaver-start` |
| **DataGrip** | `devmachine-setup.yml` | `fzl-datagrip-start` |
| **Antigravity** | `devmachine-setup.yml` | `fzl-antigravity-start` |
| **Cursor** | `devmachine-setup.yml` | `fzl-cursor-start` |

### How to use
After running the corresponding playbook, source your shell configuration to activate the new commands:
```bash
source ~/.bashrc
```
Then simply type the command (e.g., `fzl-telegram-start`) in your terminal to launch the application.
