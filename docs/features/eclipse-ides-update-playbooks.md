# Feature: Dedicated Update Playbooks for Eclipse Modeling Tools and Eclipse Papyrus UML

- **Status**: Completed
- **Date**: 2026-11-13
- **Author/Agent**: Antigravity Assistant & wgn
- **Target Components**: `playbooks/devmachine-eclipse-modeling-update.yml`, `playbooks/uml-papirus-update.yml`, `README.md`, FZL Launchers (`/usr/local/bin/fzl-eclipse-modeling*`, `/usr/local/bin/fzl-papyrus*`, `/usr/local/bin/fzl-papirus*`)
- **Document Path**: `docs/features/eclipse-ides-update-playbooks.md`

---

## 1. Goal & Overview

### 1.1 Objective
Create two dedicated, safe, fault-tolerant Ansible playbooks to update the two Eclipse distributions managed in this repository:
1. `playbooks/devmachine-eclipse-modeling-update.yml` — Updates **Eclipse Modeling Tools** (`~/WORKING/Progsativos/ides/eclipse-modeling`).
2. `playbooks/uml-papirus-update.yml` — Updates **Eclipse Papyrus UML Modeling IDE** (`~/WORKING/Progsativos/ides/papyrus`).

### 1.2 Motivation & Value
Main setup playbooks (`devmachine-setup-ides.yml`, `uml-papirus-install.yml`) use `creates:` guards to remain fast and idempotent without unexpectedly overwriting existing IDE installations or plugins. Dedicated update playbooks allow users to intentionally upgrade either Eclipse flavor on demand with:
- Running-process protection (preventing workspace corruption if the IDE is open).
- Download-first validation with retries (ensuring the existing IDE is never touched if a download fails).
- Automatic timestamped backup of the previous installation before replacement (configurable via `keep_backup`).
- Standardized FZL command launchers (`fzl-<app>`, `fzl-<app>-start`, `fzl-<app>-logs`) and WebKitGTK/SWT freeze-prevention flags.

### 1.3 Scope & Acceptance Criteria
- [x] Create `docs/features/eclipse-ides-update-playbooks.md` tracking implementation and verification.
- [x] Create `playbooks/devmachine-eclipse-modeling-update.yml` with process guard, download-first retry, backup/replace, WebKit `eclipse.ini` fixes, FZL launchers, and desktop entry.
- [x] Create `playbooks/uml-papirus-update.yml` with process guard, download-first retry, backup/replace, symlinks, WebKit `papyrus-desktop.ini` fixes, FZL launchers (`fzl-papyrus*` and `fzl-papirus*`), shell aliases, and desktop entry.
- [x] Update `README.md` with Key Playbooks section 18 and updated Custom Start Commands table entries.
- [x] Pass `ansible-playbook --syntax-check` for both new playbooks.

---

## 2. Task Breakdown & Justifications

### Task 1: Initialize Feature Lifecycle Document
- **Status**: [x] Completed
- **Justification**: Required by `skills/global/feature-lifecycle/SKILL.md` to establish clear goals, explicit task justifications, and an auditable progress log before modifying repository files.
- **Affected Components/Files**:
  - `docs/features/eclipse-ides-update-playbooks.md`
- **What Was Done**:
  - Created `docs/features/eclipse-ides-update-playbooks.md` with metadata, goals, acceptance criteria, and justified task breakdown.

### Task 2: Create `playbooks/devmachine-eclipse-modeling-update.yml`
- **Status**: [x] Completed
- **Justification**: Separates intentional Eclipse Modeling upgrades from idempotent baseline IDE setup (`devmachine-setup-ides.yml`), preventing accidental overwrites while guaranteeing safe backups, WebKit compatibility, and standard FZL CLI launchers.
- **Affected Components/Files**:
  - `playbooks/devmachine-eclipse-modeling-update.yml`
- **What Was Done**:
  - Created `playbooks/devmachine-eclipse-modeling-update.yml` with running-process check (`pgrep`), Java/WebKitGTK dependency installation, download-first validation (`get_url` with `retries: 3`, `delay: 5`), timestamped backup/replace, WebKit/SWT `eclipse.ini` configuration, `/usr/local/bin/fzl-eclipse-modeling*` launchers, desktop entry, temporary archive cleanup, and completion summary.

### Task 3: Create `playbooks/uml-papirus-update.yml`
- **Status**: [x] Completed
- **Justification**: Separates intentional Eclipse Papyrus UML upgrades from `uml-papirus-install.yml` and `modellingmachine-setup-ides-uml.yml`, preserving `papyrus`/`papyrus.ini` symlinks, WebKitGTK deadlock fixes, and both `fzl-papyrus*` and `fzl-papirus*` launchers.
- **Affected Components/Files**:
  - `playbooks/uml-papirus-update.yml`
- **What Was Done**:
  - Created `playbooks/uml-papirus-update.yml` with running-process check (`pgrep`), Java/WebKitGTK dependency installation, download-first validation (`get_url` with `retries: 3`, `delay: 5`), timestamped backup/replace, `papyrus` and `papyrus.ini` symlinks, WebKit/SWT `papyrus-desktop.ini` options, `/usr/local/bin/fzl-papyrus*` + `fzl-papirus*` symlinks, `~/.bashrc_dev_tools` aliases, desktop entry, temporary archive cleanup, and completion summary.

### Task 4: Update `README.md` Documentation & Command Table
- **Status**: [x] Completed
- **Justification**: Required by `skills/devops-infra/ansible-playbook-standards/SKILL.md` so users discover the new update playbooks, parameter overrides (`-e`), and FZL launcher commands in the central repository documentation.
- **Affected Components/Files**:
  - `README.md`
- **What Was Done**:
  - Added Section `### 18. Update Eclipse IDEs (Eclipse Modeling & Eclipse Papyrus UML)` under Key Playbooks with usage and `-e` version override examples.
  - Updated the Custom Start Commands table with `devmachine-eclipse-modeling-update.yml` and added `Eclipse Papyrus UML` (`uml-papirus-update.yml`) launchers.

### Task 5: Syntax Validation & Final Verification
- **Status**: [x] Completed
- **Justification**: Mandated by `AGENTS.md` rule #3 to verify valid YAML, Jinja2 expressions, and Ansible module references before completion.
- **Affected Components/Files**:
  - `playbooks/devmachine-eclipse-modeling-update.yml`
  - `playbooks/uml-papirus-update.yml`
- **What Was Done**:
  - Executed `ansible-playbook --syntax-check playbooks/devmachine-eclipse-modeling-update.yml playbooks/uml-papirus-update.yml` (exited with code 0; both playbooks validated cleanly).

---

## 3. Verification & Validation

### 3.1 Automated Checks
- [x] `ansible-playbook --syntax-check playbooks/devmachine-eclipse-modeling-update.yml playbooks/uml-papirus-update.yml` -> Command exited with code 0.

---

## 4. Summary & Lessons Learned
- Delivered two dedicated Eclipse IDE update playbooks (`playbooks/devmachine-eclipse-modeling-update.yml` and `playbooks/uml-papirus-update.yml`) with running-process protection, download-first validation with retries, timestamped backups, WebKitGTK/SWT freeze-prevention flags, desktop entries, and standardized `fzl-*` CLI launchers.
- Updated `README.md` with Section 18 and Custom Start Commands table entries.
