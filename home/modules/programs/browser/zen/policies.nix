{
	DisableAppUpdate = false;
	DisableTelemetry = true;

	ExtensionSettings = {
		# Language pack pt-BR. Precisa casar com a versão do Firefox base do Zen
		# (application.ini MaxVersion); atualizar a URL quando o Zen subir de base.
		"langpack-pt-BR@firefox.mozilla.org" = {
			installation_mode = "normal_installed";
			install_url = "https://releases.mozilla.org/pub/firefox/releases/159.0/linux-x86_64/xpi/pt-BR.xpi";
		};

		# Dicionário pt-BR para o corretor ortográfico
		"pt-BR@dellalibera.sf.net" = {
			installation_mode = "normal_installed";
			install_url = "https://addons.mozilla.org/firefox/downloads/latest/verificador-ortográfico-para-p/latest.xpi";
		};
	};
}
