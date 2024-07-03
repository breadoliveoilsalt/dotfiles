return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "tsx" },
				-- only applied to `ensure_installed`
				sync_install = false,
				auto_install = false,
				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
				},
			})

			-- TODO
			-- Show gitignored files, like `node_modules`

			local toggle_tree = function()
				local tree_api = require("nvim-tree.api").tree
				-- if require("nvim-tree.api").tree.is_visible() then
				if tree_api.is_visible() then -- and tree_api.is_tree_buf() then
					tree_api.toggle()
					return
				end

				if not (tree_api.is_visible()) then
					vim.cmd("vsp")
					tree_api.toggle({ current_window = true })
					return
				end
			end

			-- Cause nvim tree to take over buffer when it opens, rather than split
			-- Use ctrl+e to open file in that buffer
			vim.keymap.set("n", "<Leader>tt", toggle_tree)
			vim.keymap.set(
				"n",
				"<Leader>ft",
				"<Cmd>vsp | lua require('nvim-tree.api').tree.find_file({ current_window = true, update_root = false, open = true, focus = true })<CR>"
			)
		end,
	},
}
