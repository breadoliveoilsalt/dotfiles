" Set <Leader>
let mapleader=","

set number
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

  
" Disable auto-indent so pasting does not result in odd lines being added
" BUT this messes with expandtab, which ensures spaces are only used
" instead of tabs.  Consider using paste sparingly
" https://stackoverflow.com/questions/37957844/set-expandtab-in-vimrc-not-taking-effect
" set paste

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
set wildignore+=*/tmp/*                          " ignore files in tmp directories
set wildignore+=*/target/*                       " ignore files in target directories
set wildignore+=*/build/*                        " ignore gradle build directories
set wildignore+=*.class                          " ignore .class files
set wildignore+=*.swp                            " ignore .swp files
set wildignore+=*.zip                            " ignore .zip files
set wildignore+=*.pdf                            " ignore .pdf files
set wildignore+=*/node_modules/*                 " ignore node_modules
set wildignore+=*/deps/*                         " ignore deps in elixir 
set wildignore+=*/_build/*                       " ignore build in elixir 
set wildignore+=Session.vim                      " ignore any saved Session file
set wildignore+=*/vendor/assets/*                " ignore vendor/assets for Rails projects
set wildignore+=*/app/assets/images/*            " ignore other images dir for Rails projects
set wildignore+=tags
set wildignore+=*/log/*                          
set wildignore+=*.log
set wildignore+=ngrok
set wildignore+=*.svg

" Store all swp/swap files in a different directory
set directory^=$HOME/.vim/swap//

" No highlight search terms to start
" set nohls
" Adjust highlighting colors
" highlight Search ctermbg=Black ctermfg=White
" highlight Visual ctermbg=Black ctermfg=White

" Search with case-insensitivity unless there's a capital letter 
set ignorecase smartcase 

syntax on

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

" Draw a line down this column. Useful for lining up. Set it to Green.
" Change it to red when in insertmode.
" set colorcolumn=81
" set colorcolumn=0
hi ColorColumn ctermbg=2 ctermfg=7
autocmd InsertEnter * highlight ColorColumn ctermbg=1 ctermfg=7 
autocmd InsertLeave * highlight ColorColumn ctermbg=2 ctermfg=7 

" If you want to restrict the length of a row by column
set textwidth=0

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

" Enlarge current window and shrink others
" Taken from Gary Bernhardt as the magic formula 
" See: https://www.destroyallsoftware.com/file-navigation-in-vim.html
" See: https://github.com/tpope/vim-obsession/issues/4
" set winwidth=84
" set winheight=5
" set winminheight=5
" set winheight=999

" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Increase or decrease window veritcal space by 10 lines
nnoremap <Leader>vm <C-w>10>
nnoremap <Leader>vl <C-w>10<

" Increase or decrease window height by 10 lines
nnoremap <Leader>hm <C-w>10+
nnoremap <Leader>hl <C-w>10-

" Zoom a vim pane
nnoremap <Leader>_ :wincmd _<CR>:wincmd \|<CR>
" Rebalance all panes
nnoremap <Leader>= :wincmd =<CR>

" Disable <C-w>q b/c I keep closing vim by accident
" when trying to switch panes
nnoremap <C-w>q :echo "^wq disabled for quitting window"<CR>

" Highlight current line as default
set cursorline

" Set cursorline for only the current window
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cursorline
  autocmd WinLeave * set nocursorline 
augroup END

" Vim Save Session
nnoremap <Leader>vss :mksession!<CR>

" Disable autosuggest from ^P. Use ^N instead
" inoremap <C-p> <C-[>:echo "^P autocomplete disabled"<CR>

" Format current paragraph with column boundaries
:nnoremap <Leader>fmt {V}gq

" Add # as a comment, and delete it. 
" For Visual maps, this assumes you hit the keystroke
" after selecting in Visual Line mode
" <C-q> takes you from Visual Line mode to Visual Block mode
" vnoremap <Leader>cc <C-q>I# <Esc>
" vnoremap <Leader>dc <C-q>x<Esc>
" nnoremap <Leader>cc 0i# <Esc>
" nnoremap <Leader>dc 0xx<Esc>

" For the future on above: Below did not work to insert a space for some reason
" vnoremap <Leader>c :s/^/#\s/<CR>
" vnoremap <Leader>dc :s/^#\s//<CR>
" nnoremap <Leader>c :s/^/#\s/<CR>
" noremap <Leader>dc :s/^#\s//<CR>

" 210104 I installed NerdCommentary and am trying that out. 
" Commenting out these for now
" vnoremap <Leader>ic :s/^/# /<CR>
" vnoremap <Leader>dc :s/^# /<CR>
" nnoremap <Leader>ic :s/^/# /<CR>
" noremap <Leader>dc :s/^# /<CR>

" Reload (source) vimrc
nnoremap <Leader>so :so ~/.vimrc<CR>

" Turn off odd highlighting when there's a markdown file
" Source: https://coderwall.com/p/bh4rwg/vim-disable-syntax-highlighter-only-for-markdown
autocmd BufRead,BufNewFile {*.markdown,*.mdown,*.mkdn,*.md,*.mkd,*.mdwn,*.mdxt,*.mdtext,*.text,*.txt} set filetype=markdown
autocmd FileType markdown setlocal syntax=off

nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tc :tabclose<CR>

" run current ruby file (aka 'run ruby')
nnoremap <Leader>rr :w\|!ruby %<CR>

" An attempt to reconfigure cursor in highlight mode when 
" using Tmux b/c can't see cursor
"if exists('$TMUX')
"  let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
"  let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
"else
"  let &t_SI = "\e[5 q"
"  let &t_EI = "\e[2 q"
"endif

" Adding b/c of Tim Pope's commentary.vim
autocmd FileType apache setlocal commentstring=#\ %s

filetype plugin on

" From here: https://www.mattcrampton.com/blog/move_vim_swp_files/
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//
