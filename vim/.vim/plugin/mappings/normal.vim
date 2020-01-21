" general mappings

" remove trailing whitespace
nnoremap <F5> :let_s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" insert empty line with enter
nmap <CR> o<Esc>

" list buffers
nmap <Leader>b :ls <CR>
" go to previous buffer
nmap <Leader>p :bprev<CR>
" go to next buffer
nmap <Leader>n :bnext<CR>
" hide current buffer
nmap <Leader>h :bunload<CR>
" close current buffer
nmap <Leader><BS> :bdelete<CR>

" taboo mappings
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>
nnoremap tn :tabnew<CR>
nnoremap td :tabclose<CR>
nnoremap to :TabooOpen<Space>
nnoremap tr :TabooRename<Space>

" gitgutter mappings
nmap [c <Plug>(GitGutterPrevHunk) " move to last hunk
nmap ]c <Plug>(GitGutterNextHunk) " move to next hunk
