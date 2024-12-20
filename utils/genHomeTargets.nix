{ lib, hostsDir, ... }:
lib.flatten (
  lib.forEach (builtins.attrNames (builtins.readDir hostsDir)) (
    hostname:
    let
      users = (import ./evalHost.nix { inherit lib hostsDir hostname; }).users;
    in
    lib.forEach users (username: "${username}@${hostname}")
  )
)
