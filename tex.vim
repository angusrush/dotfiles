" set indent to 2 spaces
set sw=2

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
