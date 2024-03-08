return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					-- theme = 'moonfly'
					-- theme = 'papercolor_dark'
					theme = "papercolor_light",
				},
				-- override defaults
				sections = {
					lualine_c = {
						{
							"filename",
							path = 1,
						},
					},
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				inactive_sessions = {
					lualine_c = {
						{
							"filename",
							path = 1,
						},
					},
				},
			})
		end,
	},
}
