vim.cmd([[
  set rnu
  set number
]])
vim.keymap.set("n", "<Leader>if", "<CMD>normal % | wa<CR>", { desc = "[i]nsert [f]ile" })
vim.keymap.set("n", "<Leader>id", "<CMD>normal d<CR>", { desc = "[i]nsert [d]irectory" })
vim.keymap.set("n", "<Leader>df", "<CMD>normal D<CR>", { desc = "[d]elete [f]file (or directory)" })
vim.keymap.set("n", "<Leader>cn", "<CMD>normal R<CR>", { desc = "[c]hange [n]ame (of file or directory)" })
vim.keymap.set("n", "<Leader>sf", "<CMD>normal r<CR>", { desc = "[s]ort [f]iles" })
vim.keymap.set("n", "<Leader>tv", "<CMD>normal i<CR>", { desc = "[t]oggle [v]iew" })
vim.keymap.set("n", "<Leader>rt", "<C-l>", { desc = "[r]efresh [t]ree" })
