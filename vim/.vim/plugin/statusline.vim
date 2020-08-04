if has("statusline")
    set statusline=""                             " clear statusline

    set statusline+=%{statusline#outerpadding()}  " leading space
    set statusline+=%{statusline#relpath()}       " relative path to file
    set statusline+=\                             " space

    " File type and encoding (needs to be all one line):
    " %(                   " start item group
    " [                    " left bracket (literal)
    " %Y                   " filetype
    " %M                   " modified flag: ,+/,- (modified/unmodifiable)
    " %R                   " read-only flag: ,RO
    " %{statusline#fenc()} " file encoding if not UTF-8
    " ]                    " right bracket (literal)
    " %)                   " end item group
    set statusline+=%([%Y%M%R%{statusline#fenc()}]%)

    set statusline+=%=                           " split point for left and right
    set statusline+=l                            " l (literal)
    set statusline+=[                            " left bracket
    set statusline+=%l                           " current line number
    set statusline+=/                            " separator
    set statusline+=%L                           " total lines in file
    set statusline+=]                            " right bracket
    set statusline+=\                            " space
    set statusline+=c                            " c (literal)
    set statusline+=[                            " left bracket
    set statusline+=%v                           " virtual column number
    set statusline+=]                            " right bracket
    set statusline+=%{statusline#outerpadding()} " outer padding
endif
