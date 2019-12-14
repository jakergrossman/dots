" borrowed from https://www.github.com/wincent
scriptencoding utf-8

if has('statusline')
    set statusline=%7*                          " Switch to User7 highlight group
    set statusline+=%{statusline#gutterpadding(1)}
    set statusline+=%n                          " buffer number
    set statusline+=\                           " space
    set statusline+=%*                          " reset highlight group
    set statusline+=%4*                         " Switch to User4 highlight group (powerline arrow)
    set statusline+=                           " powerline arrow
    set statusline+=%*                          " reset highlight group
    set statusline+=\                           " space
    set statusline+=%<                          " truncation point if not enough width available
    set statusline+=%{statusline#fileprefix()}  " relative path to file's dir
    set statusline+=%3*                         " switch to User3 highlight group (bold)
    set statusline+=%t                          " filename
    set statusline+=%*                          " reset highlight group
    set statusline+=\                           " space

    " Needs to be all on one line:
    "   %(                   Start item group.
    "   [                    Left bracket (literal).
    "   %M                   Modified flag: ,+/,- (modified/unmodifiable) or nothing.
    "   %R                   Read-only flag: ,RO or nothing.
    "   %{statusline#ft()}   Filetype (not using %Y because I don't want caps).
    "   %{statusline#fenc()} File-encoding if not UTF-8.
    "   ]                    Right bracket (literal).
    "   %)                   End item group.
    set statusline+=%([%M%R%{statusline#ft()}%{statusline#fenc()}]%)

    set statusline+=%=   " Split point for left and right groups.

    set statusline+=\    " Space.
    set statusline+=    " Powerline arrow.
    set statusline+=%5*  " Switch to User5 highlight group.
    set statusline+=\    " Space.
    set statusline+=ℓ    " (Literal, \u2113 "SCRIPT SMALL L").
    set statusline+=\    " Space.
    set statusline+=%l   " Current line number.
    set statusline+=/    " Separator.
    set statusline+=%L   " Number of lines in buffer.
    set statusline+=\    " Space.
    set statusline+=𝚌    " (Literal, \u1d68c "MATHEMATICAL MONOSPACE SMALL C").
    set statusline+=\    " Space.
    set statusline+=%v   " Current virtual column number.
    set statusline+=\    " Space.
    set statusline+=%*   " Reset highlight group.
    set statusline+=%6*  " Switch to User6 highlight group.
    set statusline+=%*   " Reset highlight group.

    if has('autocmd')
        augroup JakeStatusLine
            autocmd!
            autocmd ColorScheme * call statusline#update_highlight()
        augroup END
    endif
endif
