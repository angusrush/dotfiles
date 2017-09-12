" General settings {{{

" set indent to 2 spaces
set sw=2

" cycle through references
set iskeyword+=:

" this is to get forward/reverse search working with Okular
let g:Tex_CompileRule_dvi = 'latex -src-specials -synctex=1 -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf = 'pdflatex -src-specials -synctex=1 -interaction=nonstopmode $*'

" this makes it so vim-latex can indent half-open intervals correctly
let g:tex_indent_brace = 0

" makes editing this file easier
nmap <leader>e :edit ~/.vim/ftplugin/tex.vim<CR>

" augment surround.vim for latex commands
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

" sometimes I don't want to move using visual lines
nnoremap gj j
nnoremap gk k

" }}}

" I don't like some of vim-latex's defaults {{{
" call IMAP('`e', "\\epsilon<++>", 'tex')
" call IMAP('`f', "\\phi<++>", 'tex')
call IMAP('`w', "\\omega<++>", 'tex')
call IMAP('`:', "\\colon<++>", 'tex')
" }}}

" Custom functions {{{

" this redefines a new forward search command, <leader>f, which actually works
function! SyncTexForward()
  let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
  exec execstr
  exec "redraw!"
endfunction
nmap <Leader>f :call SyncTexForward()<CR>

" adds (not that it works yet) timestamps for TeX files 
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([8, line("$")])
    keepjumps exe '1,' . n . 's#^% Last modified: \zs.*# ' . strftime('%H:%M %A, %-d %B %Y') . '#e'
    call histdel('search', -1)
    keepjumps call setpos('.', save_cursor)
  endif
endfun

autocmd BufWritePre *.tex call LastModified()

" }}}
"
" User-defined vim-latex shortcuts should be put in
" ~/.vim/after/ftplugin/tex.vim
