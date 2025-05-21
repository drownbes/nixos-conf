# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    beef_market = inputs.beef_market.packages.${final.system}.beef_market;
    nodePackages.nodejs = prev.nodePackages.nodejs.overrideAttrs (oldAttrs: {
        doCheck = false;
    });
    nodejs_20 = prev.nodejs_20.overrideAttrs (oldAttrs: {
        doCheck = false;
    });

    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
}
