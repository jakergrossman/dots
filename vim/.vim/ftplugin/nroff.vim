set ts=4 sts=4 sw=4 et tw=60

" preview with groff
nnoremap <f5> :!groff -man -Tascii < % <bar> less<cr><cr>
