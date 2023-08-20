{
  config,
  pkgs,
  self,
  ...
}: let
  rclone-script = pkgs.writeShellScript "rclone-script" ''
    # have pre-start here itself
    mkdir -p $HOME/gdrive
    mkdir -p $HOME/.config/rclone/logs
    mkdir -p $HOME/.data/rclone

    # Start Service here
    ${pkgs.rclone}/bin/rclone mount gdrive: $HOME/gdrive \
    --cache-dir $HOME/.data/rclone \
    --vfs-cache-mode writes \
    --dir-cache-time 24h \
    --log-level INFO \
    --log-file $HOME/.config/rclone/logs/rclone.log \
    --timeout 1h \
    --umask 002 \
    --rc
  '';
in {
  home.packages = with pkgs; [
    rclone
    fuse
  ];

  systemd.user.services = {
    rclone-mount = {
      Unit = {
        Description = "Rclone Service";
        ConditionPathExists = "%h/.config/rclone/rclone.conf";
      };
      Service = {
        Type = "simple";
        ExecStart = [rclone-script];
        ExecStop = "fusermount -uz %h/gdrive";
        Restart = "on-failure";
        Environment = ["PATH=/run/wrappers/bin" "RCLONE_CONFIG=%h/.config/rclone/rclone.conf"];
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
