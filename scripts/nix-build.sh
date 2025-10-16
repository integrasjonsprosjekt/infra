#!/usr/bin/env bash
set -e
# Load nix environment
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
elif [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
  . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
fi


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