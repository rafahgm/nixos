{ config, inputs, pkgs, ... }:

{
	imports = [
		./modules/programs/browser
		./modules/programs/git
	];
	
	home.stateVersion = "26.05";

	# --- Ghostty ---
	programs.ghostty = {
		enable = true;
		enableBashIntegration = true;
		settings = {
			font-family = "JetBrainsMono Nerd Font";
			font-size = 12;
			window-padding-x = 8;
			window-padding-y = 8;
		};
	};

	# --- Neovim ---
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		extraPackages = with pkgs; [
			gcc ripgrep fd tree-sitter
			lua-language-server nil nixfmt
			qt6.qtdeclarative
		];
	};

	# --- Zen Browser ---
	my.browser.zen.enable = true;
	my.browser.default = "zen";

	# --- Git ---
	my.git.enable = true;

	# --- 1Password ---
	programs.ssh = {
		enable = true;
		enableDefaultConfig = false;
		matchBlocks."*".identityAgent = "~/.1password/agent.sock";
	};
	home.sessionVariables.SSH_AUTH_SOCK = "${config.home.homeDirectory}/.1password/agent.sock";
	services.polkit-gnome.enable = true;

	# --- Niri ---
	xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;

	home.packages = with pkgs; [
		claude-code
		inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop-fhs
		fuzzel
		waybar
		mako
		spotify
	];
}
