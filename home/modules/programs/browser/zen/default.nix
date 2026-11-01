{ config, lib, pkgs, inputs, ... }:

let
	cfg = config.my.browser.zen;
	ids = import ./ids.nix;
	system = pkgs.stdenv.hostPlatform.system;
in
{
	imports = [ inputs.zen-browser.homeModules.beta ];

	options.my.browser.zen.enable = lib.mkEnableOption "Zen Browser com perfil declarativo";

	config = lib.mkIf cfg.enable {
		programs.zen-browser = {
			enable = true;
			setAsDefaultBrowser = config.my.browser.default == "zen";
			policies = import ./policies.nix;
			nativeMessagingHosts = [ pkgs._1password-gui ];

			profiles.default = {
				settings = import ./settings.nix;

				extensions.packages = with pkgs.firefox-addons; [
					ublock-origin
					onepassword-password-manager
				];

				containersForce = true;
				containers = import ./containers.nix { inherit ids; };

				spacesForce = true;
				spaces = import ./spaces.nix { inherit ids; };

				pinsForce = true;
				pinsForceAction = "demote";

				pins = import ./essentials.nix { inherit ids; };
			};
		};
	};
}

