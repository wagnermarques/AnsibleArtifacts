# Role: `devmachine_vcs_clis`

This role installs and configures command-line interface tools for major Git forge platforms:
- **GitHub CLI (`gh`)**: Official command-line tool for GitHub.
- **GitLab CLI (`glab`)**: Official command-line tool for GitLab.
- **Bitbucket CLI (`bkt`)**: Standalone Bitbucket CLI by Aviv Sinai (`avivsinai/bitbucket-cli`), designed to mirror `gh` workflows for Bitbucket Cloud and Data Center.

## Features
- **Cross-Platform Support**: Fedora/RHEL (`dnf`), Debian/Ubuntu (`apt`), and Alpine (`apk`).
- **Bitbucket Ergonomics**: Installs `bkt` with symlinks for `bitbucket` and `bb`.
- **FZL Launch Pattern**: Provides `fzl-gh`, `fzl-glab`, and `fzl-bitbucket` commands.
- **Shell Completions**: Installs bash completions into `/usr/share/bash-completion/completions/`.

## Variables

| Variable | Default | Description |
|---|---|---|
| `install_github_cli` | `true` | Install GitHub CLI (`gh`) |
| `install_gitlab_cli` | `true` | Install GitLab CLI (`glab`) |
| `install_bitbucket_cli` | `true` | Install Bitbucket CLI (`bkt`) |
| `bitbucket_cli_version` | `"0.16.4"` | Version tag of `avivsinai/bitbucket-cli` |
| `bitbucket_cli_base_dir` | `"/opt/bitbucket-cli"` | Directory where release archives are extracted |
| `bitbucket_cli_install_dir` | `"/usr/local/bin"` | Directory where binaries and symlinks are placed |

## Usage

Include the role in a playbook:

```yaml
- hosts: devmachines_workstations
  roles:
    - devmachine_vcs_clis
```

## Authentication via `.env` (Zero-Leak Security)

You can define your corporate GitLab credentials in `.env` (which is excluded from Git via `.gitignore`):

```env
GITLAB_HOST="git.unesp.br"
GITLAB_TOKEN="glpat-your_personal_access_token_here"
GITLAB_GIT_PROTOCOL="ssh" # or https
```

When the playbook runs, it automatically detects `.env`, logs in non-interactively (`glab auth login --stdin`), and sets the default target host.

Additionally, the installed **`fzl-glab`** launcher automatically sources `GITLAB_HOST` and `GITLAB_TOKEN` from any local or `$HOME/.env` file before executing `glab`.

