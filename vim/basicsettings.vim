" Set <Leader>
let mapleader=","

set number
set tabstop=2
set shiftwidth=2
set expandtab 
set autoindent
set smartindent

" Detect when there has been git reset --hard or file deletion
" and reset buffer
set autoread

" Allow :close, ie, allow hiding unsaved buffers and remember 
" marks/undo for them
set hidden

" Helpful for using :find
" ^= prepends ** to the start of the list
set path^=**
set wildmode=list:longest,list:full
set wildignore+=*/tmp/*                                     " ignore files in tmp directories
set wildignore+=*/target/*                                  " ignore files in target directories
set wildignore+=*/build/*                                   " ignore gradle build directories
set wildignore+=*.class                                     " ignore .class files
set wildignore+=*.swp                                       " ignore .swp files
set wildignore+=*.zip                                       " ignore .zip files
set wildignore+=*.pdf                                       " ignore .pdf files
set wildignore+=*/node_modules/*                            " ignore node_modules
set wildignore+=*/deps/*                                    " ignore deps in elixir 
set wildignore+=*/_build/*                                  " ignore build in elixir 
set wildignore+=Session.vim                                 " ignore any saved Session file

" Store all swp/swap files in a different directory
set directory^=$HOME/.vim/swap//

" No highlight search terms to start
set nohls
" Adjust highlighting colors
highlight Search ctermbg=Black ctermfg=White
highlight Visual ctermbg=Black ctermfg=White

" Search with case-insensitivity unless there's a capital letter 
set ignorecase smartcase 

syntax on

" Enlarge current window and shrink others
" Taken from Gary Bernhardt as the magic formula 
" See: https://www.destroyallsoftware.com/file-navigation-in-vim.html
" See: https://github.com/tpope/vim-obsession/issues/4
" set winwidth=84
" set winheight=5
" set winminheight=5
" set winheight=999

" Set status line to see full path and line, col
" Alternative: To get just line, col, use set ruler
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Always see the status line even if window not split
set laststatus=2

" To deal with delete key not working properly
set backspace=indent,eol,start 

" This might be useless.  See :help nocompatible
" set nocp

set splitbelow
set splitright

" Set clipboard to global clipboard by default
set clipboard=unnamed 

" Draw a line down this column. Useful for lining up
" set colorcolumn=80
" If you want to restrict the length of a row by column
" set textwidth=80

" Insert line below
" nnoremap <CR> o<Esc>k 
" 201109: Disabled the above so I could hit <CR> to implement past
" commands from the command line window after hitting q:

" Set rel num
set rnu
nnoremap <Leader>r :set rnu<CR>
nnoremap <Leader>R :set nornu<CR>

" Map control+^ to open last open file quickly
nmap <Leader><Leader> <C-^>

" Enable fzf, installed using Homebrew
set rtp+=/usr/local/opt/fzf
nnoremap <Leader>fz :FZF<CR>

" Copy relative path to clipboard
nnoremap <Leader>yp :let @+=expand("%")<CR>

" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Increase or decrease window height by 10 lines
nnoremap + <C-W>10+
nnoremap - <C-W>10-

" Zoom a vim pane
nnoremap _ :wincmd _<cr>:wincmd \|<cr>
" Rebalance all panes
nnoremap = :wincmd =<cr>

" Configurations for netrw (:Ex)
" From here: https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
" Use :Vex to open netrw in vertical split
let g:netrw_banner=0        " disable banner
let g:netrw_altv=1          " open splits to the right
"let g:netrw_browse_split=2  " open selected file in a new vertical split when hitting <CR>
let g:netrw_liststyle=3     " tree view
let g:netrw_hide=0          " show all files, including hidden ones
" let g:netrw_liststyle=1     " show files with timestamps etc. Overrides tree view
" let g:netrw_winsize=25      " open width to 25% of page
" let g:netrw_browse_split=4  " open in prior window
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Highlight current line as default
set cursorline

" Set cursorline for only the current window
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cursorline
  autocmd WinLeave * set nocursorline 
augroup END

