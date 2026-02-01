# cloud-ctl

Standalone CLI tools for managing cloud infrastructure.

## Tools

| Tool | Provider | What it manages |
|------|----------|-----------------|
| `hetzner-ctl` | Hetzner Cloud | Servers, firewalls, SSH keys, costs |
| `oracle-ctl` | Oracle Cloud | Instances, VCNs, security lists, free-tier limits |
| `porkbun-ctl` | Porkbun | Domain registration, DNS records, nameservers |
| `server-ctl` | (any Linux) | Docker, UFW, SSH hardening, auto-updates |

## Install

```bash
git clone <repo-url> ~/cloud-ctl
cd ~/cloud-ctl
./install.sh
```

This symlinks the tools into `~/.local/bin`. Use `--prefix /usr/local` for system-wide install.

## Quick Reference

```bash
# Hetzner
hetzner-ctl list-servers
hetzner-ctl create-server
hetzner-ctl create-firewall my-fw 22,80,443,10000/udp
hetzner-ctl apply-firewall <fw-id> <server-id>
hetzner-ctl ssh my-server
hetzner-ctl get-costs

# Oracle
oracle-ctl list-instances
oracle-ctl create-network my-net --ports 22,80,443
oracle-ctl create-instance
oracle-ctl get-limits
oracle-ctl ssh my-instance

# DNS
porkbun-ctl search mysite
porkbun-ctl register mysite.xyz
porkbun-ctl set-a mysite.xyz @ 1.2.3.4

# Server setup (run on target server)
server-ctl setup --ports 22,80,443,10000/udp
```

Run any tool with `--help` for full command list.

## Credentials

Each tool reads credentials from environment variables or dotfiles:

| Tool | Env Var | Dotfile |
|------|---------|---------|
| `hetzner-ctl` | `HETZNER_API_TOKEN` | `~/.hetzner/api_token` |
| `oracle-ctl` | (oci-cli config) | `~/.oci/config` |
| `porkbun-ctl` | `PORKBUN_API_KEY`, `PORKBUN_SECRET_KEY` | `~/.porkbun/api_key`, `~/.porkbun/secret_key` |

## Use as Submodule

```bash
cd your-project
git submodule add <repo-url> vendor/cloud-ctl
# Then either add vendor/cloud-ctl/bin to PATH, or symlink individual tools
```

## Adding a New Provider

Copy `templates/provider-template.sh` to `bin/<provider>-ctl` and implement the commands. Source `lib/common.sh` for shared helpers.
