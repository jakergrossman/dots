function! functions#edit(...)
    " check if a filename was passed as an argument
    let l:has_filename = len(a:000) > 0

    " build the file name
    let l:fname=expand('%:p:h') . '/' . strftime("%F-%H%M")

    if l:has_filename
        let l:fname.=join(a:000, '-')
    endif

    let l:fname.='.md'

    " edit the new file
    exec "e " . l:fname

    " build and write timestamp
    let l:timestamp=strftime('%Y-%m-%d %H:%M')
    exec 'call append(0, "' . l:timestamp . '")'

    if l:has_filename
        " build and write header
        let l:header='# ' . join(a:000, ' ')
        exec 'call append(0, "' . l:header . '")'
    endif
endfunc
