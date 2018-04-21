" General settings {{{

" For the time being, still use the vim folders for everything
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Pathogen automatically loads plugins
execute pathogen#infect()

" Makes editing this file easier
nmap <leader>v :edit /home/angus/.config/nvim/init.vim<CR>

" I like this colorscheme
set termguicolors
let g:nord_comment_brightness = 10
let g:nord_italic = 1
let g:nord_italic_comments = 1
colorscheme nord

" I can't envision a use case for ex mode
nnoremap Q <nop>

set breakindent                " Wrapped text respects indentation
set display=lastline           " Show beginning of a line which ends below the screen
set expandtab				   " Tabs are spaces
set inccommand=nosplit         " Show substitute changes live
set linebreak                  " Intelligent line breaks
set number 				       " Enabling both of these...
set relativenumber			   "     sets the current number as absolute
set scrolloff=3                " Don't let the cursor get to the bottom of the screen
set spelllang=en               " I speak english
set tabstop=4				   " 4 visual spaces per tab
set undodir=$HOME/.vim/undo    " Where to save undo histories
set undofile                   " Enable persistent undo
set undolevels=1000            " How many undos
set undoreload=10000           " Number of lines to save for undo
set mouse=a                    " Mouse wheel should scroll the buffer
set wildmode=longest:list,full " Tab completion should behave like in the terminal

" Terminal mappings
au TermOpen * setlocal nonumber norelativenumber
tnoremap <M-n> <C-\><C-n>
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
tnoremap <M-H> <C-\><C-n><C-w>H
tnoremap <M-J> <C-\><C-n><C-w>J
tnoremap <M-K> <C-\><C-n><C-w>K
tnoremap <M-L> <C-\><C-n><C-w>L

" Buffer navigation mappings
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <M-H> <C-w>H
nnoremap <M-J> <C-w>J
nnoremap <M-K> <C-w>K
nnoremap <M-L> <C-w>L

" Command to get rid of trailing spaces
nnoremap <leader>s :silent! %s/\s\+$//g<CR> :set nohlsearch<CR>

" I often don't let go of shift in time
command WQ wq
command Wq wq
command W w
command Q q

" Search for word under cursor faster
nnoremap gf <C-W>f
vnoremap gf <C-W>f

" Remove highlighting after a search
nnoremap <silent><C-c> :nohls<CR>
inoremap <silent><C-c> <C-o>:nohls<CR>

" Yank should behave like d
map Y y$

" U:se <C-p> and <C-n> to cycle through commands
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Allow folding in init.vim
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" Move by wrapped lines, but only if no count is provided
noremap <silent> <expr> j (v:count? 'j' : 'gj')
noremap <silent> <expr> k (v:count? 'k' : 'gk')

" Set path and wildignore for easy file opening using :find
 set path=~/Dropbox/rc,~/Documents/latex/**
 set wildignore+=*.aux,*.fdb_latexmk,*.fls,*.log,*.out,*.synctex.gz,*.pdf,tags,*.bcf,*.bbl,*.blg*,*.toc,*.run.xml,core,*.dvi,*.orig,*.tkzparfct.gnuplot,*.png,*.jpg
 set wildignorecase

" Leader map for :find
nnoremap <leader>f :find *

" }}}

" Plugin stuff {{{
"
" this makes vim invoke the appropriate plugin when you open a file with the
" corresponding extension.
filetype plugin indent on

" {{{ ack.vim

" Use ag instead, which is better
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" }}}

" {{{ airline

" Use powerline symbols
let g:airline_powerline_fonts = 1

" }}}

" {{{ ale

" map keys to use wrapping.
nnoremap <silent><Leader>ap :ALEPrevious<CR>
nnoremap <silent><Leader>an :ALENext<CR>

"Disabled by default. Toggle with :ALEToggle
let g:ale_enabled=0

let g:ale_sign_warning="⚠"

" only lint when file is saved. Prevents ridiculous slowdown.
let g:ale_lint_on_text_changed = 'never'

let g:ale_linters = {
      \ 'tex':['chktex', 'proselint'],
      \ 'vim':['vint'],
      \}

" }}}

" indentwise {{{

" set up indentwise shortcuts
map [- <Plug>(IndentWisePreviousLesserIndent)
map [= <Plug>(IndentWisePreviousEqualIndent)
map [+ <Plug>(IndentWisePreviousGreaterIndent)
map ]- <Plug>(IndentWiseNextLesserIndent)
map ]= <Plug>(IndentWiseNextEqualIndent)
map ]+ <Plug>(IndentWiseNextGreaterIndent)
map [_ <Plug>(IndentWisePreviousAbsoluteIndent)
map ]_ <Plug>(IndentWiseNextAbsoluteIndent)
map [% <Plug>(IndentWiseBlockScopeBoundaryBegin)
map ]% <Plug>(IndentWiseBlockScopeBoundaryEnd)

" }}}

" UndoTree {{{

" Toggle the undo tree
nnoremap <leader>u :UndotreeToggle<cr>

" }}}

" vertigo {{{

" get vertigo working

nnoremap <silent><Space>j :<C-U>VertigoDown n<CR>
vnoremap <silent><Space>j :<C-U>VertigoDown v<CR>
onoremap <silent><Space>j :<C-U>VertigoDown o<CR>
nnoremap <silent><Space>k :<C-U>VertigoUp n<CR>
vnoremap <silent><Space>k :<C-U>VertigoUp v<CR>
onoremap <silent><Space>k :<C-U>VertigoUp o<CR>

" }}}

" Vimtex {{{

" sets grep to always generate a file-name.
set grepprg=grep\ -nH\ $*

" changes the default filetype back to 'tex'
let g:tex_flavor='latex'

" }}}

" }}}
