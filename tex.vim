" General settings {{{

" set indent to 2 spaces
set sw=2

" cycle through references
set iskeyword+=:

" compilation rules which ensure that biblatex works correctly
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'ctags -R & pdflatex -shell-escape -src-specials -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_MultipleCompileFormats = 'dvi,pdf'
let g:Tex_BibtexFlavor = 'biber'

" this makes it so vim-latex can indent half-open intervals correctly
let g:tex_indent_brace = 0

" makes editing this file easier
nmap <leader>e :edit ~/.vim/ftplugin/tex.vim<CR>

" makes editing custom shortcuts easier
nmap <leader>s :edit ~/.vim/after/ftplugin/tex.vim<CR>

" augment surround.vim for latex commands
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
let g:surround_{char2nr('q')} = "`\r'"
let g:surround_{char2nr('Q')} = "``\r''"


" sometimes I don't want to move using visual lines
nnoremap gj j
nnoremap gk k

" extra commands for adding arrays of jump points
command! -nargs=* IT call InsertTable(<f-args>)
command! -nargs=* IA call InsertArray(<f-args>)

" }}}

" Custom functions and other long stuff {{{

" adds a text object for latex delimiters
call textobj#user#plugin('bigdelimiters', {
\   'bigdelimiters': {
\     'pattern': ['\\left[(|\[|\|]', '\\right[)|\]|\|]'],
\     'select-a': 'ad',
\     'select-i': 'id',
\   },
\ })

" this redefines a new forward search command, <leader>f, which actually works
function! SyncTexForward()
  let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &>/dev/null &" 
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

" Inserts an array of jump points of size horiz x vert 
function! InsertArray(vert, horiz)
  if  a:vert < 1 || a:horiz < 1
    echoerr "Your matrix won't be big enough!"
    return
  endif

  let l:list = []                     " empty array which will hold lines

  let l:counterHoriz = 0              
  let l:counterVert = 0
  let l:str = ""                      " empty string for lines
  let l:strlast = ""                   " last line will be different from the rest

  while l:counterHoriz < a:horiz - 1      " populate l:str with horiz many jumppoints
    let l:strlast = l:strlast."<++> & "
    let l:counterHoriz += 1
  endwhile
  let l:strlast = l:strlast."<++> "

  let l:str = l:strlast."\\\\"         " add a newline to end of l:str
  while l:counterVert < a:vert - 1     " add l:str to l:list horiz-1 many times
    call add(l:list, l:str)
    let l:counterVert += 1
  endwhile
  call add(l:list, l:strlast)          " add l:strlast at the end
  call append('.', l:list)             " add this to the file

  let l:totlines = a:vert + 1          " indent everything
  execute "normal =".l:totlines."j"
endfunction

" Same as above, but surrounded by \begin{tabular}{ccc...} etc.
function! InsertTable(vert, horiz)
  if  a:vert < 1 || a:horiz < 1
    echoerr "Your matrix won't be big enough!"
    return
  endif

  let l:list = []                     
  let l:args = ""                     
  let l:argcounter = 0

  while l:argcounter < a:horiz                      " populate arg list, e.g. cccc
    let l:args = l:args . "c"
    let l:argcounter += 1
  endwhile

  let l:begintb = "\\begin{tabular}"."{".l:args."}" " create first line of tabular
  call add(l:list, l:begintb)                       " add first line to l:list
  let l:counterHoriz = 0
  let l:counterVert = 0
  let l:str = ""
  let l:strlast = ""

  while l:counterHoriz < a:horiz - 1
    let l:strlast = l:strlast."<++> & "
    let l:counterHoriz += 1
  endwhile
  let l:strlast = l:strlast."<++> "

  let l:str = l:strlast."\\\\"
  while l:counterVert < a:vert - 1
    call add(l:list, l:str)
    let l:counterVert += 1
  endwhile
  call add(l:list, l:strlast)

  call add(l:list, "\\end{tabular}")                " add last line of tabular

  call append('.', l:list)

  let l:totlines = a:vert + 2
  execute "normal =".l:totlines."j"
endfunction

" }}}
"
" User-defined vim-latex shortcuts should be put in
" ~/.vim/after/ftplugin/tex.vim
