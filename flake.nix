{
	description = "NixOS + Home Manager";
	inputs  = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		firefox-addons = {
			url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		claude-desktop = {
			url = "github:aaddrick/claude-desktop-debian";
			inputs.nixpkgs.follows =  "nixpkgs";
		};

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";
			};
		};
	};

	outputs = { nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					nixpkgs.overlays = [ inputs.firefox-addons.overlays.default ];
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						backupFileExtension = "backup";
						extraSpecialArgs = { inherit inputs; };
						users.rafael = import ./home;
					};
				}
			];
		};
	};
}
