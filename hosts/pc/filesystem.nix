{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.common-pc-ssd
  ];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ae9ba41a-3540-4fac-800b-2568f84703f5";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/28DB-C617";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/9a75051d-3b39-475a-9d20-6b9cb427cbe2";}
  ];
}
