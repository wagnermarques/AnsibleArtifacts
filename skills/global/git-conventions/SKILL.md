---
name: git-conventions
description: >-
  Use this skill when staging, committing, branching, or reviewing Git changes.
  Enforces Conventional Commits, atomic commits, and safe repository hygiene.
---

# Git Conventions & Repository Hygiene

Standard operating procedures for managing Git repositories, committing changes, and maintaining a clean history across projects.

## 1. Commit Message Standard (Conventional Commits)

Format: `<type>(<scope>): <short description in imperative mood>`

### Types:
* **`feat`**: A new feature, playbook, tool, or command.
* **`fix`**: A bug fix or patch.
* **`refactor`**: Code change that neither fixes a bug nor adds a feature.
* **`docs`**: Documentation only changes (README, usage guides, org files).
* **`chore`**: Maintenance tasks, dependency updates, directory structure changes.
* **`ci`**: Changes to CI/CD workflows, linting, or automation hooks.

### Examples:
* `feat(scrcpy): add install-scrcpy playbook and fzl-scrcpy launchers`
* `fix(touchpad): resolve tap-to-click persistence on fedora xfce`
* `docs(readme): document centralized agent skills architecture`

---

## 2. Rules for Agents:
1. **Never commit sensitive files**: Always check `.gitignore` before committing (`.env`, `vault.yml` unencrypted, SSH keys, credentials).
2. **Atomic Commits**: Keep commits focused on a single change set.
3. **Verify Git Status**: Always run `git status` and `git diff --staged` before finalizing a commit.
