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

" adds 'jump to last/next line with current indentation' shortcut
nnoremap <silent><C-n> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <silent><C-n> :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>

" makes editing this file easier
nmap <leader>e :edit ~/.vim/ftplugin/tex.vim<CR>

" augment surround.vim for latex commands
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

" sometimes I don't want to move using visual lines
nnoremap gj j
nnoremap gk k

" }}}

" User-defined vim-latex shortcuts {{{

call IMAP('<<', "\\left\\langle <++> \\right\\rangle<++>", 'tex')
call IMAP('ARR', "\\arrow[<++>]<++>", 'tex')
call IMAP('DEF', "\\defn{<++>}<++>", 'tex')
call IMAP('EA*', "\\begin{eqnarray*}\<CR><++>\<CR>\\end{eqnarray*}<++>", 'tex')
call IMAP('ECD', "\<CR>\\begin{centering}\<CR>\<CR>\\begin{tikzcd}\<CR><++>\<CR>\\end{tikzcd}\<CR>\<CR>\\end{centering}\<CR>", 'tex')
call IMAP('ECO', "\\begin{corollary}\<CR><++>\<CR>\\end{corollary}<++>", 'tex')
call IMAP('EDF', "\\begin{definition}[<++>]\<CR>\\label{<++>}\<CR><++>\<CR>\\end{definition}<++>", 'tex')
call IMAP('EE*', "\\begin{equation*}\<CR><++>\<CR>\\end{equation*}<++>", 'tex')
call IMAP('EEG', "\\begin{example}\<CR><++>\<CR>\\end{example}", 'tex')
call IMAP('EFE', "\\begin{frame}\<CR>\\setbeamercovered{dynamic}\<CR>\\frametitle{<++>}\<CR><++>\<CR>\\end{frame}<++>", 'tex')
call IMAP('EHR', "\\hyperref[<++>]{<++> \\ref*{<++>}}<++>", 'tex')
call IMAP('EL*', "\\begin{align*}\<CR><++>\<CR>\\end{align*}<++>", 'tex')
call IMAP('ELM', "\\begin{lemma}\<CR><++>\<CR>\\end{lemma}<++>", 'tex')
call IMAP('EML', "\\begin{multline}\<CR><++>\<CR>\\end{multline}<++>", 'tex')
call IMAP('EPM', "\\begin{pmatrix}\<CR><++>\<CR>\\end{pmatrix}<++>", 'tex')
call IMAP('EPR', "\\begin{proof}\<CR><++>\<CR>\\end{proof}<++>", 'tex')
call IMAP('EQU', "\\begin{quote}\<CR><++>\<CR>\\end{quote}", 'tex')
call IMAP('ETH', "\\begin{theorem}\<CR><++>\<CR>\\end{theorem}<++>", 'tex')
call IMAP('EVM', "\\begin{vmatrix}\<CR><++>\<CR>\\end{vmatrix}<++>", 'tex')
call IMAP('MBB', "\\mathbb{<++>}<++>", 'tex')
call IMAP('MBF', "\\mathbf{<++>}<++>", 'tex')
call IMAP('MCA', "\\begin{cases}\<CR><++>\<CR>\\end{cases}<++>", 'tex')
call IMAP('MCL', "\\mathcal{<++>}<++>", 'tex')
call IMAP('MFK', "\\mathfrak{<++>}<++>", 'tex')
call IMAP('MM*', "\\begin{multline*}\<CR><++>\<CR>\\end{multline*}<++>", 'tex')
call IMAP('MPD', "\\pder{<++>}{<++>}<++>", 'tex')
call IMAP('MRM', "\\mathrm{<++>}<++>", 'tex')
call IMAP('MSC', "\\mathscr{<++>}<++>", 'tex')
call IMAP('MSF', "\\mathsf{<++>}<++>", 'tex')
call IMAP('MTD', "\\tder{<++>}{<++>}<++>", 'tex')
call IMAP('MTE', "\\text{<++>}<++>", 'tex')
call IMAP('MTN', "\\tensor{<++>}{<++>}<++>", 'tex')
call IMAP('` ', "\\qquad", 'tex')
call IMAP('`%', "\\tfrac{<++>}{<++>}<++>", 'tex')
call IMAP('`>', "\\vec{<++>}<++>", 'tex')
call IMAP('||', "\\left|<++>\\right|<++>", 'tex')


"IMAP can't map `. for some bizzare reason
inoremap `. \cdot

" }}}

" I don't like some of vim-latex's defaults {{{
call IMAP('`e', "\\epsilon<++>", 'tex')
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
