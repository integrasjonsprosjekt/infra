#!/usr/bin/env bash

HOSTS=$(find nixos/hosts -type d -print)

for host in $HOSTS; do
  if [ -f "$host/configuration.nix" ]; then
    echo "Building and activating configuration for host: $host"
    mkdir -p result
    nix build "nixos/#$host" --out-link "result/$host"
  fi
done