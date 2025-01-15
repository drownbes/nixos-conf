{lib, ...}: {
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "pc";
  networking.wireless.enable = false;
  networking.networkmanager.enable = false;
  services.resolved.enable = true;
  networking.nameservers = ["8.8.8.8"];
  networking.search = ["example.ts.net"];
}
