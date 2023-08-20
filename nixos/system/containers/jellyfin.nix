{
  config,
  pkgs,
  ...
}: {
  # Jellyfin
  virtualisation.oci-containers.containers."jellyfin" = {
    autoStart = true;
    image = "jellyfin/jellyfin";
    volumes = [];
    ports = ["8096:8096"];
    environment = {
      JELLYFIN_LOG_DIR = "/log";
    };
  };
}
