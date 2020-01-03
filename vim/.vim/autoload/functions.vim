" creates a new note with the current timestamp, inspired by https://vimways.org/2019/personal-notetaking-in-vim/
function! functions#edit(...)
    " build the file name
    let l:sep=''
    if len(a:000) > 0
        let l:sep='-'
    endif
    let l:fname=expand('%:p:h') . '/' . strftime("%F-%H%M") . l:sep . join(a:000, '-') . '.md'

    " edit the new file
    exec "e " . l:fname

    " enter the title and timestamp in the new file
    if len(a:000) > 0 " arguments exist
        let l:sep=' '
    else
        let l:sep=''
    endif

    " build header
    let l:header=strftime('%Y-%m-%d %H:%M') . l:sep . join(a:000, l:sep)

    " write header to first line of file
    exec "call setline('.', '" . l:header . "')"
endfunc
