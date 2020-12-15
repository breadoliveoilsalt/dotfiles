nnoremap <Leader>ta :call TestAll()<cr>
nnoremap <Leader>tf :call TestFile()<cr>
nnoremap <Leader>tt :call TestThis()<cr>

function TestAll()
  try
    let l:test_command = GetTestCommand()
    execute "vert term" l:test_command
    execute 'vertical resize '. string(&columns * 0.50)
  catch
    call FireWarning(v:exception)
  endtry
endfunction

function TestFile()
  try
    let l:test_command = GetTestCommand()
    execute "vert term" l:test_command "%"
    execute 'vertical resize '. string(&columns * 0.50)
  catch
    call FireWarning(v:exception)
  endtry
endfunction

function TestThis()
  try
    let l:test_command = GetTestCommand()
    if IsJestTest(l:test_command)
      throw "Jest doesn't support testing a single test this way."
    endif
    execute "vert term" l:test_command "%:" . line(".")
    execute 'vertical resize '. string(&columns * 0.50)
  catch
    call FireWarning(v:exception)
  endtry
endfunction

function IsJestTest(test_command)
  let l:parsed_jest_command = matchstr(a:test_command, "--watch-all=false")
  return l:parsed_jest_command != ""
endfunction

let g:test_command_override = ""

function GetTestCommand() 
  if g:test_command_override != ""
    echo 'Running test with g:test_command_override. Use :let g:test_command_override = "" to reset'
    return g:test_command_override
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
    throw 'Test file extension not recognized. Use :let g:test_command_override="<command>" to set a custom test command.'
  endif
endfunction

function FireWarning(warning)
  echohl WarningMsg
  echo a:warning
  echohl None
endfunction

nnoremap <Leader>cl :call CloseTest()<CR>

function CloseTest() 
  if &buftype == "terminal"
    let l:buffer_number = bufnr("%")
    let l:terminal_status = term_getstatus(buffer_number)
    if l:terminal_status == "finished"
      q
    endif
  endif
endfunction

