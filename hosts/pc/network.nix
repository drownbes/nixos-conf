{lib, ...}: {
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "pc";
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
}
