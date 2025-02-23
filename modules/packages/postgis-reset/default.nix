# A package for managing PostGIS database resets using ZFS snapshots
{
  pkgs,
  lib ? pkgs.lib,
}:

let
  # Create the rollback script
  postgis-rollback = pkgs.writeScriptBin "postgis-rollback" ''
    #!${pkgs.bash}/bin/bash

    # Exit on any error
    set -e

    echo "Stopping podman-postgis service..."
    ${pkgs.systemd}/bin/systemctl stop podman-postgis.service

    # Wait for the service to fully stop
    echo "Waiting for service to stop completely..."
    while ${pkgs.systemd}/bin/systemctl is-active --quiet podman-postgis.service; do
        echo -n "."
        sleep 1
    done
    echo "Service stopped"

    # Perform the ZFS rollback
    echo "Rolling back ZFS dataset..."
    ${pkgs.zfs}/bin/zfs rollback -r storage-fast/quantierra@dev

    # Start the service back up
    echo "Starting podman-postgis service..."
    ${pkgs.systemd}/bin/systemctl start podman-postgis.service

    echo "Rollback complete!"
  '';

  # Create a derivation that combines our script and webhook config
  postgis-reset = pkgs.symlinkJoin {
    name = "postgis-reset";
    paths = [
      (pkgs.writeTextFile {
        name = "webhook-config";
        text = builtins.readFile ./hooks.json;
        destination = "/etc/webhook/hooks.json";
      })
      postgis-rollback
    ];
  };
in
postgis-reset
