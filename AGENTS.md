# Project Guidelines: AnsibleArtifacts (AGENTS.md)

## Overview
This repository contains Ansible playbooks, roles, inventory, and templates for automated provisioning of workstations, development environments, AI tools, virtual machines, and servers.

## Repository Layout
- `playbooks/`: Top-level playbooks (e.g., `iamachine-setup.yml`, `devmachine-setup-all-features.yml`, `projcatracasvm-setup.yml`).
- `roles/`: Modular Ansible roles (e.g., `devmachine_install_ai_tools`, `devmachine_install_dev_langs`, `android_sdk`, `java_sdk`).
- `inventory/`: Host inventories (`hosts.ini`).
- `vars/`: Variable definitions and encrypted vault files (`vault-template.yml`, `vault.yml`).
- `templates/`: Jinja2 configuration templates.
- `docs/`: User documentation and guides (`iamachine-usage.org`, `DESIGN.md`).

## Development & Execution Rules
1. **Never commit raw credentials**:
   - Store secrets in `vars/vault.yml` encrypted with `ansible-vault encrypt vars/vault.yml`.
   - Store local AI CLI credentials in `.env` (which is excluded via `.gitignore`).
   - Use `vars/vault-template.yml` and `.env.template` for tracked placeholders.
2. **FZL Application Launch Pattern**:
   - Standalone GUI and CLI apps use `fzl-<app>-start` or `fzl-<app>` commands (e.g. `fzl-aider`).
3. **Syntax Validation**:
   - Always run `ansible-playbook --syntax-check playbooks/<playbook>.yml` before applying changes.
4. **Idempotency**:
   - Ensure tasks are safe to re-run multiple times without producing unexpected changes.
