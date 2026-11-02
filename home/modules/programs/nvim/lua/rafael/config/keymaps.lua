local km = vim.keymap

-- Disable space bar since it will be used as the leader key
km.set({ "n", "v" }, "<leader>", "<nop>", { desc = "Disable leader key default" })

-- Redomap
km.set("n", "U", "<C-r>", { desc = "Redo" })

km.set("i", "<C-h>", "<Left>", { desc = "Move cursor left" })
km.set("i", "<C-l>", "<Right>", { desc = "Move cursor right" })

-- swap between split buffers
km.set("n", "<C-h>", ":wincmd h<CR>", {
  silent = true,
  desc = "Move to left split",
})
km.set("n", "<C-j>", ":wincmd j<CR>", {
  silent = true,
  desc = "Move to below split"
})
km.set("n", "<C-k>", ":wincmd k<CR>", {
  silent = true,
  desc = "Move to above split"
})
km.set("n", "<C-l>", ":wincmd l<CR>", {
  silent = true,
  desc = "Move to right split"
})
km.set("n", "<leader>rr", ":wincmd r<CR>", { silent = true, desc = "Rotate split buffers" })
km.set("n", "<leader>re", ":restart<CR>", { silent = true, desc = "Restart Neovim" })

local multicursor_ns = vim.api.nvim_create_namespace("nvim.multicursor")
km.set("n", "<Esc>", function()
  vim.cmd.nohlsearch()
  vim.api.nvim_buf_clear_namespace(0, multicursor_ns, 0, -1)
end, { desc = "Clear search highlights & multicursors" })

vim.keymap.set("n", "<leader>d", "<C-w>d", { remap = true, desc = "Show diagnostic float" })

vim.keymap.set("n", "<leader>w", ":w<cr>", { silent = true, noremap = true, desc = "Save current file" })
vim.keymap.set({ "n", "t" }, "<leader>q", ":q<cr>", { silent = true, noremap = true, desc = "Quit current buffer" })

vim.keymap.set("n", "<C-c>", ":bwipeout<CR>", { silent = true, desc = "Close current buffer" })
