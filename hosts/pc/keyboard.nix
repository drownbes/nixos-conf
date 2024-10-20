{pkgs, ...}: {
  hardware.keyboard.zsa.enable = true;
  environment.systemPackages = with pkgs.unstable; [wally-cli keymapp];
}
