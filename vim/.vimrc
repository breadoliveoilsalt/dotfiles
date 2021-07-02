 " function SourceLocal(relativePath)
 "   let root = getcwd()
 "   let root = expand('%:p:h')
 "   let fullPath = root . '/'. a:relativePath
 "   exec 'source ' . fullPath
 " endfunction
 " 
 " call SourceLocal("basicsettings.vim")
 " call SourceLocal("testing.vim")
 " call SourceLocal("netrw.vim")
 " 
 " function CurrentDir()
 "   echo getcwd() 
 " endfunction
 " 
 " call CurrentDir()

" runtime vim/testing.vim
" runtime basicsettings.vim


" echo "Hey"
" echo expand("%")

" let &runtimepath=&runtimepath . "," . expand("%:p:h")
" let &runtimepath=&runtimepath . "," . getcwd()

" Above are various attempts.  None of them seemed to work.
" The problem was I would open vim from a different directory,
" like desktop, and the various uses above kept sourcing to
" *that* particular directory. 
" Below works, although it assumes this file is in ~/Documents and
" is hardcoded
let &runtimepath=&runtimepath . "," . "~/Documents/dotfiles/vim" 
runtime basicsettings.vim
runtime testing.vim
runtime netrw.vim
