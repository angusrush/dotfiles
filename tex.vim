" set indent to 2 spaces
set sw=2

" maplocalleader is also space
let maplocalleader = "\<Space>"

" Zathura settings
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_method='zathura'
let g:vimtex_compiler_progname = 'nvr'

" Tweak a few compiler settings
let g:vimtex_compiler_latexmk = {
      \ 'backend' : 'nvim',
      \ 'background' : 1,
      \ 'build_dir' : '',
      \ 'callback' : 1,
      \ 'continuous' : 1,
      \ 'executable' : 'latexmk',
      \ 'options' : [
      \   '-pdf',
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ],
      \}


" Disable overfull/underfull \hbox and all package warnings
let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \}
" one-shot compilation
nnoremap <leader>ls :call vimtex#compiler#compile_ss()<CR>

" augment surround.vim for latex commands
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
let g:surround_{char2nr('q')} = "`\r'"
let g:surround_{char2nr('Q')} = "``\r''"

" sometimes I don't want to move using visual lines
nnoremap gj j
nnoremap gk k

" compile current document on angus-server
nnoremap <leader>lr :Dispatch!<CR>
let b:dispatch = 'server-compile %:r'

" Make latex highlighting a bit more interesting
highlight link texBeginEndModifier texDocTypeArgs
highlight link texBeginEndName String
highlight link texInputFile String
highlight link texInputFileOpt Number
highlight link texMathMatcher String
highlight link texMatcher String
highlight link texMatcherNM String
highlight link texOnlyMath healthError

" Reformat lines (getting the spacing correct) {{{
fun! TeX_fmt()
  if (getline(".") != "")
    let save_cursor = getpos(".")
    let op_wrapscan = &wrapscan
    set nowrapscan
    let par_begin = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
    let par_end   = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
    try
      exe '?'.par_begin.'?+'
    catch /E384/
      1
    endtry
    norm V
    try
      exe '/'.par_end.'/-'
    catch /E385/
      $
    endtry
    norm gq
    let &wrapscan = op_wrapscan
    call setpos('.', save_cursor)
  endif
endfun

nmap Q :call TeX_fmt()<CR>

" }}}
