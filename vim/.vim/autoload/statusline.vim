" return padding required to not be under gutter
function! statusline#outerpadding() abort
    " width of gutter
    let l:gutterWidth=max([strlen(line('$')) + 1, &numberwidth])

    " calculate number of digits in largest line number
    let l:lnumWidth=1

    let l:largestLineNum=line('$')
    while l:largestLineNum > 10
        let l:lnumWidth+=1
        let l:largestLineNum/=10
    endwhile

    " generate padding (gutterWidth + lnumWidth)
    let l:padding=repeat(' ', l:gutterWidth + l:lnumWidth)
    return l:padding
endfunction

" relative path of current file
function! statusline#relpath() abort
    let l:basename=expand('%:.')
    if l:basename == '' || l:basename == '.'
        return ''
    else
        " Make sure we show $HOME as ~.
        return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
    endif
endfunction

" file encoding if not utf-8, else empty string
function! statusline#fenc() abort
    if strlen(&fenc) && &fenc !=# 'utf-8'
        return ',' . &fenc
    else
        return ''
    endif
endfunction
