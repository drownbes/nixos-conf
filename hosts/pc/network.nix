{lib, ...}: {
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.hostName = "pc";
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
}
