{ config, lib, pkgs, ... }:

let
	cfg = config.my.nvim;

	# A config Lua (init.lua + lua/rafael + after/) empacotada como plugin
	rafael-nvim = pkgs.vimUtils.buildVimPlugin {
		name = "rafael-nvim";
		src = ./.;
		doCheck = false;
	};

	# Fora do nixpkgs: fixado pelo commit; para atualizar, troque rev e hash
	zdiff-nvim = pkgs.vimUtils.buildVimPlugin {
		pname = "zdiff.nvim";
		version = "2fed32c";
		src = pkgs.fetchFromGitHub {
			owner = "martindur";
			repo = "zdiff.nvim";
			rev = "2fed32c25c99be11b743f5c984f482e974d8ecf8";
			hash = "sha256-J6gJ7zSgUzWhKE5K6aqbVJgBymaUr0SgKowyfAZ+q88=";
		};
		doCheck = false;
	};
in
{
	options.my.nvim.enable = lib.mkEnableOption "Neovim com configuração própria";

	config = lib.mkIf cfg.enable {
		programs.neovim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
			withRuby = false;
			withPython3 = false;
			withNodeJs = false;
			withPerl = false;

			extraPackages = with pkgs; [
				gcc ripgrep fd tree-sitter
				lua-language-server nil nixfmt
				qt6.qtdeclarative
			];

			plugins = with pkgs.vimPlugins; [
				rafael-nvim
				catppuccin-nvim
				nvim-lspconfig
				conform-nvim
				mini-nvim
				oil-nvim
				oil-git-status-nvim
				tiny-cmdline-nvim
				lazygit-nvim
				gitsigns-nvim
				zdiff-nvim
				blink-cmp
				lualine-nvim
				fidget-nvim
				quicker-nvim
				tiny-inline-diagnostic-nvim
				plenary-nvim
				telescope-nvim
				telescope-fzf-native-nvim
				telescope-ui-select-nvim
				telescope-frecency-nvim
				(nvim-treesitter.withPlugins (p: [
					p.lua p.luadoc p.luap p.qmljs p.nix
				]))
			];

			initLua = builtins.readFile ./init.lua;
		};
	};
}
