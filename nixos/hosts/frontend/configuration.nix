{...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      frontend = {
        image = "ghcr.io/integrasjonsprosjekt/memora-web:latest";
        ports = [
          "80:3000"
        ];
      };
    };
  };
}
