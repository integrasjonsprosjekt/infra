FROM nixos/nix

LABEL org.opencontainers.image.source=https://github.com/integrasjonsprosjekt/infra

RUN nix-channel --update

RUN nix-env -iA nixpkgs.opentofu
RUN nix-env -iA nixpkgs.nodejs

WORKDIR /build