#!/usr/bin/env bash
#
# Provider Template
# Copy this file to bin/<provider>-ctl and implement all functions for a new provider
#
# Source shared helpers:
source "$(cd "$(dirname "$(readlink -f "$0")")" && pwd)/../lib/common.sh"
#
# Required functions:
#   provider_check_credentials  - Verify API credentials are set
#   provider_show_credential_help - Show how to get/set credentials
#   provider_default_region     - Return default region
#   provider_default_size       - Return default instance size
#   provider_upload_ssh_key     - Upload SSH key, return key ID
#   provider_create_server      - Create server, return server ID
#   provider_wait_ready         - Wait for server to be ready
#   provider_get_ip             - Get server's public IP
#   provider_configure_firewall - Configure firewall rules

# Check if required credentials are set
# Return 0 if valid, 1 if missing
provider_check_credentials() {
    # Example:
    # [[ -n "${PROVIDER_API_TOKEN:-}" ]]
    return 1
}

# Show help for setting up credentials
provider_show_credential_help() {
    echo "To use this provider, set the following environment variable:"
    echo "  export PROVIDER_API_TOKEN=your-token-here"
    echo ""
    echo "Get your API token from: https://provider.com/settings/api"
}

# Return the default region for this provider
provider_default_region() {
    echo "us-east-1"
}

# Return the default instance size (should be ~2 vCPU, 4GB RAM, 80GB disk)
provider_default_size() {
    echo "standard-2"
}

# Upload an SSH public key
# Args: $1 = key name, $2 = key content
# Output: key ID
provider_upload_ssh_key() {
    local key_name=$1
    local key_content=$2

    # Check if key already exists, return existing ID
    # Otherwise create new key and return ID
    echo "key-id"
}

# Create a new server
# Args: $1 = server name, $2 = region, $3 = size, $4 = ssh key ID
# Output: server ID
provider_create_server() {
    local name=$1
    local region=$2
    local size=$3
    local ssh_key_id=$4

    # Create server via API
    # Return server ID
    echo "server-id"
}

# Wait for server to be ready (running state, has IP)
# Args: $1 = server ID
provider_wait_ready() {
    local server_id=$1
    local max_attempts=60
    local attempt=1

    while [[ $attempt -le $max_attempts ]]; do
        # Check server status via API
        # Return 0 when ready
        sleep 5
        ((attempt++))
    done

    return 1
}

# Get the public IP of a server
# Args: $1 = server ID
# Output: IP address
provider_get_ip() {
    local server_id=$1

    # Query API for server IP
    echo "0.0.0.0"
}

# Configure firewall rules for the server
# Opens: 22 (SSH), 80 (HTTP), 443 (HTTPS), 3478 (STUN), 10000/udp (JVB)
# Args: $1 = server ID, $2 = server name (for firewall naming)
provider_configure_firewall() {
    local server_id=$1
    local server_name=$2

    # Create firewall rules via API
    # Attach to server
    :
}
