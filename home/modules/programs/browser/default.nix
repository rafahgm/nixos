{ lib, ... }:

{
	imports = [ ./zen ];

	options.my.browser.default = lib.mkOption {
		type = lib.types.nullOr (lib.types.enum [ "zen" ]);
		default = null;
		description = "Navegador padrao do usuário.";
	};
}

