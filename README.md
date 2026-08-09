
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

### 3. Setup Infrastructure Network Machine (Install mitmproxy & tcpdump)
Installs `mitmproxy` (including `mitmproxy`, `mitmdump`, and `mitmweb`) and `tcpdump` portably across Debian/Debian-like (Ubuntu), Fedora, and Alpine Linux distributions.

```bash
ansible-playbook playbooks/infranetworkmachine-setup.yml --ask-become-pass
```

### 4. Install Gluon Scene Builder
Installs the official JavaFX UI design tool (Gluon Scene Builder 21.0.0) portably on Debian/Ubuntu (via `.deb`), Fedora/RedHat (via `.rpm`), and Alpine Linux (via Flatpak).

```bash
ansible-playbook playbooks/devmachine-java-install-scenebuilder.yml --ask-become-pass
```

### 5. Install Java Build Tools (Gradle, Maven, Ant)
Installs Java development build tools (**Gradle**, **Maven**, and **Ant**) portably across Linux distributions (Debian/Ubuntu, Fedora/RedHat, Alpine, Arch) with support for package managers and standalone binary fallback.

```bash
ansible-playbook playbooks/devmachine-java-install-buildtools.yml --ask-become-pass
```

### 6. Create a Windows 11 libvirt VM from ISO
Creates a local Windows 11 virtual machine on a Fedora workstation using libvirt, UEFI, Secure Boot, and TPM 2.0. The playbook defaults to the ISO path `/home/wgn/VIRT/pt-br_windows_11_consumer_editions_version_25h2_x64_dvd_d4d3cf4d.iso`, and you can override the VM name or ISO path with `-e`.

```bash
ansible-playbook playbooks/devmachine-virtualization-create-windows11-vm.yml -K
```

### 7. Configure Fedora Desktop Security Setup
Configures security settings on Fedora Desktop systems, including substituting `/etc/security/pwquality.conf` with custom settings from `conf-files/fedora/pwquality.conf`, enabling `firewalld`, setting SELinux to enforcing, and hardening SSH daemon policies.

```bash
ansible-playbook playbooks/desktop-fedora-security-setup.yml --ask-become-pass
```

### 8. Configure Xfce4 Touchpad (Tap-to-Click + Two-Finger Right-Click)
Enables tap-to-click on the laptop touchpad and maps a two-finger tap to right-click, via a permanent `/etc/X11/xorg.conf.d/90-touchpad.conf` libinput config plus an immediate `xfconf-query` live setting.

```bash
ansible-playbook playbooks/desktop-fedora-postinstall-xfce4-touchpad-setup.yml --ask-become-pass
```

### 9. Enable RPM Fusion & Install Multimedia Codecs
Enables the RPM Fusion Free and Nonfree repositories, swaps `ffmpeg-free` for full `ffmpeg`, updates the `multimedia` and `sound-and-video` groups, and installs GStreamer plugins plus Intel/AMD hardware video acceleration drivers.

```bash
ansible-playbook playbooks/desktop-fedora-postinstalation-multimedia-codecs-setup.yml --ask-become-pass
```

### 10. Centralized Language Servers Setup (LSP)
Installs `@github/copilot-language-server`, `rust-analyzer` (Rust LSP), `typescript-language-server`, `vscode-langservers-extracted`, `yaml-language-server`, `bash-language-server`, `pyright`, `pylsp`, `gopls`, `clangd`, and other common LSPs globally in system `$PATH` so Emacs, VS Code, Theia, Neovim, and IntelliJ can use shared executables.

```bash
ansible-playbook playbooks/devmachine-lsp-setup.yml --ask-become-pass
```

#### Configuring VS Code / Theia to use Centralized LSPs
Add the following options to your VS Code `settings.json` (`~/.config/Code/User/settings.json`):

```json
{
  "rust-analyzer.server.path": "/usr/bin/rust-analyzer",
  "clangd.path": "/usr/bin/clangd",
  "go.alternateTools": {
    "gopls": "/usr/local/bin/gopls"
  },
  "typescript.tsdk": "/usr/lib/node_modules/typescript/lib",
  "python.languageServer": "Pyright"
}
```

#### Configuring Emacs
Emacs (`eglot` or `lsp-mode`) automatically finds these executables on your system `$PATH`. For GitHub Copilot in Emacs, run `M-x copilot-login` after starting `copilot-mode`.

#### IDE & Language Server Documentation Links

| Editor / Tool | Category | Documentation / Configuration Link |
| :--- | :--- | :--- |
| **VS Code** | IDE | [Language Server Protocol in VS Code](https://code.visualstudio.com/api/language-extensions/language-server-extension-guide) |
| **Eclipse Theia** | IDE | [Theia Framework LSP Integration](https://theia-ide.org/docs/) |
| **Emacs (Eglot)** | IDE | [Emacs Eglot User Manual](https://www.gnu.org/software/emacs/manual/html_node/eglot/index.html) |
| **Emacs (lsp-mode)** | IDE | [Emacs lsp-mode Documentation](https://emacs-lsp.github.io/lsp-mode/) |
| **Neovim** | IDE | [Neovim nvim-lspconfig Documentation](https://neovim.io/doc/user/lsp.html) |
| **IntelliJ IDEA** | IDE | [JetBrains LSP Plugin Docs](https://plugins.jetbrains.com/docs/intellij/language-server-protocol.html) |
| **GitHub Copilot LS** | LSP | [Copilot Language Server Repo](https://github.com/github/copilot-language-server) |
| **rust-analyzer** | LSP | [rust-analyzer User Manual](https://rust-analyzer.github.io/manual.html) |
| **Pyright** | LSP | [Pyright Documentation](https://microsoft.github.io/pyright/#/) |
| **gopls** | LSP | [gopls Documentation](https://github.com/golang/tools/blob/master/gopls/README.md) |
| **clangd** | LSP | [clangd Documentation](https://clangd.llvm.org/) |

### 11. Setup Fonts & Nerd Fonts for Fedora Desktop and Emacs Treemacs
Installs common system fonts (`fira-code-fonts`, `jetbrains-mono-fonts`, `cascadia-fonts-all`, `liberation-fonts`, `google-noto-sans-fonts`, `google-noto-emoji-color-fonts`, `fontawesome-fonts`) and Nerd Fonts (`FiraCode`, `JetBrainsMono`, `CascadiaCode`, `NerdFontsSymbolsOnly`, `Hack`) plus `all-the-icons` for Emacs Treemacs.

```bash
ansible-playbook playbooks/desktop-fedora-postinstall-fonts-setup.yml --ask-become-pass
```

#### Configuring Emacs Treemacs with Nerd Icons
To use Nerd Font icons in Emacs Treemacs, add to your `init.el` or `.emacs`:

```elisp
(use-package treemacs-nerd-icons
  :ensure t
  :config
  (treemacs-load-theme "nerd-icons"))
```

### 12. Setup Docker & Docker Compose
Installs Docker Engine (`docker-ce`), Docker CLI, containerd, `docker-buildx-plugin`, and `docker-compose-plugin` (`docker compose`), and adds your user to the `docker` group.

```bash
ansible-playbook playbooks/devmachine-docker-setup.yml --ask-become-pass
```

### 13. Classroom Tutorial & Screenshot Automation Suite (Linux Alternative to Folge)
Installs `flameshot`, `ksnip`, `screenkey`, `gromit-mpx`, and an automated click-triggered screenshot capture utility (`fzl-auto-screenshot`) for generating step-by-step documentation.

```bash
ansible-playbook playbooks/classrooms-tools-folge-setup.yml --ask-become-pass
```

#### Guia de Uso: Captura Automática de Screenshots (`fzl-auto-screenshot`)

O `fzl-auto-screenshot` é um utilitário de código aberto que captura screenshots automaticamente a cada clique do mouse (botão esquerdo), ideal para criar tutoriais passo a passo (ex: criação de projetos no Android Studio).

##### Passo a passo para utilização:

1. **Iniciar a captura**:
   Abra o terminal e execute:
   ```bash
   fzl-auto-screenshot
   ```
   *(Você também pode iniciar pelo menu de aplicativos procurando por **"FZL Auto Screenshot Capture"**).*

2. **Executar as ações do tutorial**:
   - Abra a aplicação que deseja documentar (ex: Android Studio).
   - Clique normalmente nos botões e menus do processo. A cada clique, o script salvará uma imagem (`step_001_...png`, `step_002_...png`).
   - Todas as capturas são salvas na pasta: `~/Pictures/Tutorial_Screenshots/`.

3. **Encerrar a captura**:
   - No terminal onde o script foi iniciado, pressione `Ctrl + C`.

4. **Ferramentas complementares**:
   - **`flameshot gui`**: Para adicionar setas, textos, números e desfoque nas imagens.
   - **`screenkey`**: Para exibir atalhos de teclado e cliques em tempo real sobre a tela.
   - **`gromit-mpx`**: Pressione `F9` para desenhar diretamente sobre a tela durante apresentações ou videoaulas.

### 14. MetaTrader 5 (MT5) Trading Platform Setup for Fedora Linux
Installs MetaTrader 5 via Wine 64-bit with all required system dependencies, creates a desktop launcher, and provides full compatibility for algorithmic trading and BTG Pactual B3 broker integration.

```bash
ansible-playbook playbooks/fin-trader-metatrader5.yml --ask-become-pass
```

For detailed setup instructions, broker connection steps, and Python/EA automation guides, see [docs/fin-trader-metatrader5-usage.org](file:///home/wgn/mnt/ext4/Projects-Srcs/Projects-Srcs-FzlSoft/AnsibleArtifacts/docs/fin-trader-metatrader5-usage.org).










## AI Agents & Documentation

The `iamachine-setup.yml` playbook installs a powerful suite of AI assistants. For detailed getting started instructions for each tool, see [docs/iamachine-usage.org](file:///home/wgn/mnt/ext4/Projects-Srcs/Projects-Srcs-FzlSoft/AnsibleArtifacts/docs/iamachine-usage.org).

Below are the links to their official documentation and repositories:

| Agent | Category | Documentation / Link |
| :--- | :--- | :--- |
| **Claude Code** | NPM | [Official Docs](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code) |
| **Gemini CLI** | NPM | [GitHub Repo](https://github.com/google/gemini-cli) |
| **Gemini CLI MCP**| NPM | [MCP Servers Info](https://modelcontextprotocol.io) |
| **GitHub Copilot** | NPM | [Official Docs](https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line) |
| **Kimi Code** | Script / CLI | [Kimi Code Docs](https://code.kimi.com) |
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
| **Eclipse Modeling** | `devmachine-setup-ides.yml` | `fzl-eclipse-modeling-start` |


### How to use
After running the corresponding playbook, source your shell configuration to activate the new commands:
```bash
source ~/.bashrc
```
Then simply type the command (e.g., `fzl-telegram-start`) in your terminal to launch the application.
    
    
    
    
## TODO
### Mangage Browsers Plugins
IPvFoo, Zotero, FireShot, LibJsDetector

### OpenSource Fonts
sudo dnf install fira-code-fonts jetbrains-mono-fonts liberation-fonts google-noto-sans-fonts google-noto-emoji-color-fonts cascadia-fonts-all
### desktopmachine-sysadmintools
sudo dnf install kde-connect sudo dnf install timeshift
Timeshift creates snapshots of your root (and optionally home) directories. If an update or a bad config ever breaks your system, you can restore a snapshot and get back to a working desktop without reinstalling Fedora 44.
sudo dnf remove tlp tlp-rdw
Boost Performance with auto-cpufreq

If you run Fedora 44 on a laptop and want full CPU control, install auto-cpufreq. It automatically manages CPU frequency and power based on your workload. This is best suited for systems with powerful CPUs.

Important: Remove TLP first if it’s installed, to avoid conflicts:

sudo nano /etc/security/pwquality.conf
minlen = 3
minclass = 0

