{pkgs, inputs, outputs, config, ...}: {
	imports = [
    ../shared/nixpkgs.nix
		../shared/nix.nix
		../shared/fonts.nix
		inputs.home-manager.darwinModules.home-manager
	];



	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		extraSpecialArgs = {
			inherit inputs outputs;
			osConfig = config;
		};
		users = {
			artemmarkov = import ./home-manager;
		};
	};

	environment.systemPackages = with pkgs;[ 
      ];


      users.users.artemmarkov = {
        name = "artemmarkov";
        home = "/Users/artemmarkov";
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = outputs.self.rev or outputs.self.dirtyRev or null;
      system.defaults = {
      	dock = {
	  autohide = true;
	  mru-spaces = false;
	};
      };


      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
}
