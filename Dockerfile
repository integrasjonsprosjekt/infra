FROM nixos/nix

LABEL org.opencontainers.image.source=https://github.com/OWNER/REPO

RUN nix-channel --update

RUN nix-env -iA nixpkgs.opentofu

WORKDIR /build