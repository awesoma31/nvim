---@diagnostic disable: undefined-global
-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------
-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- lua/config/keymaps.lua or in a new file like lua/plugins/reload.lua
vim.keymap.set("n", "<leader>Lz", "<cmd>Lazy sync<CR>", { desc = "Lazy: Sync plugins" })
vim.keymap.set("n", "<leader>QR", ":qa<CR>:!nvim<CR>", { desc = "Quit & Restart Neovim" })

vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment line" })

vim.keymap.set("v", "<leader>/", function()
	local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(esc, "x", false)
	require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment block" })

vim.keymap.set({ "n" }, "<C-k>", function()
	require("lsp_signature").toggle_float_win()
end, { silent = true, noremap = true, desc = "toggle signature" })

vim.keymap.set({ "n" }, "<Leader>k", function()
	vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = "toggle signature" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Add a new line below and stay in normal mode
keymap.set("n", "<C-Enter>", "o<Esc>")
-- Add a new line above and stay in normal mode
keymap.set("n", "<C-S-Enter>", "O<Esc>")
keymap.set("i", "<C-Enter>", "<C-o>o") -- Insert a new line below without leaving insert mod
keymap.set("i", "<C-S-Enter>", "<C-o>O") -- Insert a new line above without leaving insert mode

keymap.set("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Diagnostics" })
keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })

keymap.set("n", "]g", vim.diagnostic.goto_next)
keymap.set("n", "[g", vim.diagnostic.goto_prev)

--TODO: check
keymap.set("n", "<leader>p", '"_dP', { desc = "delete, dont save, then paste in to that space" })

-- hui  ui ui huiui ui ui ui ui ui ui
