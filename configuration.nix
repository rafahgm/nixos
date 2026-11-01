{ config, lib, pkgs, ... }:

{
  	imports = [ ./hardware-configuration.nix ];

	# --- Nix ---
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.settings.auto-optimise-store = true;
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 14d";
	};
	nixpkgs.config.allowUnfree = true;

	# --- Boot ---
	boot.loader.grub = {
		enable = true;
		device = "nodev";
		efiSupport = true;
		useOSProber = true;
		configurationLimit = 10;
	};
	boot.loader.efi.canTouchEfiVariables = true;

  	boot.kernelPackages = pkgs.linuxPackages_latest;

	# --- BTRFS ---
	services.btrfs.autoScrub = {
		enable = true;
		interval = "monthly";
		fileSystems = [ "/" ];
	};
	services.fstrim.enable = true;
	zramSwap.enable = true;

	# --- Rede, hora e idioma ---
	networking.hostName = "nixos";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Sao_Paulo";
	boot.supportedFilesystems = [ "ntfs" ];
	i18n.defaultLocale = "pt_BR.UTF-8";
	console.useXkbConfig = true;
	services.xserver.xkb = {
		layout = "us";
		variant = "altgr-intl";
	};

	# --- Usuario ---
	users.users.rafael = {
		isNormalUser = true;
		extraGroups = [ "wheel" "netowkrmanager" "video" ];
	};

	# --- Niri e sessao grafica ---
	programs.niri.enable = true;
	security.polkit.enable = true;
	services.gnome.gnome-keyring.enable = true;
	environment.sessionVariables.NIXOS_OZONE_WL = "1";

	services.greetd = {
		enable = true;
		settings.default_session = {
			command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
			user = "greeter";
		};
	};
	
	# --- Audio ---
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
	};

	# --- Fontes ---
	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		noto-fonts
		noto-fonts-color-emoji
	];

	# --- 1Password ---
	programs._1password.enable = true;
	programs._1password-gui = {
		enable = true;
		polkitPolicyOwners = [ "rafael" ];
	};

	environment.etc."1password/custom_allowed_browsers" = {
		text = ''
		zen
		zen-beta
		.zen-wrapped
		'';
		mode = "0755";
	};

	environment.systemPackages = with pkgs; [ git wget curl ];

  	system.stateVersion = "26.05";
}

