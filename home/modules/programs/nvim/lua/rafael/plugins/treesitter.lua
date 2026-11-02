-- Os parsers vêm do Nix (nvim-treesitter.withPlugins em default.nix);
-- aqui só ativamos highlight e indent.
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    if not pcall(vim.treesitter.start, args.buf) then
      return
    end
    -- Só usa indentação do Tree-sitter se a linguagem tiver indents.scm;
    -- caso contrário mantém o indent/<ft>.vim nativo (ex.: qmljs não tem)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if lang and vim.treesitter.query.get(lang, "indents") then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
