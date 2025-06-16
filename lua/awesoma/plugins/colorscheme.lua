---@diagnostic disable: undefined-global
return {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("nightfox").setup({
			options = {
				transparent = false, -- Disable setting background
				terminal_colors = true,
				styles = { -- Style to be applied to different syntax groups
					comments = "italic",
					keywords = "bold",
					types = "italic,bold",
					-- comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
					-- conditionals = "NONE",
					-- constants = "NONE",
					functions = "NONE",
					-- keywords = "NONE",
					-- numbers = "NONE",
					-- operators = "NONE",
					-- strings = "NONE",
					-- types = "NONE",
					-- variables = "NONE",
				},
			},
		})
		vim.cmd("colorscheme carbonfox")
	end,
}

-- return {
-- 	"navarasu/onedark.nvim",
-- 	priority = 1000, -- make sure to load this before all the other start plugins
-- 	config = function()
-- 		require("onedark").setup({
-- 			style = "deep", --deep
-- 			transparent = true,
-- 			term_colors = true,
--
-- 			lualine = {
-- 				transparent = false, -- lualine center bar transparency
-- 			},
-- 		})
-- 		-- Enable theme
-- 		require("onedark").load()
-- 	end,
-- }

-- lua/plugins/rose-pine.lua
-- return {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine-dawn",
-- 	variant = "dawn",
-- 	config = function()
-- 		vim.cmd("colorscheme rose-pine")
-- 	end,
-- }
--
-- return {
-- 	"scottmckendry/cyberdream.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd("colorscheme cyberdream")
-- 	end,
-- }
