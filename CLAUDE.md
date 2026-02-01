# CLAUDE.md

## Project Overview

Standalone CLI tools for managing cloud infrastructure across providers.

## Tools

| Tool | Purpose |
|------|---------|
| `hetzner-ctl` | Manage Hetzner Cloud servers, firewalls, SSH keys |
| `oracle-ctl` | Manage Oracle Cloud instances, networks, security |
| `porkbun-ctl` | Manage domains and DNS via Porkbun |
| `server-ctl` | Generic server hardening (Docker, UFW, SSH, auto-updates) |

## Structure

- `bin/` — CLI scripts (symlinked to PATH by install.sh)
- `lib/common.sh` — Shared helpers (colors, confirmation, credential loading)
- `templates/` — Template for adding new providers

## Adding a New Provider

Copy `templates/provider-template.sh` to `bin/<provider>-ctl` and implement the commands.

## Conventions

- Each script is self-contained bash, sources `lib/common.sh`
- Credential loading: env var first, then dotfile (e.g., `~/.hetzner/api_token`)
- All destructive commands require confirmation (bypass with `-y`)
- No app-specific logic — firewall ports are always user-specified
