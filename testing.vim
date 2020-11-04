echo "tony's files"
nnoremap ,ta :!rspec<cr>
nnoremap ,tt :execute "!rspec %:" . line(".")<cr>
nnoremap ,tf :!rspec %<cr>

function CloseTerminalTest() 
  let buffernumber = bufnr("%")
  let termstatus = term_getstatus(buffernumber)
  if &buftype == "terminal" && termstatus == "finished"
    q
  endif
endfunction

nnoremap <Leader>c :call CloseTerminalTest()<CR>

