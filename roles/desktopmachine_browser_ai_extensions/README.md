# Role: desktopmachine_browser_ai_extensions

Ansible role to automate the system-wide installation of AI extensions (Claude, Gemini, Copilot, HARPA AI, Monica, Sider) across Chromium-based browsers (**Google Chrome, Chromium, Brave, Microsoft Edge**) on Linux.

## How It Works
1. Deploys enterprise policy files (`ExtensionInstallForcelist`) in:
   - `/etc/opt/chrome/policies/managed/ai_extensions.json`
   - `/etc/chromium/policies/managed/ai_extensions.json`
   - `/etc/brave/policies/managed/ai_extensions.json`
   - `/etc/opt/edge/policies/managed/ai_extensions.json`
2. Creates external extension descriptors in `/usr/share/google-chrome/extensions/` and `/usr/share/chromium/extensions/`.
3. When any user opens Chrome/Chromium/Brave/Edge, the browsers automatically download, install, and enable the extensions silently.

## Default Included AI Extensions
- **Sider AI** (Multi-model Sidebar: Claude 3.5 Sonnet, Gemini 1.5/2.0, GPT-4o)
- **Monica AI** (All-in-one AI Assistant & Copilot)
- **HARPA AI** (Hybrid AI Automation Agent & Web Assistant)
- **Microsoft Copilot** (Web & Search AI)

## Example Playbook
```yaml
- hosts: devmachines_workstations
  become: yes
  roles:
    - desktopmachine_browser_ai_extensions
```
