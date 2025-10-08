#!/usr/bin/env bash

HOSTS=$(find nixos/hosts -mindepth 1 -maxdepth 1 -type d -printf '%f\n')

for host in $HOSTS; do
  if [ -f "nixos/hosts/$host/configuration.nix" ]; then
    echo "Building and activating configuration for host: $host"
    mkdir -p result
    nix build --option system-features "kvm" --extra-experimental-features nix-command --extra-experimental-features flakes "nixos/#$host" --out-link "result/$host" || exit 1
    mkdir -p result-nonsym/$host
    cp -r result/$host/* result-nonsym/$host/
  fi
done