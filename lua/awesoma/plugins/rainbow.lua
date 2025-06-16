return {
	"hiphish/rainbow-delimiters.nvim",
	event = "VeryLazy",
	config = function()
		vim.g.rainbow_delimiters = {
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			},
		}
	end,
}
