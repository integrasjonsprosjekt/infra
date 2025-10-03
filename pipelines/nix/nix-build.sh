#!/usr/bin/env bash

HOSTS=$(find nixos/hosts -type d -print | sed 's|^nixos/hosts/||' | tail -n +2)

for host in $HOSTS; do
  if [ -f "$host/configuration.nix" ]; then
    echo "Building and activating configuration for host: $host"
    mkdir -p result
    nix build --extra-experimental-features nix-command --extra-experimental-features flakes "nixos/#$host" --out-link "result/$host"
  fi
done