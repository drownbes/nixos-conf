{pkgs, ...}: {
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd" "hid-playstation" "hid-sony"];
  boot.extraModulePackages = [];
  boot.kernelPackages = pkgs.pkgs.linuxPackages_xanmod_latest;
  hardware.enableAllFirmware = true;

  console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u14n.psf.gz";

  services.fwupd.enable = true;

  # don't wakeup on pci
  services.udev.extraRules = ''
    ACTION=="add" SUBSYSTEM=="pci" DRIVER=="pcieport"     ATTR{power/wakeup}="disabled"
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1987" ATTR{device}=="0x5013" ATTR{power/wakeup}="disabled"
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x149c" ATTR{power/wakeup}="disabled"
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
