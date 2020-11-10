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

" Escape text for use in a URL
" TODO: Is this all required symbols?
function! functions#url_escape(text) abort
    " it is important that % is first
    " otherwise, previously escaped characters
    " will have their % escaped
    let conversion_table = [
                \ ['%', '%25'],
                \ ['#', '%23'],
                \ ['$', '%24'],
                \ ['&', '%26'],
                \ ['''', '%27'],
                \ ['(', '%28'],
                \ [')', '%29'],
                \ ['*', '%2A'],
                \ ['+', '%2B'],
                \ [',', '%2C'],
                \ ['-', '%2D'],
                \ ['/', '%2F'],
                \ [':', '%3A'],
                \ [';', '%3B'],
                \ ['<', '%3C'],
                \ ['=', '%3D'],
                \ ['>', '%3E'],
                \ ['?', '%3F'],
                \ ['@', '%40'],
                \ ['[', '%5B'],
                \ ['\', '%5C'],
                \ [']', '%5D'],
                \ ['^', '%5E'],
                \ ['`', '%60'],
                \ ['{', '%7B'],
                \ ['|', '%7C'],
                \ ['}', '%7D'],
                \ ['~', '%7E'],
            \ ]

    let escaped_text = a:text

    " escape any special characters
    for c in conversion_table
        let escaped_text = substitute(escaped_text, '\v\' . c[0], c[1], 'g')
    endfor

    return escaped_text
endfunction

" find the URL for a specified tag on Vimhelp.org
function! functions#vimhelp_url(tag) abort
    " open help for tag
    try
        exec 'silent help ' . a:tag
    catch /^Vim\%((\a\+)\)\=:/
        " 'Error' message on single line
        echohl ErrorMsg
        unsilent echomsg substitute(v:exception, '^\CVim\%((\a\+)\)\=:', '', '')
        echohl None
        return
    endtry

    " get name of doc file
    let doc_file=expand('%:t')

    " grab found tag text (may be different than a:tag)
    let tag_text=expand('<cword>')

    " escape for use in URL
    let tag_text=functions#url_escape(tag_text)

    " close help window
    close

    " construct and return URL
    return 'https://vimhelp.org/' . doc_file . '.html#' . tag_text
endfunction

" Corresponding function for :TagURL command
function! functions#tag_url_c(tag) abort
    let URL = functions#vimhelp_url(a:tag)

    " only update clipboard for a successful search
    if URL != ''
        let @+ = URL
    endif
endfunction
