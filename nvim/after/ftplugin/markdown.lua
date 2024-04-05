----------------------
-- MARKDOWN HELPERS --
----------------------

-- for use of `range` see:
-- https://vi.stackexchange.com/questions/17606/vmap-and-visual-block-how-do-i-write-a-function-to-operate-once-for-the-entire

vim.api.nvim_exec(
	[[
  function! InsertBackticks()
    execute "normal! i```\n\n```"
    execute "normal! k"
  endfunction

  function! SurroundVisualLinesWithBackticks() range
    '<
    execute "normal! O```"
    '>
    execute "normal! o```"
  endfunction

  function! InsertBreak()
    normal! o
    set formatoptions-=cro
    normal! i-----
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
