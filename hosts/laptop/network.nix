{lib, ...}: {
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "laptop";
  #networking.wireless.enable = false;
  networking.networkmanager.enable = true;
}
