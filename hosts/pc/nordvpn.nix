{
  imports = [
    ../../modules/nixos/nordvpn.nix
  ];
  services.nordvpn.enable = true;
}
