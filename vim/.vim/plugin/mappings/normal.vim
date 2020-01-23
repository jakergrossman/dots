" general mappings

" remove trailing whitespace
nnoremap <F5> :let_s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

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
