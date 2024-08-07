" Automate installation of vim-plug
" See here: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation-of-missing-plugins
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
" autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"   \| PlugInstall --sync | source $MYVIMRC
" \| endif

call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'preservim/nerdtree'

call plug#end()

" Set <Leader>
nnoremap <SPACE> <Nop>
let mapleader=" "

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
" Triger `autoread` when files changes on disk
" See:
"  - https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim
"    - NOTE with above: it requires a tmux conf change
"  - https://stackoverflow.com/questions/923737/detect-file-change-offer-to-reload-file
"  - :help checktime
au CursorHold,CursorHoldI,FocusGained,BufEnter * checktime
au FileChangedShell * echo "TN Warning: File changed on disk"

" Alternatively:
" From here: https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim
" " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
"autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
" \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Auto-save on buffer switch
set autowriteall

" Auto-save on focus lost, not saving untitled buffers or read-only files
" See: https://vim.fandom.com/wiki/Auto_save_files_when_focus_is_lost
autocmd FocusLost * silent! wa

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
 \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

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

" Toggle rnu on and off
" For more on toggling, see: https://learnvimscriptthehardway.stevelosh.com/chapters/38.html
nnoremap <Leader>rn :setlocal rnu!<cr>

" Map control+^ to open alternate file quickly
nmap <Leader><Leader> <C-^>

" Enable fzf, installed using Homebrew
" Note, because of the set below, I *probably* don't need the vim-fzf plugin
" Think: find file; find word
set rtp+=/usr/local/opt/fzf
nnoremap <Leader>ff :FZF<CR>
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.3, 'relative': v:true, 'yoffset': 1.0 } }
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.3, 'yoffset': 1.0 } }


" Trying this out temporarily
" nnoremap <Leader>fw :Rg<CR>
" nnoremap <Leader>fw :grep -g '!*.snap' -g '!*test*' -g '!*spec*' -e '
" nnoremap <Leader>fw :grep! -g "!{*snap, *test*, *spec*, *cypress/, build/, test/}" -g "!*.snap" -g "!.git/" -e '
" NOTE that folder exclusions are read relative to the root directory. -g \"!build/\" will only work if build is in the root directory
" nnoremap <Leader>fw :grep! -g "!**/*/PackageBuilder/resources.js" -g "!**/*/src/assets/" -g "!.git/" -g "!*.snap" -g "!build/" -g "!**/*/cypress/" -g "!*test*" -g ".yarn/" -e '
nnoremap <Leader>fw :grep! -g "!**/*/PackageBuilder/resources.js" -g "!**/*/src/assets/" -g "!.git/" -g "!*.snap" -g "!build/" -e '

" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --hidden --follow --no-ignore-vcs -g "!{node_modules,.git, build, tags}" --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)

" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --hidden --follow --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)

" Sets Ripgrep to :grep command
" Can search regex with :grep -e "[Rr]egex"
" To not jump to first result in quickfix => :grep! -e "[Rr]exex"
set grepprg=rg\ --hidden\ --follow\ --vimgrep

" Copy relative path to clipboard
" yank file path
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
autocmd VimResized * wincmd =

" Increase or decrease window
" Think: window-wider, window-narrower, window-taller, window-shorter
nnoremap <Leader>ww <C-w>20>
nnoremap <Leader>wn <C-w>20<
nnoremap <Leader>wt <C-w>10+
nnoremap <Leader>ws <C-w>10-

" Zoom a vim pane
nnoremap <Leader>z :wincmd _<CR>:wincmd \|<CR>
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

" Reload (source) vimrc
nnoremap <Leader>so :so ~/.vimrc<CR>

" autocmd BufRead,BufNewFile,BufFilePre *.markdown,*.mdown,*.mkdn,*.md,*.mkd,*.mdwn,*.mdxt,*.mdtext,*.text,*.txt set filetype=markdown

autocmd BufRead,BufNewFile,BufFilePre *.markdown,*.mdown,*.mkdn,*.md,*.mkd,*.mdwn,*.mdxt,*.mdtext,*.text,*.txt set filetype=markdown tabstop=2 shiftwidth=2

" Adding b/c of Tim Pope's commentary.vim
autocmd FileType apache setlocal commentstring=#\ %s

filetype plugin on

" From here: https://www.mattcrampton.com/blog/move_vim_swp_files/
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

command Iq :lcd ~/documents/projects/legalZoom/iq-flow/
command Dotfiles :lcd ~/documents/dotfiles/

" Run Prettier or eslint
" Depends on running `npx install -g prettier eslint`
" command Pretty execute '!npx prettier --write '. expand("%")
command Pretty execute 'term npx prettier --write '. expand("%")
command Lint execute 'term npx eslint '. expand("%")

" Open quickfix immediately upon search
" https://www.reddit.com/r/vim/comments/bmh977/automatically_open_quickfix_window_after/
" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
augroup END

" This is an autocommand to make session on save, but
" really what I need is something that confirms quitting and
" asks if you want to make session: y/n/c
" autocmd VimLeavePre * exec "mks!"

" Show trailing whitespaces. See link below
" https://stackoverflow.com/questions/48935451/how-do-i-get-vim-to-highlight-trailing-whitespaces-while-using-vim-at-the-same-t
highlight TrailingWhiteSpaces ctermbg=red guibg=red
match TrailingWhiteSpaces /\s\+$/

function AppendConsoleLog()
  let l:current_word = expand('<cword>')
  execute "normal! daw"
  " execute "normal! i console.log('" . l:current_word . "', " . l:current_word . ")"
  execute "normal! i// eslint-disable-next-line"
  execute "normal! i console.log('" . l:current_word . "', " . l:current_word . ")"
"  execute "normal! oconsole.log('" . l:current_word . "', " . l:current_word . ")"
endfunction

" `il` for insert logger. Changes word under cursor in to logging command
nnoremap <Leader>il :call AppendConsoleLog()<CR>

" 230926 commenting out
"function ConfirmQuit()
"  "See :help confirm() -- not :help confirm
"  let l:choice = confirm("Save session first?", "&Save\n&Quit\n&Cancel")
"  if choice == 1
"    mks!
"    quit
"  elseif choice == 2
"    quit
"  endif
"endfunction

" NOTE: this is mapping an Ex-mode command. Note that `:` not needed
" cnoremap q<CR> call ConfirmQuit()<CR>
" Below not really work, but above slows down qa for some reason
" cnoremap <silent> qa<CR> :echo "no no no"<CR>

function InsertBackticks()
  execute "normal! i```\n\n```"
  execute "normal! k"
endfunction

nnoremap <Leader>ib :call InsertBackticks()<CR>

" for use of `range` see: https://vi.stackexchange.com/questions/17606/vmap-and-visual-block-how-do-i-write-a-function-to-operate-once-for-the-entire
function SurroundVisualLinesWithBackticks() range
  '<
  execute "normal! O```"
  '>
  execute "normal! o```"
endfunction

vnoremap <Leader>ib :call SurroundVisualLinesWithBackticks()<CR>

function DeleteTrailingWhitespace()
  " %s/\s*$//
  s/\s*$//
endfunction

nnoremap <Leader>dw :call DeleteTrailingWhitespace()<CR>
vnoremap <Leader>dw :call DeleteTrailingWhitespace()<CR>

" Disable auto-commenting next line
" See: https://superuser.com/questions/271023/can-i-disable-continuation-of-comments-to-the-next-line-in-vim
:set formatoptions-=cro

au InsertEnter * hi StatusLine ctermfg=red ctermbg=white
au InsertEnter * hi VertSplit ctermfg=red ctermbg=white
au InsertLeave * hi StatusLine ctermfg=NONE ctermbg=NONE
au InsertLeave * hi VertSplit ctermfg=NONE ctermbg=NONE

nnoremap <leader>on :NERDTreeFocus<CR>
nnoremap <leader>cn :NERDTreeClose<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeDirArrows=0

au BufWritePre * call DeleteTrailingWhitespace()
