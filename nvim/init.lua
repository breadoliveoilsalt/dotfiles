vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-------------------------
-- BOOTSTRAP lazy.nvim --
-------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

---------------
-- NVIM TREE --
---------------

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.keymap.set("n", "<Leader>tt", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<Leader>ft", "<cmd>NvimTreeFindFile<cr>")

-- TODO: merge this with plugins.lu
-- Show gitignored files, like `node_modules`
require("nvim-tree").setup({
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
      }
    },
  }
-- To avoid absolute paths in buffer list
-- See: https://www.reddit.com/r/neovim/comments/yftm83/nvimtree_is_driving_me_nuts/
-- Seems this changes the directory when you go up the tree in the tree itself! Not what I want
	-- actions = {
	-- 	change_dir = {
	-- 		global = true,
	-- 	},
	-- },
})

-----------------
-- MY SETTINGS -
-----------------

-- Note extra <CR> to force silence after the bang command is run
-- vim.keymap.set("n", "<Leader>cs", "<cmd>!cp -a ~/Documents/dotfiles/nvim/ ~/.config/nvim<cr><cr>",
--   { silent = true, desc = "[c]opy [s]ource" })
vim.keymap.set(
	"n",
	"<Leader>cs",
	"<cmd>!cp -a ~/Documents/dotfiles/nvim/ ~/.config/nvim<cr><cr> | <cmd>echo 'neovim config file copied!'<cr>",
	{ silent = true, desc = "[c]opy [s]ource" }
)

vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hls = false

vim.cmd([[colorscheme slate]])

-- Go to alternate file quickly
vim.keymap.set("n", "<Leader><Leader>", "<C-^>")

-- Set clipboard to global clipboard by default
vim.opt.clipboard = "unnamed"

-- Allow :close, ie, allow hiding unsaved buffers
vim.opt.hidden = true

-- Disable auto-commenting next line
-- See: https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
vim.keymap.set(
	"n",
	"<Leader>dc",
	"<cmd>set formatoptions-=cro<cr>",
	{ desc = "[d]isable/delete/destory auto-[c]ommenting" }
)

vim.keymap.set("n", "<Leader>yp", '<cmd>let @+=expand("%")<cr>', { desc = "[y]ank [p]ath" })

vim.keymap.set(
	"n",
	"<Leader>bd",
	"<cmd>bp|bd#<cr>",
	{ desc = { "[b]uffer [d]elete: Return to last file before deleting buffer, to prevent window closing" } }
)

-- Increase or decrease window
-- Think: window-wider, window-narrower, window-taller, window-shorter
vim.cmd([[
  nnoremap <Leader>ww <C-w>20>
  nnoremap <Leader>wn <C-w>20<
  nnoremap <Leader>wt <C-w>10+
  nnoremap <Leader>ws <C-w>10-
  nnoremap <Leader>z :wincmd _<CR>:wincmd \|<CR>
  nnoremap <Leader>= :wincmd =<CR>
]])

-- Automatically rebalance windows on vim resize
vim.cmd([[
  autocmd VimResized * wincmd =
]])

-- Disable <C-w>q b/c I keep closing vim by accident
-- when trying to switch panes
vim.cmd([[
  nnoremap <C-w>q :echo "^wq disabled for quitting window"<CR>
]])

-- Open quickfix immediately upon search
-- https://www.reddit.com/r/vim/comments/bmh977/automatically_open_quickfix_window_after/
-- https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
vim.cmd([[
  augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
  augroup END
]])

vim.keymap.set(
	"n",
	"<Leader>ss",
	"<cmd>mks!<cr> | <cmd>echo 'Session saved!'<cr>",
	{ silent = true, desc = "[s]ave [s]ession" }
)
-- vim.cmd([[
--   nnoremap <Leader>ss :mks!<CR> | echo 'Session saved!'
-- ]])

-- Hide mode in status line, deferring to lualine
-- With noshowmode in effect, hide last ex-command entered
vim.cmd([[
  set noshowmode
  augroup cmdline
    autocmd!
    autocmd CmdlineLeave : echo ''
  augroup end
]])

vim.api.nvim_exec(
	[[
  function AppendConsoleLog()
    let l:current_word = expand('<cword>')
    execute "normal! daw"
    " execute "normal! i// eslint-disable-next-line"
    execute "normal! i console.log('" . l:current_word . "', " . l:current_word . ")"
    execute "normal! A"
    " execute "normal! x"
  endfunction
]],
	false
)

-- `il` for insert logger. Changes word under cursor in to logging command
vim.cmd([[
  nnoremap <Leader>il :call AppendConsoleLog()<CR>
]])

-------------------------
-- TRAILING WHITESPACE --
-------------------------

-- Show trailing whitespaces.
-- See: https://stackoverflow.com/questions/48935451/how-do-i-get-vim-to-highlight-trailing-whitespaces-while-using-vim-at-the-same-t
vim.cmd([[
  highlight TrailingWhiteSpaces ctermbg=red guibg=red
  match TrailingWhiteSpaces /\s\+$/
]])

vim.api.nvim_exec(
	[[
  function DeleteTrailingWhitespace()
    " %s/\s*$//
    s/\s*$//
  endfunction
]],
	false
)

vim.cmd([[
  nnoremap <Leader>dw :call DeleteTrailingWhitespace()<CR>
  vnoremap <Leader>dw :call DeleteTrailingWhitespace()<CR>
]])

----------------------
-- MARKDOWN HELPERS --
----------------------

-- for use of `range` see:
-- https://vi.stackexchange.com/questions/17606/vmap-and-visual-block-how-do-i-write-a-function-to-operate-once-for-the-entire

vim.api.nvim_exec(
	[[
  function InsertBackticks()
    execute "normal! i```\n\n```"
    execute "normal! k"
  endfunction

  function SurroundVisualLinesWithBackticks() range
    '<
    execute "normal! O```"
    '>
    execute "normal! o```"
  endfunction

  function InsertBreak()
    set formatoptions-=cro
    normal! i-----
    normal! o
    normal! o
  endfunction
]],
	false
)

vim.cmd([[
  nnoremap <Leader>it :call InsertBackticks()<CR>
  vnoremap <Leader>it :call SurroundVisualLinesWithBackticks()<CR>
  nnoremap <Leader>ib :call InsertBreak()<CR>
]])

-- Assumes slate colorscheme. Better color for comments
-- vim.cmd([[
--   autocmd BufRead,BufNewFile,BufFilePre *.markdown,*.md hi Comment ctermfg=yellow guifg=yellow | set tabstop=2 shiftwidth=2
-- ]])

vim.cmd([[
  autocmd BufRead,BufNewFile,BufFilePre *.markdown,*.md set tabstop=2 shiftwidth=2
]])
-------------------------
-- PASTING SCREENSHOTS --
-------------------------

vim.api.nvim_exec(
	[[
  " If current working file is vim/pasteScreenShot.vim', this will paste
  " screen shot in vim/assets.pasteScreenShot/pasteScreenShot-image-2022-01-08-00-00-00.png
  function PasteClipboardImageWithMarkdown()
    let current_file_name_without_ext = expand("%:t:r")
    let img_directory_name = current_file_name_without_ext . ".assets"
    let img_directory_absolute_path = expand("%:p:h") . "/" . img_directory_name

    if !isdirectory(img_directory_absolute_path)
      silent call mkdir(img_directory_absolute_path)
    endif

    let img_file_name = current_file_name_without_ext . "-image-" . strftime("%Y-%m-%d-%H-%M-%S") . ".png"

    let paste_command = "pngpaste " . img_directory_absolute_path . " " . img_file_name

    " Note below the dependency on `pngpaste`. This is defined here in the
    " `customCommands` directory.  Also note: To be recognized by `system` (or by
    " an Ex bang command), pngpaste must be a script available in /usr/local/bin.
    " It cannot be a function loaded up in .zshrc
    silent call system(paste_command)

    if v:shell_error == 1
      echo "Something went wrong saving image from clipboard. Maybe text was there."
    else
     execute "normal! i![](" . img_directory_name . "/" . img_file_name . ")"
    endif
  endfunction

  function OpenMarkdownViewer()
    let file_name_full_path = expand("%:p")
    let open_markdown_viewer_command = "open -a 'Google Chrome' file://" . file_name_full_path
    silent call system(open_markdown_viewer_command)
  endfunction
]],
	false
)

vim.cmd([[
  nnoremap <Leader>ps :call PasteClipboardImageWithMarkdown()<CR>
  nnoremap <Leader>om :call OpenMarkdownViewer()<CR>
]])

-- Highlight current line as default
vim.opt.cursorline = true

-- Set cursorline for only the current window
vim.cmd([[
  augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
  augroup END
]])

----------------
-- AUTOSAVING --
-----------------

--  Auto-save on buffer switch
vim.opt.autowriteall = true

-- Auto-save on focus lost, not saving untitled buffers or read-only files
-- See: https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost
vim.api.nvim_create_autocmd("FocusLost", {
	pattern = "*",
	command = "silent! wa",
})

-- Store all swp/swap files in a different directory
-- https://www.mattcrampton.com/blog/move_vim_swp_files/
vim.cmd([[
  set backupdir=~/.config/nvim/backup_files//
  set directory=~/.config/nvim/swap_files//
  set undodir=~/.config/nvim/undo_files//
]])

------------------------------
-- SAVING BY OTHER PROGRAMS --
------------------------------

-- Detect when there has been git reset --hard or file deletion and reset buffer
vim.opt.autoread = true

-- Triger `autoread` when files changes on disk
-- See:
--  * :help checktime
--   * https://stackoverflow.com/questions/923737/detect-file-change-offer-to-reload-file
--   * https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim
--     * NOTE with above: it requires a tmux conf change
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "FocusGained", "BufEnter" }, {
	pattern = { "*" },
	command = "checktime",
})

-- Notification after file change
-- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	pattern = "*",
	command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})

-- Probably redundant of above. Consider deleting after
-- wait period
-- vim.api.nvim_create_autocmd(
--   "FileChangedShell",
--   {
--     pattern = { "*" },
--     callback = function() print("TN Warning: File changed on disk") end
--   }
-- )

---------------
-- TELESCOPE --
---------------

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
vim.keymap.set("n", "<Leader>fb", telescope_builtin.buffers, {})
vim.keymap.set("n", "<Leader>fh", telescope_builtin.help_tags, {})

-------------
-- LSP'ing --
-------------

require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require("lspconfig")

-- vim.lsp.set_log_level("debug")

-- tsserver config options are limited
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
lspconfig.tsserver.setup({})

lspconfig.eslint.setup({})

-- Source: https://github.com/neovim/neovim/issues/21686
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global and not consider `vim.*` an error, for example.
				globals = {
					"vim",
					"require",
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- IMPORTANT LESSONS SETTING UP PRETTIERD AND EFMLS
-- 1) You can double check whether your prettier config
-- file is formatted correctly by running something like
-- this, b/c the LSP server will not tell you the error
--  `cat nvimTest.js | PRETTIERD_DEFAULT_CONFIG=~/Documents/dotfiles/prettier/.prettierrc prettierd nvimTest.js`
-- 2) For an lsp set up with lspconfig, the order of
-- filttypes listed in the `filetypes` property must
-- be repeated in the `languages` property. The order
-- of the languages must match (be repeated) or
-- things will not work!
-- 3) `rootMarkers` matter for efmls. That is, if the
-- underlying program or daemon efmls trigges relies
-- some kind of config file (`e.g., `.prettierrc`),
-- then that must be in the table of rootMarkers.
-- 4) For prettierd, changes in closest prettierrd
-- config file take effect immediately. HOWEVER, if
-- that file imports another file, and changes are
-- made in the imported file, the changes will not
-- take effect until prettierd damon is stopped &
-- started again:
--   `prettierd stop && prettierd start`

-- Alternatives to prettierd config below:
-- a) Call daemon and have it search up until it finds a
-- config in your home directory:
--   `ln -fs ~/Documents/dotfiles/prettier/.prettierrc ~/.prettierrc`
-- b) A different format command:
--   `formatCommand = 'PRETTIERD_DEFAULT_CONFIG=~/Documents/dotfiles/prettier/.prettierrc prettierd "${INPUT}"',`
local prettier_config_file = "~/Documents/dotfiles/prettier/.prettierrc"

local prettier_d_config = {
	formatCommand = 'prettierd "${INPUT}"',
	formatStdin = true,
	env = {
		string.format("PRETTIERD_DEFAULT_CONFIG=%s", vim.fn.expand(prettier_config_file)),
	},
	rootMarkers = {
		".prettierrc",
		".prettierrc.json",
		".prettierrc.js",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.mjs",
		".prettierrc.cjs",
		".prettierrc.toml",
	},
}

local stylua_config = {
	formatCommand = "stylua --color Never ${--range-start:charStart} ${--range-end:charEnd} -",
	formatStdin = true,
	formatCanRange = true,
	rootMarkers = { "stylua.toml", ".stylua.toml" },
}

lspconfig.efm.setup({
	init_options = { documentFormatting = true },
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "lua" },
	settings = {
		languages = {
			typescript = { prettier_d_config },
			javascript = { prettier_d_config },
			javascriptreact = { prettier_d_config },
			typescriptreact = { prettier_d_config },
			lua = { stylua_config },
		},
	},
	-- Autoformat on save
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#code
	-- on_attach = function(client, bufnr)
	-- if client.supports_method("textDocument/formatting") then
	--   local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	--   vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	--   vim.api.nvim_create_autocmd("BufWritePre", {
	--     group = augroup,
	--     buffer = bufnr,
	--     callback = function()
	--       vim.lsp.buf.format({ async = false })
	--     end,
	--   })
	-- end
	-- end,
})

-- General format on save:
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   pattern = {
--     "*.js",
--     "*.jsx",
--     "*.ts",
--     "*.tsx",
--   },
--   callback = function()
--     vim.lsp.buf.format()
--   end
-- })

-- lspconfig.spectral.setup{}

require("lspconfig").yamlls.setup({
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				-- ["../path/relative/to/file.yml"] = "/.github/workflows/*",
				-- ["/path/from/root/of/project"] = "/.github/workflows/*",
			},
		},
	},
})

vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		-- `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<Leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<Leader>cn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	end,
})

vim.keymap.set("n", "<Leader>rf", vim.lsp.buf.format, {
	desc = "[r]un [f]ormatter",
})

-- Never request typescript-language-server for formatting
-- :help vim.lsp.buf.format
vim.lsp.buf.format({
	filter = function(client)
		return client.name ~= "tsserver" or client.name ~= "lua_ls"
	end,
})

-- Keep gutter open for LSP diagnostics
-- https://github.com/neovim/nvim-lspconfig/issues/1309
vim.opt.signcolumn = "yes"

-- Avoid diagnostics disappearing on insert mode
-- and reappearing in normal mode
vim.diagnostic.config({ update_in_insert = true })

-------------
-- DAP'ing --
-------------

-- -- This is huge and what I really need to do:
-- -- https://theosteiner.de/debugging-javascript-frameworks-in-neovim
-- -- Also helpful:
-- -- https://miguelcrespo.co/posts/debugging-javascript-applications-with-neovim/
-- require("dap-vscode-js").setup({
-- 	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
-- 	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
-- 	-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
-- 	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
-- 	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
-- 	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
-- 	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
-- })

-- for _, language in ipairs({ "typescript", "javascript" }) do
-- 	require("dap").configurations[language] = {
-- 		{
-- 			type = "pwa-node",
-- 			request = "launch",
-- 			name = "Launch file",
-- 			program = "${file}",
-- 			cwd = "${workspaceFolder}",
-- 		},
-- 		{
-- 			type = "pwa-node",
-- 			request = "attach",
-- 			name = "Attach",
-- 			processId = require("dap.utils").pick_process,
-- 			cwd = "${workspaceFolder}",
-- 		},
-- 		{
-- 			type = "pwa-node",
-- 			request = "launch",
-- 			name = "Debug Jest Tests",
-- 			-- trace = true, -- include debugger info
-- 			runtimeExecutable = "node",
-- 			runtimeArgs = {
-- 				"./node_modules/jest/bin/jest.js",
-- 				"--runInBand",
-- 			},
-- 			rootPath = "${workspaceFolder}",
-- 			cwd = "${workspaceFolder}",
-- 			console = "integratedTerminal",
-- 			internalConsoleOptions = "neverOpen",
-- 		},
-- 	}
-- end
