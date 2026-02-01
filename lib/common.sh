#!/usr/bin/env bash
#
# cloud-ctl shared library
# Source this from any *-ctl script: source "$(dirname "$0")/../lib/common.sh"

# Resolve lib directory (works through symlinks)
CLOUDCTL_LIB_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
CLOUDCTL_ROOT="$(cd "$CLOUDCTL_LIB_DIR/.." && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Global flags (scripts should parse -y/--yes and set this)
FORCE_YES="${FORCE_YES:-false}"

# Confirmation helper - returns 0 if confirmed, 1 if cancelled
# Usage: confirm_action "Proceed?" or confirm_action "Type DELETE to confirm:" "DELETE"
confirm_action() {
    local prompt=${1:-"Proceed?"}
    local confirm_word=${2:-"y"}

    if [[ "$FORCE_YES" == "true" ]]; then
        return 0
    fi

    if [[ "$confirm_word" == "y" ]]; then
        read -p "$prompt [y/N]: " confirm
        [[ "$confirm" == "y" || "$confirm" == "Y" ]]
    else
        read -p "$prompt " confirm
        [[ "$confirm" == "$confirm_word" ]]
    fi
}

# Load a credential from environment variable or file
# Usage: load_credential "HETZNER_API_TOKEN" "$HOME/.hetzner/api_token"
# Sets the variable and exports it. Returns 1 if not found.
load_credential() {
    local var_name=$1
    local file_path=$2

    if [[ -z "${!var_name:-}" ]]; then
        if [[ -f "$file_path" ]]; then
            eval "$var_name=\$(cat '$file_path' | tr -d '[:space:]')"
            export "$var_name"
        else
            return 1
        fi
    fi
    return 0
}

# Print usage from script header comments (lines starting with #)
# Call from the script as: usage "$0"
usage() {
    local script=${1:-$0}
    sed -n '2,/^$/p' "$script" | grep '^#' | sed 's/^# \?//'
    exit 1
}

# Parse global flags from args. Call as: parse_global_flags "$@"; set -- "${REMAINING_ARGS[@]}"
REMAINING_ARGS=()
parse_global_flags() {
    REMAINING_ARGS=()
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -y|--yes)
                FORCE_YES=true
                shift
                ;;
            *)
                REMAINING_ARGS+=("$1")
                shift
                ;;
        esac
    done
}
