" General settings {{{

" set indent to 2 spaces
set sw=2

" cycle through references
set iskeyword+=:

" okular is the better viewer
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

" Tweak a few settings
let g:vimtex_compiler_latexmk = {
      \ 'backend' : 'nvim',
      \ 'background' : 1,
      \ 'build_dir' : '',
      \ 'callback' : 1,
      \ 'continuous' : 0,
      \ 'executable' : 'latexmk',
      \ 'options' : [
      \   '-pdf',
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ],
      \}

" load up all theorem-type labels into the quickfix list so I can find what
" I'm looking for
command! Results :Ack! '\\label\{(thm|prop|lemma):' %
"
" augment surround.vim for latex commands
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
let g:surround_{char2nr('q')} = "`\r'"
let g:surround_{char2nr('Q')} = "``\r''"


" makes editing this file easier
nmap <leader>e :edit ~/.vim/ftplugin/tex.vim<CR>

" sometimes I don't want to move using visual lines
nnoremap gj j
nnoremap gk k

" extra commands for adding arrays of jump points
command! -nargs=* IT call InsertTable(<f-args>)
command! -nargs=* IA call InsertArray(<f-args>)

" }}}

" Custom functions and other long stuff {{{

" this redefines a new forward search command, <leader>f, which actually works
function! SyncTexForward()
  let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &>/dev/null &"
  exec execstr
  exec "redraw!"
endfunction
nmap <Leader>f :call SyncTexForward()<CR>

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
