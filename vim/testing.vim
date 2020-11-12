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
  if IsJestTest(l:testcommand)
    call FireWarning("Jest doesn't support testing a single test this way")
    return
  endif
  execute "vert term" l:testcommand "%:" . line(".")
endfunction

function IsJestTest(testcmd)
  let l:parsedjestcommand = matchstr(a:testcmd, "--watch-all=false")
  return l:parsedjestcommand != ""
endfunction

function GetTestCommand() 
  let l:extension = expand("%:e")
  if l:extension == "rb"
    return "rspec"
  elseif l:extension == "js" || l:extension == "ts" || l:extension == "tsx"
    return "npm test -- --watch-all=false"
  elseif l:extension == "exs"
    return "mix test"
  else 
    call FireWarning("Test file extension not recognized")
    return
  endif
endfunction

function FireWarning(warning)
  echohl WarningMsg
  echo a:warning
  echohl None
endfunction

nnoremap <Leader>cl :call CloseTerminalTest()<CR>

function CloseTerminalTest() 
  let buffernumber = bufnr("%")
  let termstatus = term_getstatus(buffernumber)
  if &buftype == "terminal" && termstatus == "finished"
    q
  endif
endfunction

