" General settings {{{

" Pathogen automatically loads plugins
execute pathogen#infect()

"Makes editing this file easier
nmap <leader>v :edit ~/.vimrc<CR>

set number 				    " enabling both of these
set relativenumber			" sets the current number as absolute

set tabstop=4				" 4 visual spaces per tab
set expandtab				" tabs are spaces

set incsearch               " show search matches while typing 
set nocompatible            " enter the current millenium

set linebreak               " intelligent line breaks

set scrolloff=3             " Don't let the cursor get to the bottom of the screen

" Search for word under cursor faster
nnoremap gf <C-W>f      
vnoremap gf <C-W>f

" remove highlighting after a search
nnoremap <silent><leader>c :nohls<CR> 

" yank should behave like d
map Y y$

" Adds dictionaries so vim can autocomplete better
au FileType * exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))



" allows folding in .vimrc
augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" No longer used settings {{{

" set shellcmdflag=-c       " Read .bashrc to get aliases
" set clipboard=unnamedplus  " Yank to system clipboard
" noremap  <buffer> <silent> k gk
" noremap  <buffer> <silent> j gj
" noremap  <buffer> <silent> 0 g0
" noremap  <buffer> <silent> $ g$
" let g:netrw_banner = 0    " Get rid of horrible netrw banner 

" set iskeyword+=/          " Tells vim to include 
" set iskeyword+=<
" set iskeyword+=+
" set iskeyword+=>

" " add a statusbar showing git status at the bottom of vim
" set laststatus=2
" set statusline+=%{fugitive#statusline()}
" }}}

" Vim-latex stuff {{{

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a single file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Add my custom commands
let g:Tex_Com_pder = "\\pder{<++>}{<+>}<++>"
let g:Tex_Com_tder = "\\tder{<++>}{<+>}<++>"
let g:Tex_Env_equation = "\\begin{equation}\<CR><++>\<CR>\\end{equation}<++>"

" Black magic to get alt key combinations working
let c='a'
   while c <= 'z'
     exec "set <A-".c.">=\e".c
     exec "imap \e".c." <A-".c.">"
     let c = nr2char(1+char2nr(c))
   endw
   set timeout ttimeoutlen=50
" }}}
