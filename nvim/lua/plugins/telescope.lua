local setup = function()
	local telescope = require("telescope")

	telescope.load_extension("fzf")

	local find_file_command = {
		"rg",
		"--files",
		"--hidden",
		"-g",
		"!.git",
		"-g",
		"!**/*/PackageBuilder/resources.js",
		"-g",
		"!**/*/src/assets/",
		"-g",
		"!*.snap",
		"-g",
		"!build/",
	}

	telescope.setup({
		defaults = {
			layout_config = { height = 0.98, width = 0.98, preview_width = 0.6 },
			vimgrep_arguments = {
				-- set grepprg=rg\ --hidden\ --follow\ --vimgrep
				-- nnoremap <Leader>fw :grep! -g "!**/*/PackageBuilder/resources.js" -g "!**/*/src/assets/" -g "!.git/" -g "!*.snap" -g "!build/" -e '

				"rg",
				"--hidden",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--glob=!**/*/src/assets/",
				"--glob=!.git/",
				"--glob=!*.snap",
				-- BEWARE
				-- "--glob=!*.test.*",
			},
			-- Preserve past searches
			-- See: https://github.com/nvim-telescope/telescope.nvim/issues/2024
			-- :help telescope.defaults.cache_picker
			cache_picker = {
				num_pickers = 5,
			},
		},
		pickers = {
			find_files = {
				find_command = find_file_command,
			},
		},
	})

	local telescope_builtin = require("telescope.builtin")

	vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
	vim.keymap.set("n", "<Leader>fw", telescope_builtin.live_grep, {})

	-- BIG LESSON / REMINDER HERE: the third argument has to be a function.
	-- If you are using options, make sure you wrap things in an
	-- anonymous function.
	-- Below, another potential option to consider: { ignore_current_buffer = true }
	vim.keymap.set("n", "<C-p>", function()
		telescope_builtin.buffers({ sort_lastused = true })
	end)
	vim.keymap.set("n", "<Leader>fb", function()
		telescope_builtin.buffers({ sort_lastused = true, ignore_current_buffer = true })
	end)
	vim.keymap.set("n", "<Leader>fh", telescope_builtin.help_tags, {})
	vim.keymap.set("n", "<Leader>fl", telescope_builtin.resume, {
		desc = "[f]ind [l]ast: bring up last search auto-[c]ommenting",
	})
	vim.keymap.set("n", "<Leader>fc", telescope_builtin.pickers, {
		desc = "[f]ind [c]ached: bring up picker for last several searches",
	})
end

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = setup,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
}
