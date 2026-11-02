return {
	-- No Arch, o binário no PATH é qmlls6
	cmd = { "qmlls6" },
	-- O Quickshell gera o .qmlls.ini com os import paths dos módulos dele
	root_markers = { ".qmlls.ini", "shell.qml", ".git" },
}
