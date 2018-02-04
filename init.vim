" General settings {{{

" For the time being, still use the vim folders for everything
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Pathogen automatically loads plugins
execute pathogen#infect()

"Makes editing this file easier
nmap <leader>v :edit /home/angus/.config/nvim/init.vim<CR>

" I like this colorscheme
colorscheme ron
let g:airline_theme="minimalist"

set number 				    " enabling both of these
set relativenumber			" sets the current number as absolute
set tabstop=4				" 4 visual spaces per tab
set expandtab				" tabs are spaces
set incsearch               " show search matches while typing
set linebreak               " intelligent line breaks
set scrolloff=3             " don't let the cursor get to the bottom of the screen
set history=200             " save more ex commands -- memory is cheap
set breakindent             " wrapped text respects indentation
set display=lastline        " show beginning of a line which ends below the screen
set spelllang=en            " I speak english
set wildmenu                " makes tab completion in ex mode better
set undofile                " enable persistent undo
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " how many undos
set undoreload=10000        " number of lines to save for undo
set inccommand=nosplit      " show substitute changes live

" Toggle the undo tree
nnoremap <leader>u :UndotreeToggle<cr>

" I often don't let go of shift in time
command WQ wq
command Wq wq
command W w
command Q q

" Search for word under cursor faster
nnoremap gf <C-W>f
vnoremap gf <C-W>f

" remove highlighting after a search
nnoremap <silent><C-c> :nohls<CR>

" yank should behave like d
map Y y$

" We can use <C-p> and <C-n> to cycle through commands
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" allows folding in init.vim
augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
augroup END

" get vertigo working
nnoremap <silent><Space>j :<C-U>VertigoDown n<CR>
vnoremap <silent><Space>j :<C-U>VertigoDown v<CR>
onoremap <silent><Space>j :<C-U>VertigoDown o<CR>
nnoremap <silent><Space>k :<C-U>VertigoUp n<CR>
vnoremap <silent><Space>k :<C-U>VertigoUp v<CR>
onoremap <silent><Space>k :<C-U>VertigoUp o<CR>

" move by wrapped lines, but only if no count is provided
noremap <silent> <expr> j (v:count? 'j' : 'gj')
noremap <silent> <expr> k (v:count? 'k' : 'gk')

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

" Plugin stuff {{{
"
" this makes vim invoke the appropriate plugin when you open a file with the
" corresponding extension.
filetype plugin indent on

" Vim-latex {{{

" sets grep to always generate a file-name.
set grepprg=grep\ -nH\ $*

" changes the default filetype back to 'tex'
let g:tex_flavor='latex'

" }}}

" Ultisnips {{{

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsEditSplit="vertical"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"

" }}}

" {{{ fim-fugitive

" :Gcommit doesn't work in nvim -- temporary hack
if (len($SECURITYSESSIONID) || len($DISPLAY)) && empty($SSH_ASKPASS)
  let s:gui_askpass = system("git --exec-path")[0:-2] . "/git-gui--askpass"
  if executable(s:gui_askpass)
    let $SSH_ASKPASS = s:gui_askpass
  elseif executable("ssh-askpass")
    let $SSH_ASKPASS = "ssh-askpass"
  endif
endif

" }}}

" {{{ ack.vim

" Use ag instead, which is better
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" }}}

" Tells vim to search working directory for a .vimrc
" useful for project-specific settings
set exrc

" Don't allow external commands to change important settings
set secure
