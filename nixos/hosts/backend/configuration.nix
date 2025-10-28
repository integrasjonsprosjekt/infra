{...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      frontend = {
        image = "ghcr.io/integrasjonsprosjekt/memora-api:latest";
        ports = [
          "80:8080"
        ];
        volumes = [ "/run/secrets/google_application_credentials.json:/google_application_credentials.json" ];
        environment = { GOOGLE_APPLICATION_CREDENTIALS = "/google_application_credentials.json"; };
      };
    };
  };
  services.cloud-init.enable = true;
}
