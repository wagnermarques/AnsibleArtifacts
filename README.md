# Ansible Artifacts for Linux and Cloud

A modular and portable Ansible project for automating personal development workstations and project-specific virtual machines.

## Architecture & Philosophy

This project distinguishes between your **Personal Development Machine** (your desktop/laptop) and **Project VMs** (remote or local environments for specific projects like 'Catracas').

*   **Universal Roles:** `common` and `docker` are applied to all machines.
*   **Specialized Roles:** `devmachine_*` roles are exclusive to your personal workstation.
*   **Project Playbooks:** Each project or environment type has its own top-level playbook.

## Supported Distributions
*   Debian / Ubuntu
*   Fedora
*   Alpine Linux

## Project Structure

```text
AnsibleArtifacts/
├── inventory/
│   └── hosts.ini            # Define [workstations] and [catracas_vms] here
├── playbooks/
│   ├── devmachine-setup.yml  # Full setup for your personal desktop
│   └── projcatracasvm-setup.yml # Clean setup for project VMs
├── roles/
│   ├── common/              # Base system tools (All targets)
│   ├── docker/              # Container engine (All targets)
│   ├── devmachine_tools/    # Personal dev packages (Workstation only)
│   └── devmachine_dotfiles/ # Personal shell/config (Workstation only)
└── README.md
```

## Usage

### 1. Prerequisites
Install the required Ansible collections:
```bash
ansible-galaxy collection install -r requirements.yml
```

### 2. Setup your Local Desktop (DevMachine)
This installs your base tools, docker, development languages (Node/Python), and applies your dotfile customizations.
```bash
ansible-playbook playbooks/devmachine-setup.yml -K
```

### 3. Setup a Project VM (Catracas)
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
| **SQuirreL SQL** | `devmachine-setup.yml` | `fzl-squirrelsql-start` |

### How to use
After running the corresponding playbook, source your shell configuration to activate the new commands:
```bash
source ~/.bashrc
```
Then simply type the command (e.g., `fzl-telegram-start`) in your terminal to launch the application.

## Future Work
*   **Phase 2:** Implement Azure Cloud infrastructure automation in `playbooks/azure-infra.yml`.
*   **Project Roles:** Add roles specific to the 'Catracas' project requirements.
