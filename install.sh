#!/usr/bin/env bash
#
# Install cloud-ctl tools
# Symlinks bin/* into ~/.local/bin (or custom prefix)
#
# Usage: ./install.sh [--prefix /usr/local]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PREFIX="${HOME}/.local"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --prefix) PREFIX="$2"; shift 2 ;;
        *) echo "Usage: $0 [--prefix /path]"; exit 1 ;;
    esac
done

BIN_DIR="${PREFIX}/bin"
mkdir -p "$BIN_DIR"

for script in "$SCRIPT_DIR"/bin/*; do
    name=$(basename "$script")
    target="$BIN_DIR/$name"

    if [[ -L "$target" ]]; then
        rm "$target"
    elif [[ -e "$target" ]]; then
        echo "Warning: $target exists and is not a symlink, skipping"
        continue
    fi

    ln -s "$script" "$target"
    echo "Installed: $name -> $target"
done

echo ""
echo "Done. Make sure $BIN_DIR is in your PATH."
