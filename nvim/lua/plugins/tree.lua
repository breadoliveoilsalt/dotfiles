return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				-- not help, it seems
				-- not help
				-- hijack_unnamed_buffer_when_opening = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
				respect_buf_cwd = true,
				sync_root_with_cwd = true,
				prefer_startup_root = true,
				filters = {
					git_ignored = false,
				},
				renderer = {
					indent_markers = {
						enable = true,
					},
					icons = {
						show = {
							folder_arrow = false,
						},
					},
				},
				actions = {
					open_file = {
						quit_on_open = true,
					},
				},

				-- To avoid absolute paths in buffer list
				-- See: https://www.reddit.com/r/neovim/comments/yftm83/nvimtree_is_driving_me_nuts/
				-- Seems this changes the directory when you go up the tree in the tree itself! Not what I want
				-- actions = {
				-- 	change_dir = {
				-- 		global = true,
				-- 	},
				-- },
			})
		end,
	},
}
