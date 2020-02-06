" open last buffer
nnoremap <Leader><Leader> <C-^>

nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" <LocalLeader>e -- Edit new file in same dir as current file
nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>

" open file under cursor with default application
nnoremap <Leader>O :!open <cfile><CR>

" create file if not exist
nnoremap <Leader>gf :e <cfile><CR>

" list buffers
nnoremap <Leader>b :ls <CR>

" go to previous buffer
nnoremap <Leader>p :bprev<CR>

" go to next buffer
nnoremap <Leader>n :bnext<CR>

" hide current buffer
nnoremap <Leader>h :bunload<CR>

" close current buffer
nnoremap <Leader><BS> :bdelete<CR>

" turn off highlight
nnoremap <Leader>i :nohl<CR>

" emmet expand abbreviation
nmap <Leader>e $<Plug>(emmet-expand-abbr)
vmap <Leader>e $<Plug>(emmet-expand-abbr)

" copy to clipboard
nmap <Leader>c "*yy
vmap <Leader>c "*y
