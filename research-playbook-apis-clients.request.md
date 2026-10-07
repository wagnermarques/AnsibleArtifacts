# Request: `playbooks/research-playbook-apis-clients.yml`

**From:** a Claude Code session (ias-claude), 2026-10-07
**Background notes:** `~/mnt/ext4/ias-claude/scival.org` (SciVal / Elsevier API options)

## Goal
Write an idempotent playbook that sets up a workstation to use research and
bibliometric APIs. The first one is **Elsevier SciVal and Scopus**. Build it so
more research APIs can be added later, such as OpenAlex, Crossref, ORCID and
Semantic Scholar.

Follow `AGENTS.md`: keep secrets in Vault or `.env`, use the `fzl-<app>` naming
pattern, make it idempotent, and run `--syntax-check`.

## Suggested structure (adapt it to the repo's existing conventions)
- `playbooks/research-playbook-apis-clients.yml`, the entry playbook
- `roles/research_apis_clients/`, a new role (tasks, defaults, templates)
- Look at `roles/devmachine_ai_agents_mcp` and
  `playbooks/devmachine-configure-ai-agents-mcp.yml` and reuse their MCP
  registration pattern.

## What it should do
1. **Python environment**
   - Create a dedicated venv, for example `~/.local/share/fzl/research-apis/venv`.
   - Install `requests`, `pybliometrics`, `mcp` (the official MCP Python SDK
     with FastMCP) and, optionally, `elsapy`.
   - Put package versions in role defaults so they're easy to bump.

2. **Credentials (never in plain text in git)**
   - Add placeholders to `vars/vault-template.yml`:
     - `vault_elsevier_api_key`
     - `vault_elsevier_insttoken` (optional; the institutional token for SciVal
       access off-campus)
   - Add `ELSEVIER_API_KEY=` and `ELSEVIER_INSTTOKEN=` to `.env.template`.
   - Write the values into a user-only env file (mode `0600`), for example
     `~/.config/fzl/research-apis.env`. Use `no_log: true` on the tasks that
     handle secrets.

3. **pybliometrics config**
   - Template `~/.config/pybliometrics.cfg` with the API key (and InstToken if
     set). Mode `0600`.

4. **SciVal MCP server**
   - Deploy `scival_mcp.py` from a template into the venv folder. The skeleton
     is in the "Option D" section of `scival.org`. Its tools are
     `search_institution`, `author_metrics` and `institution_metrics`.
   - Base URL: `https://api.elsevier.com/analytics/scival`
   - Headers: `X-ELS-APIKey`, optional `X-ELS-Insttoken`,
     `Accept: application/json`
   - Register it in Claude Code at user scope, idempotently. Check
     `claude mcp list` first and only add it if it's missing:
     `claude mcp add scival --scope user -e ELSEVIER_API_KEY=... -- <venv>/bin/python <path>/scival_mcp.py`
   - Optionally, register it for other agents (gemini/agy) if the existing
     MCP role already does that for other servers.

5. **Helper commands (FZL pattern)**
   - `fzl-scival-test`: runs one test API call, such as an institution search,
     to check the key and entitlement. Exit code 0 means OK.
   - Optionally, `fzl-research-apis-shell`: activates the venv with the env
     file loaded.

6. **Tags**
   - `research_apis`, `elsevier`, `scival`, `mcp`, so parts can run on their
     own.

## Acceptance criteria
- `ansible-playbook --syntax-check playbooks/research-playbook-apis-clients.yml`
  passes.
- A second run reports `changed=0`.
- No secret appears in tracked files or in the Ansible output.
- When the key or entitlement is valid, `fzl-scival-test` succeeds.
- Add a short usage doc, `docs/research-apis-usage.org`, covering how to get
  the key at dev.elsevier.com, ask the library for an institutional token and
  run the playbook.

## Notes and caveats
- Using the SciVal API requires an institutional SciVal subscription. Access is
  proven by working from the institution's network (IP-based) or with an
  institutional token.
- The endpoint paths and metric names in `scival.org` have not been tested.
  Check them against the interactive docs at dev.elsevier.com.
- You can delete this request file once the work is done.
