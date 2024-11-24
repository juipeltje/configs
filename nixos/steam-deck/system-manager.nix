# Steam Deck nix system-manager config

{ config, pkgs, ... }:

{
  nixpkgs.hostPlatform = "x86_64-linux";
  system-manager.allowAnyDistro = true;
  
  # Enable nix-system-graphics
  system-graphics.enable = true;

  # Add anime-game-launchers telemetry blocking to /etc/hosts
  environment.etc."hosts".text = ''
    127.0.0.1 localhost
    ::1 localhost
    0.0.0.0 overseauspider.yuanshen.com log-upload-os.hoyoverse.com log-upload-os.mihoyo.com \
      dump.gamesafe.qq.com apm-log-upload-os.hoyoverse.com zzz-log-upload-os.hoyoverse.com \
      log-upload.mihoyo.com devlog-upload.mihoyo.com uspider.yuanshen.com sg-public-data-api.hoyoverse.com \
      hkrpg-log-upload-os.hoyoverse.com public-data-api.mihoyo.com prd-lender.cdp.internal.unity3d.com \
      thind-prd-knob.data.ie.unity3d.com thind-gke-usc.prd.data.corp.unity3d.com cdp.cloud.unity3d.com \
      remote-config-proxy-prd.uca.cloud.unity3d.com pc.crashsight.wetest.net
  '';
}
