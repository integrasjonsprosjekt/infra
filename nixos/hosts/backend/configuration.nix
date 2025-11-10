{...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      backend = {
        image = "ghcr.io/integrasjonsprosjekt/memora-api:latest";
        ports = [
          "80:8080"
        ];
        volumes = [ "/run/secrets/google_application_credentials.json:/memora/google_application_credentials.json" ];
        environment = { GOOGLE_APPLICATION_CREDENTIALS = "/memora/google_application_credentials.json"; };
      };
    };
  };
  services.cloud-init.enable = true;
}
