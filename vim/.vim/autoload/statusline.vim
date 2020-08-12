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

" status line constructor
function! statusline#get_statusline(is_condensed) abort
    let l:status='%{statusline#outerpadding()}'   " leading space
    let l:status.='%{statusline#relpath()}'       " relative path to file

    if a:is_condensed
        " condensed statusline only has leading space and relative path
        return l:status
    endif

    let l:status.='\ '                            " space

    " File type and encoding (needs to be all one line):
    " %(                   " start item group
    " [                    " left bracket (literal)
    " %Y                   " filetype
    " %M                   " modified flag: ,+/,- (modified/unmodifiable)
    " %R                   " read-only flag: ,RO
    " %{statusline#fenc()} " file encoding if not UTF-8
    " ]                    " right bracket (literal)
    " %)                   " end item group
    let l:status.='%([%Y%M%R%{statusline#fenc()}]%)'

    let l:status.='%='                           " split point for left and right
    let l:status.='\ '                           " space
    let l:status.='l'                            " l (literal)
    let l:status.='['                            " left bracket
    let l:status.='%l'                           " current line number
    let l:status.='/'                            " separator
    let l:status.='%L'                           " total lines in file
    let l:status.=']'                            " right bracket
    let l:status.='\ '                           " space
    let l:status.='\c'                           " c (literal)
    let l:status.='['                            " left bracket
    let l:status.='%v'                           " virtual column number
    let l:status.=']'                            " right bracket
    let l:status.='%{statusline#outerpadding()}' " outer padding

    return l:status
endfunction
