" General settings {{{
" This is mostly a matter of taste, but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" This is to get forward/reverse search working with Okular
let g:Tex_CompileRule_dvi = 'latex -src-specials -synctex=1 -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf = 'pdflatex -src-specials -synctex=1 -interaction=nonstopmode $*'
" }}}

" User-defined vim-latex shortcuts {{{
call IMAP('<<', "\\left\\langle <++> \\right\\rangle<++>", 'tex')
call IMAP('EA*', "\\begin{eqnarray*}\<CR><++>\<CR>\\end{eqnarray*}<++>", 'tex')
call IMAP('EE*', "\\begin{equation*}\<CR><++>\<CR>\\end{equation*}<++>", 'tex')
call IMAP('EFE', "\\begin{frame}\<CR>\\setbeamercovered{dynamic}\<CR>\\frametitle{<++>}\<CR><++>\<CR>\\end{frame}<++>", 'tex')
call IMAP('EL*', "\\begin{align*}\<CR><++>\<CR>\\end{align*}<++>", 'tex')
call IMAP('EPM', "\\begin{pmatrix}\<CR><++>\<CR>\\end{pmatrix}<++>", 'tex')
call IMAP('MBB', "\\mathbb{<++>}<++>", 'tex')
call IMAP('MBF', "\\mathbf{<++>}<++>", 'tex')
call IMAP('MCA', "\\begin{cases}\<CR><++>\<CR>\\end{cases}<++>", 'tex')
call IMAP('MCL', "\\mathcal{<++>}<++>", 'tex')
call IMAP('MM*', "\\begin{multline*}\<CR><++>\<CR>\\end{multline*}<++>", 'tex')
call IMAP('MMF', "\\mathfrak{<++>}<++>", 'tex')
call IMAP('MML', "\\begin{multline}\<CR><++>\<CR>\\end{multline}<++>", 'tex')
call IMAP('MPD', "\\pder{<++>}{<++>}<++>", 'tex')
call IMAP('MSC', "\\mathscr{<++>}<++>", 'tex')
call IMAP('MTD', "\\tder{<++>}{<++>}<++>", 'tex')
call IMAP('MTE', "\\text{<++>}<++>", 'tex')
call IMAP('MTN', "\\tensor{<++>}{<++>}<++>", 'tex')
call IMAP('`%', "\\tfrac{<++>}{<++>}<++>", 'tex')
call IMAP('`>', "\\vec{<++>}<++>", 'tex')
call IMAP('`f', "\\phi<++>", 'tex')
call IMAP('` ', "\\qquad", 'tex')
call IMAP('||', "\\left|<++>\\right|<++>", 'tex')

"IMAP can't map `. for some bizzare reason
inoremap `. \cdot 

"Makes editing this file easier
nmap <leader>e :edit ~/.vim/ftplugin/tex.vim<CR>

" }}}

" Custom functions {{{

" This redefines a new forward search command, <leader>f, which actually works
function! SyncTexForward()
        "     let execstr = "silent !okular --unique %:p:r.dvi\\#src:".line(".")."%:p &"
        let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
        exec execstr
        exec "redraw!"
endfunction
nmap <Leader>f :call SyncTexForward()<CR>
" }}}
