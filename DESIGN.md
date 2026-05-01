# Design Document: Ansible Artifacts for Linux and Cloud

This project aims to provide a structured, modular Ansible repository for automating Linux system setup, software development environments, and Azure cloud resources.

## 1. Project Structure (Monorepo)

We will follow Ansible best practices with a monorepo structure to keep everything organized and easily accessible.

```text
AnsibleArtifacts/
├── ansible.cfg              # Ansible configuration defaults
├── inventory/               # Inventory files for different environments
│   ├── local.ini            # For local machine or VM setup
│   └── azure.ini            # Dynamic or static inventory for Azure resources
├── group_vars/              # Global and group-specific variables
│   ├── all.yml              # Variables shared by all hosts
│   └── workstations.yml     # Variables for dev workstations
├── playbooks/               # Top-level playbooks
│   ├── site.yml             # Master playbook (includes others)
│   ├── bootstrap.yml        # Base system setup
│   ├── docker.yml           # Container environment setup
│   ├── dev-tools.yml        # Development environment setup
│   └── azure-infra.yml      # Azure resource management
├── roles/                   # Modular, reusable components
│   ├── common/              # Base packages, users, SSH configuration
│   ├── docker/              # Docker and Docker Compose installation
│   ├── dotfiles/            # Personal workspace and config files
│   └── dev_tools/           # Software dev tools (Node, Python, Go, etc.)
├── requirements.yml         # External role dependencies (e.g., from Galaxy)
└── README.md                # Usage instructions and documentation
```

## 2. Initial Automation Tasks

### Phase 1: Base & Environment
*   **Role: `common`**
    *   System update/upgrade.
    *   Essential packages: `git`, `curl`, `vim`, `tmux`, `htop`, `ufw`.
    *   User creation and sudo configuration.
*   **Role: `docker`**
    *   Install Docker Engine and Docker Compose.
    *   Manage the `docker` group.
*   **Role: `dotfiles`**
    *   Setup user configuration files (bashrc, vimrc, etc.).
*   **Role: `dev_tools`**
    *   Install development essentials (`build-essential`).
    *   Version managers or direct installs for Node.js, Python, and Go.

### Phase 2: Cloud (Azure)
*   **Playbook: `azure-infra.yml`**
    *   Resource Group creation.
    *   Virtual Network and Subnet setup.
    *   Basic Virtual Machine provisioning.

## 3. Implementation Plan

1.  **Initialize Project Structure:** Create the directories and basic config files.
2.  **Base Role (`common`):** Implement the first set of system setup tasks.
3.  **Local Inventory:** Set up a `local.ini` to test on the current machine or a local VM.
4.  **Sequential Implementation:** Build out `docker`, `dotfiles`, and `dev_tools` roles.
5.  **Azure Integration:** Set up the Azure collection and basic provisioning playbook.

## 4. Testing Strategy
*   Use `ansible-playbook --check` for dry runs.
*   Test roles individually using specific playbooks.
*   (Future) Use Molecule for automated role testing.
