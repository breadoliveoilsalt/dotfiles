nnoremap <Leader>ta :call TestAll()<cr>
nnoremap <Leader>tf :call TestFile()<cr>
nnoremap <Leader>tt :call TestThis()<cr>

function TestAll()
  try
    let l:testcmd = GetTestCommand()
    execute "vert term" l:testcmd
  catch
    call FireWarning(v:exception)
  endtry
endfunction

function TestFile()
  try
    let l:testcmd = GetTestCommand()
    execute "vert term" l:testcmd "%"
  catch
    call FireWarning(v:exception)
  endtry
endfunction

function TestThis()
  try
    let l:testcmd = GetTestCommand()
    if IsJestTest(l:testcmd)
      throw "Jest doesn't support testing a single test this way."
    endif
    execute "vert term" l:testcmd "%:" . line(".")
  catch
    call FireWarning(v:exception)
  endtry
endfunction

function IsJestTest(testcmd)
  let l:parsedjestcommand = matchstr(a:testcmd, "--watch-all=false")
  return l:parsedjestcommand != ""
endfunction

let g:testcmd = ""

function GetTestCommand() 
  if g:testcmd != ""
    echo 'Running test with g:testcmd. Use :let g:testcmd = "" to reset'
    return g:testcmd
  else
    return GetTestCommandByExt()
  endif
endfunction

function GetTestCommandByExt()
  let l:extension = expand("%:e")
  if l:extension == "rb"
    return "rspec"
  elseif l:extension == "js" || l:extension == "ts" || l:extension == "tsx"
    return "npm test -- --watch-all=false"
  elseif l:extension == "exs"
    return "mix test"
  else 
    throw 'Test file extension not recognized. Use :let g:testcmd="<command>" to set a custom test command.'
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

