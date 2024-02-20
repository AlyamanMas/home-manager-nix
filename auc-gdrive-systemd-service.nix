{ pkgs, ... }: {
  systemd.user.services.auc-gdrive-rclone-mount = {
    Unit = {
      Description = "Mount auc-gdrive with rclone";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart =
        "${pkgs.rclone}/bin/rclone mount auc-gdrive:/ /home/yaman/mounts/auc-gdrive/";
    };
  };
}
