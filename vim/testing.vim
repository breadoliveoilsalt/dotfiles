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
  let l:extension = expand("%:e")
  if extension == "rb"
    return "rspec"
  elseif extension == "js" || extension == "ts" || extension == "tsx"
    return "npm test -- --watch-all=false"
  elseif extension == "exs"
    return "mix test"
  else 
    throw "Test file extension not recognized"
  endif
endfunction

nnoremap <Leader>cl :call CloseTerminalTest()<CR>

function CloseTerminalTest() 
  let buffernumber = bufnr("%")
  let termstatus = term_getstatus(buffernumber)
  if &buftype == "terminal" && termstatus == "finished"
    q
  endif
endfunction


