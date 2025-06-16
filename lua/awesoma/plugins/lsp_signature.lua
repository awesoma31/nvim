return {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	opts = {
		bind = true,
		handler_opts = {
			border = "rounded", -- double, rounded, single, shadow, none, or a table of borders
		},
		floating_window = true,
		floating_window_above_cur_line = true,
		close_timeout = 4000, -- close floating window after ms when laster parameter is entered
		fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
		-- hint_prefix = "🐼 ",  -- Panda for parameter, for the terminal not support emoji, might crash
		-- or, provide a table with 3 icons
		hint_prefix = {
			above = "↙ ", -- when the hint is on the line above the current line
			current = "← ", -- when the hint is on the same line
			below = "↖ ",
		},
		always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
		extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
		transparency = nil, -- disabled by default, allow floating win transparent value 1~100
		timer_interval = 100,
		toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
		toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
		-- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
		-- may not popup when typing depends on floating_window setting
	},
}
