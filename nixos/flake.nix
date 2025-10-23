{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    nixos-generators,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        hosts = builtins.readDir ./hosts;
      in {
        packages = builtins.listToAttrs (
          builtins.map
          (host: {
            name = host;
            value = nixos-generators.nixosGenerate {
              system = system;
              modules = [
                {
                  services.openssh.enable = true;
                  services.qemuGuest.enable = true;
                  virtualisation.docker.enable = true;
                  security.sudo.wheelNeedsPassword = false;
                  users.users.nixos = {
                    isNormalUser = true;
                    extraGroups = ["wheel" "docker"];
                    openssh.authorizedKeys.keys = [
                      (builtins.readFile ./id_ed25519.pub)
                    ];
                  };
                  nix.settings.trusted-users = [
                    "nixos"
                  ];
                  system.stateVersion = "25.11";
                }
                (./hosts + "/${host}/configuration.nix")
              ];
              format = "openstack";
            };
          })
          (builtins.attrNames hosts)
        );
      }
    );
}
