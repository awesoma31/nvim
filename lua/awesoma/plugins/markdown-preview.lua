return {
	{
		"suan/vim-instant-markdown",
		ft = { "markdown" },
		config = function()
			vim.g.instant_markdown_autostart = 0 -- Set to 1 for auto-start
		end,
	},
}
