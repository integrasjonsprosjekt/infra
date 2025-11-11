{...}: {
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      backend = {
        pull = "always";
        image = "ghcr.io/integrasjonsprosjekt/memora-api:latest";
        ports = [
          "80:8080"
        ];
        volumes = [ "/etc/secrets/google_application_credentials.json:/google_application_credentials.json" ];
        environment = { GOOGLE_APPLICATION_CREDENTIALS = "/google_application_credentials.json"; };
      };
      redis = {
        image = "redis:latest";
        ports = [ "6379:6379" ];
      };
    };
  };
  services.cloud-init.enable = true;
}
