# Feature: Centralized Global Feature Lifecycle Skill & Documentation Standard

- **Status**: Completed
- **Date**: 2026-10-29
- **Author/Agent**: Antigravity Assistant & wgn
- **Target Components**: Centralized Agent Skills, `playbooks/setup-agent-skills.yml`, Global Configurations (`~/.gemini/config/GEMINI.md`, `~/.claude/CLAUDE.md`)
- **Document Path**: `docs/features/global-feature-lifecycle-skill.md`

---

## 1. Goal & Overview

### 1.1 Objective
Establish an automated, cross-project AI agent skill (`feature-lifecycle`) and enforce global agent behavioral rules across Antigravity and Claude Code. Whenever a user requests a new feature or enhancement in any project, the agent must:
1. Create a dedicated feature tracking document (`docs/features/<feature-name>.md`) with Goal and Scope.
2. Break down the implementation into atomic tasks, where **every task includes an explicit justification**.
3. Continuously record an execution audit trail ("What Was Done") detailing code changes, commands executed, and verification results as tasks complete.

### 1.2 Motivation & Business/Technical Value
Without a structured feature construction protocol, agents tend to implement code precipitously without aligning on architectural scope, skipping prerequisites or failing to document why decisions were made. Establishing a document-first, task-justified workflow ensures transparent traceability, idempotent reproducibility, and clear historical documentation for developers and collaborators.

### 1.3 Scope & Acceptance Criteria
- [x] Standardized skill definition in `skills/global/feature-lifecycle/SKILL.md`.
- [x] Reusable markdown template in `resources/feature-template.md`.
- [x] Concrete real-world reference document in `examples/sample-feature-doc.md`.
- [x] Playbook automation in `playbooks/setup-agent-skills.yml` symlinking to `~/.gemini/config/skills/` and configuring `~/.gemini/config/GEMINI.md` and `~/.claude/CLAUDE.md`.
- [x] Playbook syntax validation and successful local run.

---

## 2. Task Breakdown & Justifications

### Task 1: Create Skill Definition (`skills/global/feature-lifecycle/SKILL.md`)
- **Status**: [x] Completed
- **Justification**: Agents require clear operational definitions, progressive disclosure metadata (name and description), and workflow diagrams to recognize when and how to activate the skill upon a user's feature request.
- **Affected Components/Files**:
  - `skills/global/feature-lifecycle/SKILL.md`
- **What Was Done**:
  - Created `skills/global/feature-lifecycle/SKILL.md` with YAML frontmatter `name: feature-lifecycle`.
  - Added Mermaid flowchart detailing the Inception -> Incremental Execution -> Verification lifecycle.
  - Specified mandatory sections for feature documents.

### Task 2: Create Reusable Feature Template (`resources/feature-template.md`)
- **Status**: [x] Completed
- **Justification**: A pre-formatted template eliminates friction and inconsistency, ensuring agents reliably include the Goal, Task Justifications, What Was Done sections, and Verification criteria without omitting mandatory fields.
- **Affected Components/Files**:
  - `skills/global/feature-lifecycle/resources/feature-template.md`
- **What Was Done**:
  - Authored `resources/feature-template.md` with template placeholders for feature metadata, goals, justified tasks, test scenarios, and deliverables.

### Task 3: Create Reference Example (`examples/sample-feature-doc.md`)
- **Status**: [x] Completed
- **Justification**: LLMs perform significantly better when given concrete few-shot examples illustrating the expected depth, tone, and level of detail for task justifications and execution logs.
- **Affected Components/Files**:
  - `skills/global/feature-lifecycle/examples/sample-feature-doc.md`
- **What Was Done**:
  - Created `examples/sample-feature-doc.md` based on an actual feature (Scrcpy Android Mirroring launcher) showcasing real justifications and command execution logs.

### Task 4: Automate Global Provisioning in Playbook (`playbooks/setup-agent-skills.yml`)
- **Status**: [x] Completed
- **Justification**: Manually creating symlinks across environments is error-prone. Enhancing `setup-agent-skills.yml` ensures idempotent deployment to `~/.gemini/config/skills/`, `~/.gemini/config/GEMINI.md`, `~/.claude/CLAUDE.md`, and `~/.claude/agent-skills-reference.md`.
- **Affected Components/Files**:
  - `playbooks/setup-agent-skills.yml`
- **What Was Done**:
  - Added tasks to create `~/.gemini/config/GEMINI.md` with global guidelines to activate `feature-lifecycle`.
  - Added task to create `~/.claude/CLAUDE.md` referencing skills and feature document rules.
  - Verified symlink auto-discovery for all `skills/**/SKILL.md` files.

### Task 5: Upstream Emacs Mirror Resilience
- **Status**: [x] Completed
- **Justification**: GNU Savannah HTTP servers frequently fail with 500 errors during unattended clones. Pointing the default repo URL to the official GitHub mirror improves repository setup reliability.
- **Affected Components/Files**:
  - `roles/devmachine_emacs/defaults/main.yml`
- **What Was Done**:
  - Updated `emacs_repo_url` in `roles/devmachine_emacs/defaults/main.yml` to point to `https://github.com/emacs-mirror/emacs.git`.

### Task 6: Playbook Syntax Verification & Host Execution
- **Status**: [x] Completed
- **Justification**: Enforces repository rule #3 (Always run syntax-check before applying changes) and ensures that symlinks and rule files are successfully created on the machine.
- **Affected Components/Files**:
  - `~/.gemini/config/skills/feature-lifecycle`
  - `~/.gemini/config/GEMINI.md`
  - `~/.claude/CLAUDE.md`
- **What Was Done**:
  - Ran `ansible-playbook --syntax-check playbooks/setup-agent-skills.yml` (exit code 0).
  - Executed `ansible-playbook -i "localhost," -c local playbooks/setup-agent-skills.yml`.
  - Verified active symlinks in `~/.gemini/config/skills/` and inspected generated configuration files.

---

## 3. Verification & Validation

### 3.1 Automated Syntax Check
- Command: `ansible-playbook --syntax-check playbooks/setup-agent-skills.yml`
- Result: Clean validation with zero errors.

### 3.2 Symlink & File Verification
- Command: `ls -la ~/.gemini/config/skills/`
- Result: `feature-lifecycle -> /home/wgn/WORKING/Projects-Srcs/Projects-Srcs-FzlSoft/AnsibleArtifacts/skills/global/feature-lifecycle` successfully linked.
- Command: `cat ~/.gemini/config/GEMINI.md`
- Result: Global rules active and discovered by Antigravity CLI session.

---

## 4. Execution Summary & Deliverables

### 4.1 Summary of Changes
- New global skill `feature-lifecycle` created and versioned under `skills/global/feature-lifecycle/`.
- Playbook `setup-agent-skills.yml` updated to automatically configure global rules in `~/.gemini/config/GEMINI.md` and `~/.claude/CLAUDE.md`.
- Live feature construction document created at `docs/features/global-feature-lifecycle-skill.md`.
