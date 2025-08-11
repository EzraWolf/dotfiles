#!/usr/bin/env bash
#
# This script rebuilds the NixOS configuration.
# It should be run from the root of your nixos-config directory.

# Exit immediately if a command exits with a non-zero status.
set -e

# Get the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# The hostname of the machine you want to build.
# This should match one of the directories in /hosts/
# TODO: Change this to 'laptop' when building for your laptop.
HOST="desktop"

echo "Building system for host: $HOST"

# Rebuild the system
sudo nixos-rebuild switch --flake "$DIR/../hosts/$HOST"

echo "System rebuild complete."
