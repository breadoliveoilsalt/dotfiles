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

