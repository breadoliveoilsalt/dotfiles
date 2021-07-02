function SourceLocal(relativePath)
  let root = expand('%:p:h')
  let fullPath = root . '/'. a:relativePath
  exec 'source ' . fullPath
endfunction

call SourceLocal("basicsettings.vim")
call SourceLocal("testing.vim")
call SourceLocal("netrw.vim")
