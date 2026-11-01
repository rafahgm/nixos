{ ids }:

{
	"Pessoal" = {
		id = ids.spaces.pessoal;
		position = 1000;
		container = ids.containers.pessoal;
	};

	"Trabalho" = {
		id = ids.spaces.trabalho;
		position = 2000;
		container = ids.containers.trabalho;

		pins = {
			"Financeiro" = {
				id = "3b4dec7d-33c6-49af-8605-27a09bedacbd";
				isGroup = true;
				isFolderCollapsed = false;
				editedTitle = true;
				position = 200;
				pins = {
					"iPag" = {
						id = "04585dbd-8a9d-4097-b3c2-f7146f4bc184";
						url = "https://app.ipag.com.br";
						position = 201;
					};

					"eNotas" = {
						id = "fd5c5400-4dd8-4c5d-842a-c1bbd2955bc2";
						url = "https://app.enotas.com.br";
						position = 202;
					};
				};
			};
		};
	};
}

