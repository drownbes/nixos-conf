{lib, ...}: {
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "pc";
  networking.wireless.enable = false;
  networking.networkmanager.enable = false;
  services.resolved.enable = true;
  networking.nameservers = ["192.168.0.199"];
}
