FROM nixos/nix

RUN nix-channel --update

RUN nix-env -iA nixpkgs.opentofu

WORKDIR /build