" general mappings

" remove trailing whitespace
nnoremap <F5> :let_s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
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
