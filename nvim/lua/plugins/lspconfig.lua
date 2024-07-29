return {
	{
		"neovim/nvim-lspconfig",
		lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
		dependencies = {
			-- main one
			{ "ms-jpq/coq_nvim", branch = "coq" },

			-- 9000+ Snippets
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },

			-- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
			-- Need to **configure separately**
			-- { "ms-jpq/coq.thirdparty", branch = "3p" },
			-- - shell repl
			-- - nvim lua api
			-- - scientific calculator
			-- - comment banner
			-- - etc
		},
		init = function()
			vim.g.coq_settings = {
				-- auto_start = true, -- if you want to start COQ at startup
				auto_start = false, -- if you want to start COQ at startup
				-- Your COQ settings here
        -- Turning off pre_select for now. Messes things up 
        -- by selecting an unwanted suggestion when all I want is
        -- a new line, and so hit return.
				-- keymap = {
					-- pre_select = true,
				-- },
			}
		end,
		config = function()
			-- Your LSP settings here
		end,
	},
}
