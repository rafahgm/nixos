{ config, lib, ... }:

let
	cfg = config.my.git;
in
{
	options.my.git.enable = lib.mkEnableOption "Git com configuração declarativa";

	config = lib.mkIf cfg.enable {
		programs.git = {
			enable = true;

			settings = {
				user = {
					name = "Rafael Morais";
					email = "rafahgmorais@gmail.com";
					# Impede commit com identidade "adivinhada" caso nenhuma seja configurada
					# (só ative se TODO repositório tiver identidade via includeIf ou local)
					# useConfigOnly = true;
				};

				init.defaultBranch = "main";

				core = {
					autocrlf = "input";
					editor = "nvim";
				};

				push = {
					default = "simple";
					autoSetupRemote = true; # git push já cria o upstream sozinho
					followTags = true;
				};

				pull.ff = "only"; # ou rebase = true, se preferir histórico linear

				fetch = {
					prune = true; # remove referências de branches apagados no remoto
					pruneTags = true;
				};

				rebase = {
					autoStash = true;
					autoSquash = true;
				};

				merge.conflictStyle = "zdiff3"; # mostra também o ancestral comum nos conflitos

				diff = {
					algorithm = "histogram"; # diffs mais legíveis
					colorMoved = "default";
				};

				rerere.enabled = true; # lembra como você resolveu conflitos repetidos

				commit.verbose = true; # mostra o diff no editor ao commitar

				branch.sort = "-committerdate"; # branches mais recentes primeiro

				tag.sort = "version:refname";

				help.autocorrect = "prompt";

				alias = {
					st = "status -sb";
					lg = "log --oneline --graph --decorate -20";
					last = "log -1 --stat";
					undo = "reset --soft HEAD~1";
					amend = "commit --amend --no-edit";
				};
			};

			# Identidade da Nitro para repositórios em ~/Projetos/nitro/
			includes = [
				{
					condition = "gitdir:~/Projetos/nitro/";
					path = "~/Projetos/nitro/.gitconfig";
				}
			];
		};

		home.file."Projetos/nitro/.gitconfig".text = ''
			[user]
				name = Rafael Morais
				email = rafael@nitrodigital.com.br
		'';
	};
}
