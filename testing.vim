let g:testlib = "rspec"

nnoremap <Leader>ta :call TestAll()<cr>
nnoremap <Leader>tf :call TestFile()<cr>
nnoremap <Leader>tt :call TestThis()<cr>

function TestAll()
  let l:testcommand=GetTestCommand()
  execute "vert term" l:testcommand
endfunction

function TestFile()
  let l:testcommand=GetTestCommand()
  execute "vert term" l:testcommand "%"
endfunction

function TestThis()
  let l:testcommand=GetTestCommand()
  execute "vert term" l:testcommand "%:" . line(".")
endfunction

function GetTestCommand() 
  if g:testlib == "rspec"
    return "rspec"
  elseif g:testlib == "jest"
    return "npm test -- --watch-all=false"
  elseif g:testlib == "mix"
    return "mix test"
  else 
    return ""
  endif
endfunction

nnoremap <Leader>c :call CloseTerminalTest()<CR>

function CloseTerminalTest() 
  let buffernumber = bufnr("%")
  let termstatus = term_getstatus(buffernumber)
  if &buftype == "terminal" && termstatus == "finished"
    q
  endif
endfunction


