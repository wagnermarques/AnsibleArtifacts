---
name: ansible-playbook-standards
description: >-
  Use this skill when authoring, modifying, or auditing Ansible playbooks, roles,
  or tasks within the AnsibleArtifacts infrastructure repository.
---

# Ansible Playbook Standards & FZL Patterns

This guide defines standard practices and patterns used throughout the `AnsibleArtifacts` repository.

## 1. The FZL Application Launcher Pattern

All software or IDEs installed through playbooks must provide standard launchers:
* **Background Launcher (`fzl-<app>-start`)**:
  * Runs with `nohup <command> "$@" > "$HOME/.cache/<app>/<app>.log" 2>&1 &`
  * Stored in `/usr/local/bin/fzl-<app>-start` (mode `0755`)
  * Aliased in `~/.bashrc`: `alias fzl-<app>-start='nohup <app> > /dev/null 2>&1 &'`
* **Foreground Launcher (`fzl-<app>`)**:
  * Stored in `/usr/local/bin/fzl-<app>` (mode `0755`) or aliased directly.

## 2. Multi-Distribution Support

Tasks installing packages should be portable across:
1. **Fedora / RHEL / CentOS**:
   * Condition: `when: ansible_facts['os_family'] == "RedHat" or ansible_facts['distribution'] == "Fedora"`
   * Package manager: `ansible.builtin.dnf`
2. **Debian / Ubuntu**:
   * Condition: `when: ansible_facts['os_family'] == "Debian"`
   * Package manager: `ansible.builtin.apt`

## 3. Resolving the Target Non-Root User

When running playbooks with `become: true` (via `-K` / `--ask-become-pass`), always determine the calling human user rather than hardcoding `root`:

```yaml
vars:
  target_user: "{{ ansible_facts['env']['SUDO_USER'] | default(lookup('env', 'SUDO_USER')) | default(ansible_facts['env']['USER'] | default(lookup('env', 'USER'))) }}"
  target_home: "{{ '/home/' + target_user if target_user != 'root' else ansible_facts['user_dir'] | default(lookup('env', 'HOME')) }}"
```

## 4. Documentation & Verification

Whenever a new playbook is created:
1. Add an entry to `README.md` under **Key Playbooks** with the exact `ansible-playbook` command.
2. If new `fzl-*` commands are added, update the **Custom Start Commands (FZL Pattern)** table in `README.md`.
3. Test syntax before committing: `ansible-playbook playbooks/<name>.yml --syntax-check`
