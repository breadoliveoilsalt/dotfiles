" Configurations for netrw (:Ex)
" From here: https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
" Use :Vex to open netrw in vertical split
let g:netrw_banner=0        " disable banner
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_hide=0          " show all files, including hidden ones
let g:netrw_preview=1       " set preview window to vertical
let g:netrw_alto=0          " So preview window is opened to left

" let g:netrw_browse_split=2  " open selected file in a new vertical split when hitting <CR>
" let g:netrw_liststyle=1     " show files with timestamps etc. Overrides tree view
" let g:netrw_winsize=25      " open width to 25% of page
" let g:netrw_browse_split=4  " open in prior window
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

nnoremap <Leader>lx :15Lex<CR>

" Need to use Vex to keep folders open. Lex closes everything.
nnoremap <Leader>ov :Vex<CR>
" I have Vex always to the left, so this moves to left most window
" and closes it
nnoremap <Leader>cv <C-w>10h <bar> :q<CR> 
