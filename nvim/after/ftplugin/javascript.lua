-- Re: need for `!`, see:
-- https://vi.stackexchange.com/questions/21856/is-it-necessary-to-always-add-to-function-and-command
vim.api.nvim_exec(
	[[
  function! AppendConsoleLog()
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

vim.cmd([[
  nnoremap <Leader>tf :wa \| vsp \| term npm run test.unit %<CR>
  nnoremap <Leader>cf :wa \| !npm run compile<CR>
  nnoremap <Leader>ef :wa \| !npm run execute<CR>
  nnoremap <Leader>qd :lua vim.diagnostic.setqflist()<CR>
]])
-- vim.keymap.set("n", "<Leader>tf", "<CMD>wa \\| vsp \\| term npm run test %<CR>", { desc = "[t]est [f]ile" })

