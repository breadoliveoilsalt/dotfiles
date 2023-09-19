vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

print("LOADING CONFIG FROM DOTFILES")

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
--

require("lazy").setup("plugins")

-- require("lazy").setup(plugins, opts)


---------------------------
-- OPTIONS FOR NVIM TREE --
---------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true


vim.keymap.set("n", "<Leader>tt", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<Leader>ft", "<cmd>NvimTreeFocus<cr>")

-----------------
-- MY SETTINGS --
-----------------

-- TEST TO SEE IF COPY WORKS
-- Does not work
-- vim.keymap.set("n", "<Leader>so", "<cmd>!cp -a ~/Documents/dotfiles/nvim/ ~/.config/nvim | so ~/.config/nvim/init.lua<cr>") 
vim.keymap.set("n", "<Leader>so", "<cmd>!cp -a ~/Documents/dotfiles/nvim/ ~/.config/nvim<cr>")

vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Allow :close, ie, allow hiding unsaved buffers
vim.opt.hidden = true

-- Set status line to see full path and line, col
-- Alternative: To get just line, col, use set ruler
-- I may not need this?
-- vim.opt.statusline="%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)"

-- Disable auto-commenting next line
-- See: https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
vim.opt.formatoptions:remove('cro')

----------------
-- AUTOSAVING --
-----------------

--  Auto-save on buffer switch
vim.opt.autowriteall = true

-- Auto-save on focus lost, not saving untitled buffers or read-only files
-- See: https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost
vim.api.nvim_create_autocmd("FocusLost",
  {
    pattern = "*",
    command = "silent! wa"
  }
)

-- Notification after file change
-- See: https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
vim.api.nvim_create_autocmd("FileChangedShellPost",
  {
    pattern = "*",
    command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None"
  }
)

-- Store all swp/swap files in a different directory
vim.opt.directory:prepend("$HOME/.config/nvim/swap//")

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
vim.api.nvim_create_autocmd(
  {"CursorHold","CursorHoldI","FocusGained","BufEnter"},
  {
    pattern = {"*"},
    command = "checktime"
  }
)

vim.api.nvim_create_autocmd(
  "FileChangedShell",
  {
    pattern = {"*"},
    callback = function() print("TN Warning: File changed on disk") end
  }
)


