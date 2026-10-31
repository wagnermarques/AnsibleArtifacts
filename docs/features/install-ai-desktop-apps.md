# Feature: AI Desktop GUI Applications Playbook (ChatGPT, Claude & AI Assistants)

- **Status**: Completed
- **Date**: 2026-10-30
- **Author/Agent**: Antigravity Assistant & wgn
- **Target Components**: `playbooks/install-ai-desktop-apps.yml`, FZL launchers (`/usr/local/bin/fzl-chatgpt*`, `/usr/local/bin/fzl-claude*`), Desktop entries, `playbooks/iamachine-setup.yml`
- **Document Path**: `docs/features/install-ai-desktop-apps.md`

---

## 1. Goal & Overview

### 1.1 Objective
Provide a unified, idempotent Ansible playbook (`playbooks/install-ai-desktop-apps.yml`) to install and configure official native Linux desktop GUI applications for **ChatGPT** (OpenAI official native RPM/DEB release) and **Claude Desktop** (Anthropic official release via COPR RPM on Fedora and official signed APT repo on Debian/Ubuntu), complete with standard FZL launcher scripts (`fzl-<app>` and `fzl-<app>-start`) and desktop shortcuts.

### 1.2 Motivation & Business/Technical Value
While CLI agents (Aider, Claude Code, Antigravity CLI) excel at command-line workflows and codebase editing, developers often require GUI interfaces for multimodal reasoning, canvas editing, interactive chatting, and desktop-level Cowork/Codex capabilities. Installing these manually involves finding obscure package URLs, enabling repositories, or handling Electron sandbox flags. Automating this across Fedora and Debian/Ubuntu ensures consistency, zero-friction provisioning, and alignment with FZL application launcher conventions.

### 1.3 Scope & Acceptance Criteria
- [x] Create `playbooks/install-ai-desktop-apps.yml` supporting Fedora and Debian/Ubuntu.
- [x] Install official **ChatGPT Desktop** (via OpenAI's official `.rpm` on Fedora and `.deb` on Debian).
- [x] Install official **Claude Desktop** (via `dewzor/claude-desktop` COPR on Fedora and Anthropic's official APT repository on Debian/Ubuntu).
- [x] Create FZL standard executable launchers in `/usr/local/bin` (`fzl-chatgpt`, `fzl-chatgpt-start`, `fzl-claude`, `fzl-claude-start`).
- [x] Verify desktop application shortcuts (`.desktop`) and desktop database updating.
- [x] Validate playbook syntax (`ansible-playbook --syntax-check`).
- [x] Reference the playbook in `docs/iamachine-usage.org` and integrate with `playbooks/iamachine-setup.yml`.

---

## 2. Task Breakdown & Justifications

### Task 1: Initialize Feature Tracking Document
- **Status**: [x] Completed
- **Justification**: Enforces global repository standards and the `feature-lifecycle` skill to maintain complete visibility, clear scope, and an audit trail before modifying system configuration.
- **Affected Components/Files**:
  - `docs/features/install-ai-desktop-apps.md`
- **What Was Done**:
  - Created initial feature lifecycle specification with objectives, acceptance criteria, and justified task breakdown.

### Task 2: Create `playbooks/install-ai-desktop-apps.yml`
- **Status**: [x] Completed
- **Justification**: A dedicated standalone playbook allows developers to install or update AI GUI applications independently and on-demand without executing unrelated developer language runtimes or heavy virtual machine tasks.
- **Affected Components/Files**:
  - `playbooks/install-ai-desktop-apps.yml`
- **What Was Done**:
  - Created standalone playbook `playbooks/install-ai-desktop-apps.yml`.
  - Configured conditional OS and architecture discovery for official ChatGPT RPM (`https://persistent.oaistatic.com/codex-app-prod/linux/rpm/latest/chatgpt.x86_64.rpm`) and DEB packages.
  - Configured `dewzor/claude-desktop` COPR repository and package installation for Fedora, and official signed APT repository for Debian/Ubuntu.
  - Verified playbook syntax with `ansible-playbook --syntax-check playbooks/install-ai-desktop-apps.yml`.

### Task 3: Create FZL Launcher Scripts and Desktop Integrations
- **Status**: [x] Completed
- **Justification**: Adheres to the core repository guideline requiring standalone GUI applications to provide `fzl-<app>` foreground and `fzl-<app>-start` background command launchers, providing a reliable terminal interface for power users.
- **Affected Components/Files**:
  - `/usr/local/bin/fzl-chatgpt`
  - `/usr/local/bin/fzl-chatgpt-start`
  - `/usr/local/bin/fzl-claude`
  - `/usr/local/bin/fzl-claude-start`
- **What Was Done**:
  - Added tasks to deploy `/usr/local/bin/fzl-chatgpt` and background runner `/usr/local/bin/fzl-chatgpt-start`.
  - Added tasks to deploy `/usr/local/bin/fzl-claude` and background runner `/usr/local/bin/fzl-claude-start`.
  - Added desktop database refresh task (`update-desktop-database /usr/share/applications`).

### Task 4: Integrate Playbook with `iamachine-setup.yml` & Documentation
- **Status**: [x] Completed
- **Justification**: `iamachine-setup.yml` is the master provisioning orchestrator for AI machines; referencing the desktop apps playbook ensures a newly provisioned workstation receives full GUI capabilities when requested via tags.
- **Affected Components/Files**:
  - `playbooks/iamachine-setup.yml`
  - `docs/iamachine-usage.org`
- **What Was Done**:
  - Added `import_playbook: install-ai-desktop-apps.yml` tagged with `[ai_gui, chatgpt, claude, desktop_ai]` in `playbooks/iamachine-setup.yml`.
  - Updated documentation table and created dedicated "Native AI Desktop GUI Applications" section in `docs/iamachine-usage.org`.
  - Verified syntax of `playbooks/iamachine-setup.yml`.

### Task 5: Syntax Validation & Upstream Verification
- **Status**: [x] Completed
- **Justification**: Required by repository rule #3 (Always run syntax-check before applying changes) and verifies that package URLs, COPR repositories, and binary paths resolve properly without errors.
- **Affected Components/Files**:
  - `playbooks/install-ai-desktop-apps.yml`
  - `playbooks/iamachine-setup.yml`
- **What Was Done**:
  - Verified OpenAI official RPM endpoint HTTP 200: `https://persistent.oaistatic.com/codex-app-prod/linux/rpm/latest/chatgpt.x86_64.rpm`.
  - Verified Anthropic official APT repo structure: `https://downloads.claude.ai/claude-desktop/apt/stable`.
  - Verified Fedora 44 COPR repo HTTP 200: `dewzor/claude-desktop`.
  - Ran `ansible-playbook --syntax-check playbooks/install-ai-desktop-apps.yml playbooks/iamachine-setup.yml` (exit code 0).

---

## 3. Verification & Validation

### 3.1 Automated Checks
- [x] `ansible-playbook --syntax-check playbooks/install-ai-desktop-apps.yml`
- [x] `ansible-playbook --syntax-check playbooks/iamachine-setup.yml`

### 3.2 Command Execution Instructions
To execute the playbook on localhost:
```bash
ansible-playbook -i "localhost," -c local playbooks/install-ai-desktop-apps.yml -K
```
Or selectively:
```bash
ansible-playbook -i "localhost," -c local playbooks/install-ai-desktop-apps.yml -K --tags chatgpt
ansible-playbook -i "localhost," -c local playbooks/install-ai-desktop-apps.yml -K --tags claude
```

---

## 4. Execution Summary & Deliverables

### 4.1 Summary of Changes
- New standalone playbook `playbooks/install-ai-desktop-apps.yml` covering native ChatGPT and Claude Desktop setups.
- Integrated into master AI machine setup `playbooks/iamachine-setup.yml`.
- Standard FZL launchers defined for foreground and background execution.
- Documentation in `docs/iamachine-usage.org` updated with command tables and launch instructions.
