" set indent to 2 spaces
set sw=2

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

" one-shot compilation
nnoremap <leader>ls :call vimtex#compiler#compile_ss()<CR>

" augment surround.vim for latex commands
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
let g:surround_{char2nr('q')} = "`\r'"
let g:surround_{char2nr('Q')} = "``\r''"

" makes editing this file easier
nmap <leader>e :edit ~/.vim/ftplugin/tex.vim<CR>

" sometimes I don't want to move using visual lines
nnoremap gj j
nnoremap gk k

