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

set scrolloff=3             " don't let the cursor get to the bottom of the screen

set history=200             " save more ex commands -- memory is cheap

set breakindent             " wrapped text respects indentation
set display=lastline        " show beginning of a line which ends below the screen

set spelllang=en            " I speak english

" Search for word under cursor faster
nnoremap gf <C-W>f      
vnoremap gf <C-W>f

" remove highlighting after a search
nnoremap <silent><leader>c :nohls<CR> 

" yank should behave like d
map Y y$

" Adds dictionaries so vim can autocomplete better
au FileType * exec("setlocal dictionary+=".$HOME."/.vim/dictionaries/".expand('<amatch>'))

" We can use <C-p> and <C-n> to cycle through commands
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" allows folding in .vimrc
augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
augroup END

" get vertigo working
nnoremap <silent> <Space>j :<C-U>VertigoDown n<CR>
vnoremap <silent> <Space>j :<C-U>VertigoDown v<CR>
onoremap <silent> <Space>j :<C-U>VertigoDown o<CR>
nnoremap <silent> <Space>k :<C-U>VertigoUp n<CR>
vnoremap <silent> <Space>k :<C-U>VertigoUp v<CR>
onoremap <silent> <Space>k :<C-U>VertigoUp o<CR>

" move by wrapped lines, but only if no count is provided
noremap <expr> j (v:count? 'j' : 'gj')
noremap <expr> k (v:count? 'k' : 'gk')

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

" A little function to diff swap files
command! DiffAgainstFileOnDisk call DiffAgainstFileOnDisk()

function! DiffAgainstFileOnDisk()
  :w! /tmp/working_copy
  exec "!diff /tmp/working_copy %"
endfunction

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

" this makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" sets grep to always generate a file-name.
set grepprg=grep\ -nH\ $*

" this enables automatic indentation as you type.
filetype indent on

" changes the default filetype back to 'tex'
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
